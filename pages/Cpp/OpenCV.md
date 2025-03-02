---
title: OpenCV メモ
---

## 概要

[samples/cpp/kalman.cpp](https://docs.opencv.org/trunk/de/d70/samples_2cpp_2kalman_8cpp-example.html#a12) の解説.

OpenCV の使い方の基本説明.

## コード内容

### ヘッダ

- 一部翻訳
- 2次元座標上の点のためのクラステンプレート [Point_](http://opencv.jp/opencv-2.1/cpp/basic_structures.html) を利用

    ```cpp
    typedef Point_<float> Point2f;
    ```

- ソースコード内容

    ```cpp
    #include "opencv2/video/tracking.hpp"
    #include "opencv2/highgui.hpp"

    #include <stdio.h>

    using namespace cv;

    static inline Point calcPoint(Point2f center, double R, double angle)
    {
        return center + Point2f(
                (float)cos(angle), (float)-sin(angle)
            ) * (float)R;
    }

    static void help()
    {
        printf( "\nこの例では OpenCV のカルマンフィルタを呼び出します.\n"
    "   回転する点をトラッキングします.\n"
    "   回転速度は一定です.\n"
    "   状態および観測ベクトルは共に1次元(点の角度)で,\n"
    "   測定値は真の点の角度にガウス雑音を加えたものになっています.\n"
    "   真の点と推定点は黄色の線分で繋がれ,\n"
    "   真の点と観測点は赤の線分で繋がれます.\n"
    "   (カルマンフィルタが正常に作動した場合,\n"
    "   黄色い線分は赤の線分よりも短くなるはずです.)\n"
                "\n"
    "   (ESC 以外の)任意のキーを入力するとリセットを行い, トラッキング速度を変更します.\n"
    "   ESC を入力するとプログラムを終了します.\n"
                );
    }
    ```

### 各種宣言

- [cv::Mat](http://opencv.jp/cookbook/opencv_mat.html)
：画像を管理する構造体 "兼"　行列を管理する構造体
  - [cv::Mat のタイプ一覧](https://tech-blog.s-yoshiki.com/entry/76)
  - CV_8U：符号なしの8ビット整数
  - CV_8UC3：3個の CV_8U カラー画像の初期値
  - CV_32F：浮動小数点数，32ビット
- ソースコード内容

    ```cpp
    int main(int, char**)
    {
        help();
        // Mat をカラー画像として利用
        Mat img(500, 500, CV_8UC3);
        KalmanFilter KF(2, 1, 0);
        // Mat を2次元ベクトルとして利用
        Mat state(2, 1, CV_32F); /* (phi, delta_phi) */
        Mat processNoise(2, 1, CV_32F);
        Mat measurement = Mat::zeros(1, 1, CV_32F);
        char code = (char)-1;
    ```

### 初期化

- [cv::randn](http://opencv.jp/opencv-2svn/cpp/operations_on_arrays.html#cv-randn)
：正規分布する乱数で配列を埋める
- [cv::setIdentity](http://opencv.jp/opencv-2svn/cpp/operations_on_arrays.html#cv-setidentity)
：行列を定数倍した単位行列として初期化
- ソースコード内容

    ```cpp
    for(;;)
    {
        // 乱数で初期化
        randn( state, Scalar::all(0), Scalar::all(0.1) );
        // カルマンフィルタの遷移行列を定義
        KF.transitionMatrix = (Mat_<float>(2, 2) << 1, 1, 0, 1);
        // 定数で初期化
        setIdentity(KF.measurementMatrix);
        setIdentity(KF.processNoiseCov, Scalar::all(1e-5));
        setIdentity(KF.measurementNoiseCov, Scalar::all(1e-1));
        setIdentity(KF.errorCovPost, Scalar::all(1));
        randn(KF.statePost, Scalar::all(0), Scalar::all(0.1));
        for(;;)
        {
           ...
        }

        // 終了に使うキー. 27 は Esc キー.
        if( code == 27 || code == 'q' || code == 'Q' )
            break;
    }

    return 0;
    ```

### ループ内処理：計算処理

- [KalmanFilter Class](https://docs.opencv.org/trunk/dd/d6a/classcv_1_1KalmanFilter.html)
：詳細はマニュアル参照
- [cv::Mat:p:at](http://opencv.jp/opencv-2svn/cpp/basic_structures.html#cv-mat-athttp://opencv.jp/opencv-2svn/cpp/basic_structures.html#cv-mat-at)
：要素にアクセス
- [cv::Mat.rows, cols](http://opencv.jp/opencv-2svn/cpp/basic_structures.html#mat)
：行数・列数
- ソースコード内容

    ```cpp
    // 回転中心を設定
    Point2f center(img.cols*0.5f, img.rows*0.5f);
    float R = img.cols/3.f;
    double stateAngle = state.at<float>(0);
    Point statePt = calcPoint(center, R, stateAngle);

    Mat prediction = KF.predict();
    double predictAngle = prediction.at<float>(0);
    Point predictPt = calcPoint(center, R, predictAngle);

    randn( measurement, Scalar::all(0), 
        calar::all(KF.measurementNoiseCov.at<float>(0))
    );

    // generate measurement
    measurement += KF.measurementMatrix*state;
    double measAngle = measurement.at<float>(0);
    Point measPt = calcPoint(center, R, measAngle);
    ```

### ループ内処理：マクロ定義

- [cv::line](http://opencv.jp/opencv-2svn/cpp/drawing_functions.html#cv-line)
：2点を結ぶ線分を描画
- ソースコード内容

    ```cpp
    #define drawCross( center, color, d)                \
        line(img, Point( center.x - d, center.y - d ),  \
                  Point( center.x + d, center.y + d ),  \
                  color, 1, LINE_AA, 0); \
        line(img, Point( center.x + d, center.y - d ),  \
                  Point( center.x - d, center.y + d ),  \
                  color, 1, LINE_AA, 0 )                 
    ```

### ループ内処理：描画

- [cv::theRNG](http://opencv.jp/opencv-2svn/cpp/core_operations_on_arrays.html#cv-therng)
：デフォルトの乱数生成器
- [cv::imshow](http://opencv.jp/opencv-2.1/cpp/user_interface.html#cv-imshow)
：指定したウィンドウ内に画像を表示
- [cv::waitKey](http://opencv.jp/opencv-2.1/cpp/user_interface.html#cv-waitkey)
：キーが押されるまで待機
- ソースコード内容

    ```cpp
    // 画面クリア
    img = Scalar::all(0);
    // 点をバツ印で描画
    drawCross( statePt, Scalar(255,255,255), 3 );
    drawCross( measPt, Scalar(0,0,255), 3 );
    drawCross( predictPt, Scalar(0,255,0), 3 );
    // 点の間に線分を描画
    line( img, statePt, measPt, Scalar(0,0,255), 3, LINE_AA, 0 );
    line( img, statePt, predictPt, Scalar(0,255,255), 3, LINE_AA, 0 );

    // 確率的にフィルタリング実施
    if(theRNG().uniform(0,4) != 0)
        KF.correct(measurement);

    // 確率的な状態遷移
    randn( processNoise, Scalar(0), Scalar::all(sqrt(KF.processNoiseCov.at<float>(0, 0))));
    state = KF.transitionMatrix*state + processNoise;

    // 描画
    imshow( "Kalman", img );
    // リフレッシュレート設定
    code = (char)waitKey(100);
    if( code > 0 )
        break;
    ```
