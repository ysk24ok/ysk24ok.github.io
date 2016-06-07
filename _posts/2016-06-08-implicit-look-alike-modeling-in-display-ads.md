---
layout: default
title: "Read a paper: Implicit Look-Alike modeling in Display Ads"
---

# Read a paper: Implicit Look-Alike modeling in Display Ads

## Paper

Zhang, W., Chen, L., Wang, J.: Implicit Look-alike Modelling in Display Ads: Transfer Collaborative Filtering to CTR Estimation, [arxiv:1601.02377](https://arxiv.org/abs/1601.02377)

## Background

* The **look-alike** modeling consists of two stages:
  - *profiling*
    + explicitly build the user profiles and detect their interest segment  
      via their online behaviour
  - *targeting*
    + detect the users with simlilar interests to the known customer

* However this profiling-and-targeting mechanism is not optimal:
  1. potentially correlated segments are regarded as separated
  2. building segments is performed independently of its latter use of ad response prediction
  3. difficult to update over time

## Contribution

* They propose a framework to *implicitly* and *jointly* learn the users' profiles  
  on both Web browing behaviours and ad response behaviours
  1. directly maps each user, webpage and ad into a latent space
  2. jointly learns the users' profiles on general browsing and ad response behaviour
  3. makes an improvement over the prediction of the users' ad response  
     with the knowledge from the user browsing behaviours

## Implicit Look-Alike Modeling

* We commonly have two types of observations about underlying user behaviours
  - web browsing behaviours prediction (collaborative filtering task)
    + dataset $D^{c}$, data instance as $(\mathbf{x}^{c}, y^{c})$
  - ad response behaviours prediction (CTR task)
    + dataset $D^{r}$, data instance as $(\mathbf{x}^{r}, y^{r})$

* The joint conditional likelihood:

$$\hat{\Theta}=\max P(\Theta) \prod P(y^{c}|\mathbf{x}^{c};\Theta) \prod P(y^{r}|\mathbf{x}^{r};\Theta)$$

* There are two predictions tasks:
  - Web Browsing Prediction (CF task)
    + data $\mathbf{x}^{c} \equiv (\mathbf{x}^{u},\mathbf{x}^{p})$: each users's online browsing behaviour
      * $\mathbf{x}^{u} \in \mathbb{R}^{I^{c}}$ - the set of features for a user
      * $\mathbf{x}^{p} \in \mathbb{R}^{J^{c}}$ - the set of features for a publisher
      * each $\mathbf{x}\_{i}^{u},\mathbf{x}\_{i}^{p}$ is associated with a $K$-dimensional latent vector $\mathbf{v}\_{i}^{c},\mathbf{v}\_{j}^{c}$
        - thus the latent matrix $\mathbf{V}^{c} \in \mathbb{R}^{(I^{c}+J^{c})\times K}$
    + target to predict $y^{c}$
      * whether the user is interested in visiting any given new publisher
  - Ad Response Prediction (CTR task)
    + data $\mathbf{x}^{r} \equiv (\mathbf{x}^{u},\mathbf{x}^{p},\mathbf{x}^{a})$: each user's online ad feedback behaviour
      * $\mathbf{x}^{u} \in \mathbb{R}^{I^{r}}$ - the set of features for a user
      * $\mathbf{x}^{p} \in \mathbb{R}^{J^{r}}$ - the set of features for a publisher
      * $\mathbf{x}^{a} \in \mathbb{R}^{L^{r}}$ - the set of features for a advertiser
      * each $\mathbf{x}\_{i}^{u},\mathbf{x}\_{i}^{p},\mathbf{x}\_{i}^{a}$ is associated with a $K$-dimensional latent vector $\mathbf{v}\_{i}^{r},\mathbf{v}\_{j}^{r},\mathbf{v}\_{l}^{r}$
        - thus the latent matrix $\mathbf{V}^{r} \in \mathbb{R}^{(I^{r}+J^{r}+L^{r})\times K}$
    + target to predict $y^{r}$
      * how likely it is that the user will click a specific ad impression

* Dual-Task Bridge
  - the weights of the user features and publisher features in CTR task  
    are assumed to be generated from those in CF task (as a prior):
    + $\mathbf{w}^{r} \simeq N(\mathbf{w}^{c}, \sigma^{2}I)$
    + the users' interest towards webpage is relatively general and ad can be regarded as a special kind of webpage content
    + user interests from their browsing behaviours can be regareded as a modification or derivative from the learned general interests
  - they add a hyperparameter $\alpha$ to balance the relative importance of the two tasks

## Evaluation

* Dataset
  - $\mathbf{x}^{u}$: user_cookie, hour, browser, os, user_agent, screen_size
  - $\mathbf{x}^{p}$: domain, url, exchange, ad_slot, slot_size
  - $\mathbf{x}^{a}$: advertiser, campaign

* Expriments
  - 1st
    + only focus on *user_cookie* and *domain* as a baseline
      * to check users' behaviours and webpage browsing  
        lead to better ad click modeling
  - 2nd
    + append various features in the first setting  
      * to observe the performance change
      * to check which featrues lead to better transfer learning
    + the larger $\alpha$ means the larger weight is allocated on the CF task
      * if a large-value $\alpha$ leads to the optimal estimation performance,
        such feature takes effect on the transfer learning
      * if a low-value $\alpha$ leads to the optimal estimation performance,
        such feature has no effect on transfer learning

* Compared Models
  - *Base*
    + only CTR task
  - *DisJoint*
    + train the CF task model and next train the CTR task  
      with the trained parameters in CF task fixed
  - *DisJointLR*
    + proposed in [another paper](http://dl.acm.org/citation.cfm?id=2623349)
  - *Joint*
    + their proposed model

* Result
  - 1st
    + *Joint* consistently outperforms *Base* and *DisJoint* on both AUC and RMSE
      * demonstrates the effectiveness of tranfer learning
    + *Joint* still outperforms *Base* and *DisJoint* in $\alpha=0$  
      (the CF side model $\mathbf{w}^{c}$ does not learn)
      * different prior of $\mathbf{w}^{r}$ and $\mathbf{V}^{r}$
    + both AUC and RMSE of *Joint* are 0.5 in $\alpha=1$
  - 2nd
    + the user browsing *hour* and ad slot *position*   
      are the most valuable features that help transfer learning
    + the user *screen size* does not bring any transfer value
    + the basic *user_cookie* and *domain* provide an overall positive value  
      of transfer learning
