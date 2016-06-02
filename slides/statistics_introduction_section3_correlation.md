---
layout: slide
title: 統計学入門 第3章 相関
---

### 統計学入門 第3章
#### - 相関 -

---

<img src="/assets/images/statistics_introduction/cover.jpg" width="40%">

http://www.utp.or.jp/bd/978-4-13-042065-5.html

---
### 相関と回帰
- - -

* 一般に変数が複数あるデータを**多次元データ**という

* $x$, $y$の2変数が存在する2次元データにおいて  
  変数間の関係性を調べる
  - **相関**
    + $x$と$y$が対等な関係にある場合
    + e.x. 身長と体重など
  - **回帰**
    + $x$が$y$を左右する関係にある場合
    + e.x. 年齢と血圧、所得と消費など

---
### 散布図と分割表
- - -

* $x\_{i}, y\_{i}$の2変数からなるサンプル$i(i=1,...,n)$
  - $x$, $y$がともに量的データの場合
    + **散布図**を用いる
    + 横軸に$x$、縦軸に$y$をとって2次元平面にプロット
  - $x$, $y$がともに質的データの場合
    + **分割表**を用いる

---
### 量的データ - 散布図
- - -

<img src="/assets/images/statistics_introduction/section3/scattergram1.png" width="40%">

---
### 相関関係
- - -

* 2つの変数間の関係のことを一般に**相関関係**と呼ぶ
  - 特に2つの変数間に直線関係に近い傾向にあるとき

---
### 散布図 - 正の相関関係
- - -

<img src="/assets/images/statistics_introduction/section3/pos_corr.png" width="40%">

* 一方の変数が増加するにつれて他方の変数も増加する
  - **正の相関関係がある**という

---
### 散布図 - 負の相関関係
- - -

<img src="/assets/images/statistics_introduction/section3/neg_corr.png" width="40%">

* 一方の変数が増加するにつれて他方の変数は減少する
  - **負の相関関係がある**という

---
### 相関係数
- - -

* **相関係数** (correlation coefficient)
  - 相関の程度を示す指標
  - よく用いられるのはピアソンの積率相関係数
  - データが$(x\_{1}, y\_{1}), (x\_{2}, y\_{2}), \cdots, (x\_{n}, y\_{n})$で与えられた場合、変数$x$と$y$の間の相関係数は
    + $\begin{align}
      r\_{xy} &=
      \cfrac{
        \frac{1}{n} \sum\_{i} (x\_{i}-\bar{x})(y\_{i}-\bar{y})
      }{
        \sqrt{\frac{1}{n} \sum\_{i} (x\_{i}-\bar{x})^2}
        \sqrt{\frac{1}{n} \sum\_{i} (y\_{i}-\bar{y})^2}
      } \\\\
      &=
      \frac{
        \sum\_{i} (x\_{i}-\bar{x})(y\_{i}-\bar{y})
      }{
        \sqrt{\sum\_{i} (x\_{i}-\bar{x})^2}
        \sqrt{\sum\_{i} (y\_{i}-\bar{y})^2}
      }
      \end{align}$
    + $-1 \leq r\_{xy} \leq 1$

---
### 相関係数
- - -

* 相関係数$r\_{xy} =
  \cfrac{
    \frac{1}{n} \sum\_{i} (x\_{i}-\bar{x})(y\_{i}-\bar{y})
  }{
    \sqrt{\frac{1}{n} \sum\_{i} (x\_{i}-\bar{x})^2}
    \sqrt{\frac{1}{n} \sum\_{i} (y\_{i}-\bar{y})^2}
  }$
  - $S\_{x} = \sqrt{\frac{1}{n} \sum\_{i} (x\_{i}-\bar{x})^2}$: 変数$x$の標準偏差
  - $S\_{y} = \sqrt{\frac{1}{n} \sum\_{i} (y\_{i}-\bar{y})^2}$: 変数$y$の標準偏差
  - $C\_{xy} = \frac{1}{n} \sum\_{i} (x\_{i}-\bar{x})(y\_{i}-\bar{y})$: 変数$x$,$y$の共分散
  - $(x\_{i}-\bar{x})(y\_{i}-\bar{y})$: 変数$x$,$y$の偏差積

---
### 偏差積と共分散
- - -

* 変数$x$,$y$の共分散: $C\_{xy} = \frac{1}{n} \sum\_{i} (x\_{i}-\bar{x})(y\_{i}-\bar{y})$
  - 変数$x$,$y$の偏差積$(x\_{i}-\bar{x})(y\_{i}-\bar{y})$の平均
    + $x$が大きいとき$y$も大きい傾向  
      -> 偏差積$>0$ -> 共分散$>0$
    + $x$と$y$にあまり関係がない傾向  
      -> 偏差積$\simeq0$ -> 共分散$\simeq0$
    + $x$が大きいとき$y$は小さい傾向  
      -> 偏差積$<0$ -> 共分散$<0$

* 共分散でも2つの変数間の関係は表せる

---
### 共分散と相関係数
- - -

* 共分散はデータの単位により値が変わる
  - e.x. 古文と漢文のテスト
    + ともに100点満点の場合
    + ともに10点満点の場合

* 共分散を標準偏差で割って正規化したもの  
  = **相関係数**
  - 相関係数は単位により不変
  - $-1\leq$相関係数$\leq 1$

---
### 相関係数
- - -

<img src="/assets/images/statistics_introduction/section3/coef_corr.png" width="70%">


---
### 相関の強さの目安
- - -

* $0.7 \leq |r\_{xy}| \leq 1$: 強い相関あり
* $0.4 \leq |r\_{xy}| \leq 0.7$: やや相関あり
* $0.2 \leq |r\_{xy}| \leq 0.4$: 弱い相関あり
* $0 \leq |r\_{xy}| \leq 0.2$: ほとんど相関なし

---
### 相関を見る際の注意
- - -

* 少ないサンプル数
  - 相関係数が高く見えることがある
  - 実際に散布図を書く
* 疑似相関
* 層別相関

---
### 疑似相関
- - -

<img src="/assets/images/statistics_introduction/section3/pseudo_corr.png" width="60%">

* 実際に相関があるのは昼間人口
  - **疑似相関** or **みかけ上の相関**

---
### 偏相関係数
- - -

* **偏相関係数**
  - 3つの変数があるとき、変数3の影響を除いたあとの変数1と変数2の相関係数
  - $r\_{12 \cdot 3} = \frac{r\_{12}-r\_{13}r\_{23}}{\sqrt{1-r\_{13}^{2}}\sqrt{1-r\_{23}^{2}}}$

* $r\_{12 \cdot 3} = 0.665$となり、さほど高くないことがわかる

---
### 層別相関
- - -

<img src="/assets/images/statistics_introduction/section3/stratified_corr.png" width="60%">

* イングランド以外は相関は強くない
  - **層別相関**

---
### 質的データ - 分割表
- - -

<table>
  <caption>大学院の学生構成</caption>
  <tr>
    <th></th><th>日本人</th><th>留学生</th><th>合計</th>
  </tr>
  <tr>
    <th>修士課程</th><td>2415</td><td>274</td><td>2689</td>
  </tr>
  <tr>
    <th>博士課程</th><td>2002</td><td>620</td><td>2622</td>
  </tr>
  <tr>
    <th>合計</th><td>4417</td><td>894</td><td>5311</td>
  </tr>
</table>


---
### 分割表 - 相対度数
- - -

<table>
  <caption>
    大学院の学生構成<br>
    上段: 横方向の相対度数<br>
    中段: 縦方向の相対度数<br>
    下段: 全体における相対度数
  </caption>
  <tr>
    <th></th><th>日本人</th><th>留学生</th><th>合計</th>
  </tr>
  <tr>
    <th>修士課程</th><td>2415</td><td>274</td><td>2689</td>
  </tr>
  <tr>
    <th>博士課程</th><td>2002</td><td>620</td><td>2622</td>
  </tr>
  <tr>
    <th>合計</th><td>4417</td><td>894</td><td>5311</td>
  </tr>
</table>

---
### 順位相関係数
- - -

* 変数が質的データの場合の相関係数はどう求めるか？

* **順位相関係数** (rank correlation coefficient)
  - スピアマンの順位相関係数
    + 通常の積率相関係数の式を適用したもの
    + $r\_{s}=1-\cfrac{6}{n^{3}-n}\sum\_{i} ({x\_i}-y\_{i})^2$
  - ケンドールの順位相関係数
    + $+1$の数$G$と$-1$の数$H$の大小関係
    + $r\{k}=\cfrac{G-H}{n(n-1)/2}$

---
### スピアマンの順位相関係数の求め方(1)
- - -

$\begin{align}
r\_{xy} &=
\cfrac{
  \frac{1}{n} \sum\_{i} (x\_{i}-\bar{x})(y\_{i}-\bar{y})
}{
  \sqrt{\frac{1}{n} \sum\_{i} (x\_{i}-\bar{x})^2}
  \sqrt{\frac{1}{n} \sum\_{i} (y\_{i}-\bar{y})^2}
} \\\\
&= \cfrac{
  \sum\_{i} (x\_{i}y\_{i} - \bar{y} x\_{i} - \bar{x} y\_{i} + \bar{x}\bar{y})
}{
  \sqrt{
    \sum\_{i} (x\_{i}^{2} - 2\bar{x} x\_{i} + \bar{x}^2)
    \sum\_{i} (y\_{i}^{2} - 2\bar{y} y\_{i} + \bar{y}^2)
  }
} \\\\
&= \cfrac{
  \sum\_{i} (x\_{i}y\_{i} - \bar{x}\bar{y})
}{
  \sqrt{
    \sum\_{i} (x\_{i}^{2} - n \bar{x}^2)
    \sum\_{i} (y\_{i}^{2} - n \bar{y}^2)
  }
} \\\\
(&\sum\_{i} x\_{i} = \sum\_{i} y\_{i} = \sum\_{i} \bar{x} = \sum\_{i} \bar{y})
\end{align}$

---
### スピアマンの順位相関係数の求め方(2)
- - -

$\begin{align}
r\_{xy} &= \cfrac{
  \sum\_{i} (x\_{i}y\_{i} - \bar{x}\bar{y})
}{
  \sqrt{
    \sum\_{i} (x\_{i}^{2} - n \bar{x}^2)
    \sum\_{i} (y\_{i}^{2} - n \bar{y}^2)
  }
} \\\\
&= 1 - \cfrac{6}{n(n^2-1)} \sum\_{i=1}^{n} (x\_{i}-y\_{i})^2 \\\\
(&\bar{x} = \bar{y} = \frac{n+1}{2},
  \sum\_{i}x\_{i}=\sum\_{i}y\_{i}=\frac{n(n+1)}{2} \\\\
 &\sum\_{i}x\_{i}^{2}=\sum\_{i}y\_{i}^{2}=\frac{n(n+1)(2n+1)}{6})
\end{align}$

---
### 順位相関係数
- - -

<table>
  <caption>男女の好きな花の順番</caption>
  <tr>
    <th></th><th>桜</th><th>菊</th><th>薔薇</th><th>梅</th><th>百合</th><th>向日葵</th><th>秋桜</th><th>椿</th>
  </tr>
  <tr>
    <th>x: 男</th><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td>
  </tr>
  <tr>
    <th>y: 女</th><td>3</td><td>1</td><td>2</td><td>5</td><td>4</td><td>7</td><td>6</td><td>8</td>
  </tr>
</table>

* スピアマンの順位相関係数$r\_{s}$

$\begin{align}
  r\_{s}&=1-\frac{6}{n^{3}-n}\sum\_{i} ({x\_i}-y\_{i})^2 \\\\
        &=1-\frac{6}{8^3-8}((1-3)^2+(2-1)^2+\cdots) \\\\
        &=0.881
\end{align}$

---
### 時系列データと自己相関係数
- - -

* 普通のデータ$x\_{1}, x\_{2}, \cdots, x\_{n}$は  
  データを観測する順序を問題としない
  - e.x. 身長と体重
  - 添字$1, 2, \cdots, n$は区別の番号に過ぎない

* **時系列データ**$x\_{1}, x\_{2}, \cdots, x\_{n}$は  
  データを観測する順序に意味がある
  - e.x. 商品の月ごとの売り上げ
  - 周期的変動、季節変動などが含まれる可能性

* **自己相関係数**
  - 1つの変数$x$において異時点間の相関関係を表す

---
### 時系列データと自己相関係数
- - -

* 遅れ$h$の自己相関係数$r\_{h}=
\cfrac{
  \frac{\sum\_{i=1}^{n-h}(x\_{i}-\bar{x})(x\_{i+h}-\bar{x})}{n-h}
}{
  \frac{\sum\_{i=1}^{n}(x\_{i}-\bar{x})^2}{n}
}
$
  - $h$: 時間の隔たり

* e.x. 季節性を含む商品の月別の売り上げの場合  
  $h=12$のときに自己相関係数$r\_{h}$が大きくなる

---
### まとめ
- - -

* 2つの変数間の関係をあらわす指標として  
  回帰と相関がある
  - 相関は変数を対等なものとして見る

* 相関係数は変数間の相関の強さを表す
  - 少ないサンプル数や疑似相関などに注意
