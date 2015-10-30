---
layout: slide
title: call_cvr_prediction_model_from_perl
---

### PerlからPythonのCVR予測モデルを呼び出す

---
### 背景
- - -

* AI入札
  - CVR予測値, CTR予測値から入札単価を決定する

---
### 背景
- - -

* 実装
  - Bypassの集計バッチ等はPerlで実装されている
  - 一方、CVR予測モデルはPythonで実装されている

#### ＿人人人人＿
#### ＞死の予感＜
#### ￣Y^Y^Y^Y^￣

---
### CVR予測モデルとは
- - -

* CVRを予測するための要素(**特徴**という)からCVRを予測
  - 案件、案件の業種、etc...
  - 枠、枠のカテゴリ、etc...
[](TODO: モデリングという言葉を入れたい)

* モデルとは
  - 特徴を引数に渡すと予測値を返す関数のようなもの

* ここでの「予測」は統計的予測
  - 過去こういう傾向があったから  
    直近の未来もその傾向があるだろう
  - 未来予知ではない

---
### scikit-learn
- - -

* CVR予測モデル作成にはscikit-learnを使用
[](TODO: scikit-learnの画像貼る)

* scikit-learnとは
  - どちらかというと研究用途
  - 基本的に1ノード1プロセス1スレッド
  - 行列演算、誤差関数の最適化等は  
    Cで記述されたライブラリを使用

---
### CVR予測モデル作成
- - -

* 処理フロー
  - scikit-learnでCVR予測モデルを作成
  - モデルをserializeしディスクに保存
  - 全バッチサーバにscp
  - 各サーバでのバッチ実行時に  
    モデルをdeserialize、予測値を問い合わせる

---
### 最初に書いたコード
- - -

```perl
# 標準出力経由で予測値の文字列を受け取る
my $cvr = `python3 get_predicted_cvr.py '13,57062'`;
```

```python
if __name__ == '__main__':
  # 特徴をコマンドライン引数で受け取る
  feature_str = sys.argv[1]
  # ディスクからモデルを読み出す
  cvr_pred_model = load_model()
  # 特徴をモデルに渡し予測CVRを取得
  predicted_cvr = cvr_pred_model.predict(feature_str)
  # 標準出力
  print(predicted_cvr)
```

---
### 問題点
- - -

* CVR予測値取得のたびにモデルをディスクから読む
  - 約1秒

# 死

---
### 解決
- - -

* モデルは最初にメモリに読み込んでおきたいよね
  - でも違う言語間でどうやって？
  - じゃあCVR予測値取得用のサーバ立てよう

---
### クライアント(Perl)
- - -

```perl
my $port = 49152;
my $pid = fork();
if ($pid == 0) {    # 子プロセスでサーバ起動
    system("python3 start_server.py $port");
    exit;
}
# サーバに接続
sleep(5);
my $socket = IO::Socket::INET->new(
    PeerAddr => '127.0.0.1',
    PeerPort => $port
);
# 特徴をsendしてCVR予測値をreceiveする
my $cvr;
$socket->print('13,57062');
$socket->recv($cvr);
# サーバを閉じる
$socket->print('exit');
wait();
```

---
### CVR予測サーバ(Python)
- - -

```python
import socket

if __name__ == '__main__':
    port = sys.argv[1]
    cvr_pred_model = load_model()
    # サーバ起動
    sock = socket.socket()
    sock.bind(('127.0.0.1', port))
    sock.listen(1)
    conn, addr = sock.accept()
    while True:
        feature_str = conn.recv() # クライアントからのsendを待つ
        if feature_str == 'exit': # 'exit'が入力されたらサーバを閉じる
          break
        predicted_cvr = cvr_pred_model.predict(feature_str)
        conn.send(predicted_cvr)
    conn.close()
    sock.close()
```

---
### 結果
- - -

* 1サーバ、1クライアントで約3000QPS @ dsp-dc1


---
### 現状
- - -

* bid request時にCVR予測値を取得しているわけではない
  - ある程度配信実績のある  
    ラインアイテム・枠の組み合わせで  
    キャッシュに保存
  - 実績のない枠に対しては  
    ラインアイテム平均のCVRで買わざるをえない

---
### 課題
- - -

* 実績のない枠に対しても妥当な価格で入札したい
  - bid request時にCVR予測値を参照できないか？
