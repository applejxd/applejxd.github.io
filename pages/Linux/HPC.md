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
nice watch -n 2 squeue --format=\"%.7i %.9P %.8j %.8u %.2t %.10M %.12N %.5C %.15B\"
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

### Tips

- マルチプログラミングのパラダイムの基礎
  - [構成単位はジョブ・ステップ・タスク](https://stackoverflow.com/questions/46506784/how-do-the-terms-job-task-and-step-relate-to-each-other)
    - `sbatch`でジョブ作成・バッチ内の `srun` で新規ステップ作成
    - `sbatch`で複数のジョブを作成する場合は以降のアレイジョブを参照
    - ステップ毎に複数のタスクを持つ・タスクごとに複数のCPUを割り当てることができる
    - [複数のタスク数は例えば複数のバックグラウンド処理の分配に影響](https://stackoverflow.com/questions/39186698/what-does-the-ntasks-or-n-tasks-does-in-slurm)
  - ジョブ->ステップの順でリソース(ノード数・タスク数・CPU数・GPU数等)確保
    1. sbatch の実行対象スクリプトの `#SBATCH` ディレクティブで"ジョブ全体"のリソースを確保
    2. 上記スクリプト内の srun で"各ステップのリソース"を確保。必要に応じて"各タスクに割り当てるリソース"も指定。
    3. 各ステップをバックグラウンド実行(&)する場合は slurm 側でリソース(タスク数・CPU数等)が適宜管理される
- [GPU の割当](https://slurm.schedmd.com/gres.html#Running_Jobs)
  - 各ノードで確保するGPU数は `--gres` or `--gpus-per-node` で確保(`#SBATCH`で指定)
  - 各ジョブで確保するGPU数は `--gpus` で確保(`#SBATCH`で指定・アレイジョブの場合)
  - 各タスクで確保するGPU数は `--gpus-per-task` で確保する(`srun`で指定)
- [アレイジョブによる実行](https://web.kudpc.kyoto-u.ac.jp/manual/ja/run/tips#arrayjob)
  - [公式ドキュメントの解説](https://slurm.schedmd.com/job_array.html)
  - [-a オプション](https://slurm.schedmd.com/sbatch.html#OPT_array)で実行
  - インデックスは```${SLURM_ARRAY_TASK_ID}```で参照可能
  - 投げられたジョブは ```(ジョブID)_(タスクID)``` となり ```scancel (ジョブID)``` で一括終了ができる
  - 複数の configuration で実行する際に便利

## Environment Modules

- [Environment Modules](https://modules.sourceforge.net/)
  - [環境構築と設定の例](https://qiita.com/Ag_smith/items/f268ad27165a60aecd35)

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
  - バックエンドを NCCL にする場合は環境構築が必要
  - [Difference between two kinds of distributed training paradigm](https://discuss.pytorch.org/t/difference-between-two-kinds-of-distributed-training-paradigm/152293)
- [node, world, and local and global rank](https://stackoverflow.com/questions/58271635/in-distributed-computing-what-are-world-size-and-rank)

## 並列コンピュータ処理

- [OpenMPI](https://qiita.com/kkk627/items/49c9c35301465f6780fa)
