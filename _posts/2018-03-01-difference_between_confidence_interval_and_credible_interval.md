---
layout: post
title: 信頼区間(confidence interval)と信用区間(credible interval)の違い
tags: [statistics, Japanese]
type: article
description: "信頼区間(confidence interval)と信用区間(credible interval)の違い"
---

信頼区間(confidence interval)と信用区間(credible interval)の違いをメモしておく。

<!-- more -->

# 信頼区間 (confidence interval)

95%信頼区間は、「標本抽出して95%信頼区間を計算するという操作を100回繰り返した時に、そのうちの95回はその区間に母平均が含まれるような区間」のことである。

信頼区間は頻度主義の考えに基づく。  
頻度主義では母平均すなわち真の値は1点に決まっていると考えるため、  
「標本抽出を何回も繰り返すと95%の確率でその区間内に真の値が入る」という意味になる。


# 信用区間 (credible interval)

95%信用区間（あるいは確信区間）は、「母平均の事後確率分布において、真の値が95%の確率で含まれる区間」のことである。

信用区間はベイズ主義の考えに基づく。  
ベイズ主義では真の値の確からしさが事後確率分布として得られるので、  
「95%の確率でその区間内に真の値が存在する」という意味になる。  
信用区間のほうが意味としては直感的である。

# 参考

* [19-3. 95％信頼区間のもつ意味 \| 統計学の時間 \| 統計WEB](https://bellcurve.jp/statistics/course/8891.html)
* [頻度論 vs. ベイズ統計（前半） – 医療政策学×医療経済学](https://healthpolicyhealthecon.com/2015/12/18/bayesian-1/)
* [従来の推定法とベイズ推定法の違い \| Sunny side up!](http://norimune.net/708)
