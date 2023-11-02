---
title: HPC メモ
---

## Slurm

Simple Linux Utility for Resource Management

### ステータス確認

```bash
# ノードのスペック確認
scontrol show node
# ノードの状態確認
nice watch -n 10 sinfo
# ノード障害の原因確認
sinfo -R
# キューの状態確認
# cf. https://slurm.schedmd.com/squeue.html
nice watch -n 2 squeue --format=\"%.7i %.9P %.8j %.8u %.2t %.10M %.12N %.5C %22.b\"
```

### ジョブ投入

- インタラクティブ実行: [srun](https://slurm.schedmd.com/srun.html)
- ノンインタラクティブ実行: [sbatch](https://slurm.schedmd.com/sbatch.html)

srun の例

```bash
srun --job-name=train --partition=part01 --nodelist=node01 \
  --gres gpu:2 --cpus-per-task=4 --output="logs/train.log" \
  bash train.sh &
```

sbatch の例: `sbatch -vv sbatch.sh`

```bash
#!/bin/bash
#SBATCH --job-name=train
#SBATCH --cpus-per-task 8
#SBATCH --gres gpu:2
#SBATCH --partition=part01
#SBATCH --output=logs/train.log
#SBATCH --exclusive

module load cuda 12.2
module load cuda 12.2/cudnn

eval "$(conda shell.bash hook)"
conda activate torch

srun python train.py
```

## マルチコア/GPU 処理

- OpenMP: マルチコア処理
  - GCC でも標準搭載
- OpenACC: (シングル)GPU処理
  - コンパイラは [NVIDIA HPC SDK](https://developer.nvidia.com/hpc-sdk) の nvc++ を使用すること

[CMake を用いた実装例](https://github.com/applejxd/point-cloud-analysis/tree/main/pybind)

## マルチ GPU 処理

- [PyTorch Distributed Data Parallel](https://pytorch.org/tutorials/intermediate/ddp_tutorial.html)
  - [Data Parallel より高速](https://qiita.com/fam_taro/items/df6061b589c3ccf86089)
  - [実装例](https://qiita.com/meshidenn/items/1f50246cca075fa0fce2)
  - [Torch.Distributed](https://pytorch.org/docs/stable/distributed.html)

## 並列コンピュータ処理

- [OpenMPI](https://qiita.com/kkk627/items/49c9c35301465f6780fa)
