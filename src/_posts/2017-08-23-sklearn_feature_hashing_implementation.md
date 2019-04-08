---
layout: post
title: scikit-learnのFeatureHashingの実装についてメモ
tags: [scikit-learn, feature hashing]
type: article
description: "scikit-learnのFeatureHashingの実装についてメモ"
---

scikit-learnのFeatureHashingの実装をメモしておく。

<!-- more -->

* [feature_extraction/_hashing.pyx](https://github.com/scikit-learn/scikit-learn/blob/master/sklearn/feature_extraction/_hashing.pyx)
* `n_features`がfeature vectorの次元数になる
* featureをハッシュ化して`mod n_features`することでfeature vectorのインデックスの位置を決定する
  - featureのvalueが文字列のとき、`key=value`をハッシュ化して、`mod n_features`番目のインデックスに1を入れる
  - featureのvalueが数値のとき、`key`をハッシュ化して、`mod n_features`番目のインデックスにvalueをいれる
  - 入れるvalueはハッシュ値の正負を反映する(`alternate_sign=True`のとき)
  - なお、`mod n_features`するときはハッシュ値は絶対値にする

```py
>>> from sklearn.feature_extraction import FeatureHasher
>>> n_features = 10
>>> h = FeatureHasher(n_features=n_features)
>>> D = [{"id": 9, "category": "8"},{"id": 10, "category": "7"}]
>>> f = h.transform(D)
>>> f.toarray()
array([[  0.,   0.,   0.,   0.,   0.,   1.,   0.,  -9.,   0.,   0.],
       [  0.,   0.,   0.,  -1.,   0.,   0.,   0., -10.,   0.,   0.]])
>>> import mmh3
# 7番目のインデックスに負の符号をつけたvalueを入れる
>>> mmh3.hash("id")
-1737061407
>>> abs(mmh3.hash("id")) % n_features
7
# 5番目のインデックスに1を入れる
>>> mmh3.hash("category=8")
1453528385
>>> abs(mmh3.hash("category=8")) % n_features
5
# 3番目のインデックスに-1を入れる
>>> mmh3.hash("category=7")
-647926533
>>> abs(mmh3.hash("category=7")) % n_features
3
```
