---
layout: slide
title: criteo\_paper
---

### Simple and scalable prediciont for display advertising

---
### 4. Modeling
- - -
* This section describes the various modeling techniques
  - to learn a response predictor from click or conversion logs

---
### 4.1 Logistic Regression
- - -

* Maximum entropy model
  - Given a trainig set \\( (\mathbf{x_i}, y_i) \\)
    + sparse binary feature vector \\( \mathbf{x_i} \in \\{ 0, 1 \\}^d \\)
    + binary target \\( y_i \in \\{ -1, 1 \\} \\)

  - the predicted probability of an example \\( x \\) belonging to class 1 is:
    + \\( Pr(y=1|\mathbf{x},\mathbf{w}) = \frac{1}{1+\exp{(-\mathbf{w^{\mathrm{T}}} \mathbf{x})}}\\)
    + \\( \mathbf{w} \in \mathbb{R}^d \\) is a weight vector

---
### 4.1 Logistic Regression
- - -

* The weight vector \\( \mathbf{w} \\) is found by minimizing the negative log likelihood with an \\( L_2 \\) regularization term
  - \\( \min\_{\mathbf{w}} \cfrac{\lambda}{2} ||\mathbf{w}||^2 + \sum\_{i=1}^{n} \log{(1+\exp{(-y_i \mathbf{w}^{T} \mathbf{x_i})})}\\)

* This cost function is not closed-form solution
  but is a convex and differentiable optimzation problem
  - it can be solved with any gradient based optimization problem
    + L-BFGS

---
### 4.2 Categorical variables
- - -

* All the features in this paper are catgorical
  - most features are identifiers (id of the advertisers, of the publisher, etc.)
  - real valued features can be made categorical through discretization

---
### 4.2 Categorical variables
- - -

* *Dummy coding* (1-of-c enconding in machine learning)
  - the standard way of encoding categorical features
  - if the feature can take \\( c \\) values,  
    \\( c \\) binary features are introduced
  - e.x. a feature taking the 2nd value out of 5 possible values is encoded as \\((0,1,0,0,0) \\)

* If we have \\( F \\) features and the \\( f \\)-th feature can take \\( c_f \\) values, this encoding will lead to a dimensionality of
  - \\( d=\sum\_{j=1}^{F} c_f\\)

---
### 4.3 Hashing trick
- - -

* The issue with the dummy coding is:
  - the dimensionality \\( d \\) can get very large

* *the hashing trick* addresses this issue
  - first introduced in Vowpal Wabbit
  - the idea is to use a hash function to reduce the number of values a feature can take

---
### 4.3 Hashing trick
- - -

* There are two possible strategies
  - hash each feature \\( f \\) into a \\( d_f \\)-dimensional space  
    and concatenate the codes
    + resulting in \\( \sum d_f \\)
  - hash all features into the same space  
    using different hash functions

* They use the latter approach as it is easier to implement

---
### 4.3 Hashing trick
- - -

![hashing trick](/assets/images/criteo_paper/pseudo_code_hashing_trick.png)

* There is hashing function \\( h_f \\) for every feature \\( f \\)

* This can be implemented using a single hash function  
  and having \\( f \\) as the seed or concatenating \\( f \\)  
  to the value \\( v_f \\) to be hashed


---
### 4.3 Hashing trick
- - -

* A practical appeal of hashing trick is its simplicity
  - does not require any additional data processing or data storage
  - straightforward to implement

---
### 4.4 Collision analysis
- - -

* Need to quantify the log likelihood degradation  
  due to two values colliding into the same bin

* Assume
  - there are \\( n_1 \\) negative and \\( n_2 \\) positive samples
  - there is only one feature taking two values

* negative log likelihood of one sample
  - \\( - \left( y_i \log{(\sigma(\mathbf{w}^{T}\mathbf{x_i})) + (1-y_i) \log{(1-\sigma(\mathbf{w}^{T}\mathbf{x_i}))}} \right) \\)
    + \\( \mathbf{x_i}, y_i \\): (feature vector, label)
    + \\( \mathbf{w} \\): weight vector
    + \\( \sigma(t) = \frac{1}{1+\exp^{t}} \\)

---
### 4.4 Collision analysis
- - -

* The case of no collision

* Assume
  - the first value is observed on all negative samples
    + \\( [1, 0] \\)
  - the second value is observed on all positive samples
    + \\( [0, 1] \\)

* The weight vector would be \\( [-\infty, \infty]\\)

* This lead to a log likelihood of zero on all the examples

---
### 4.4 Collision analysis
- - -

* The case of collision

* The feature vector of both positive and negative samples  
  would be \\( [1] \\)

* The weight vector would be \\( [\log{\frac{n_2}{n_1}}] \\)

* The negative log likelihood is:
  - \\( -n_1\log{\cfrac{n_1}{n_1+n_2}}-n_2\cfrac{n_2}{n_1+n_2}\\)

---
### 4.4 Collision analysis
- - -

* The worst cases that harms the log likelihood:
  - the two values were extremely predictive
  - there was no redundancy in features

* One could alleviate the collision issue  
  by making use of multiple hash functions
  - As decribed later this does not improve the results

* They expect more thorough and theoretical analysis
  of the effect of collisions within a learning system
  will be developed in the years to come

---
### 4.5 Conjunctions
- - -

* A linear model can only learn effects independently for each feature
  - the model
    + would learn that some advertisers and publishers  
      tend to have a higher CTR then others
    + would not learn that the CTR of a *bank of america* ad  
      is particularly high on *finance.yahoo.com*

* Solving this problem requires introducing a new *conjunction* feature


---
### 4.5 Conjunctions
- - -

* *Conjunction feature*
  - the cartesian product of two categorical variables  
    of cardinality \\( c_i \\) and \\( c_j \\)
  - another categorical variable of cardinality \\( c_i \times c_j \\)

* Computing conjunctions between all features is equivalent to  
  considering a polynomial kernel of degree 2

* The use of hashing trick is even more crucial  
  when the conjunction feature has high cardinality

---
### 4.5 Conjunctions
- - -

* The hashing trick helps reduce the dimensionality of data,  
  but might do a poor job on unseen values due to collision

* A possible solution is to represent the variable values  
  using a low-dimensinal representation such as matrix factorization

* A promising future work direction would be to combine  
  a low-dimensinal representation with the hashing trick

---
#### 5.4 Comparison with a feedback model<br/>- overview
- - -

* An alternative class of models is *feedback* models
  - the response rate is encoded  
    in the values of *feedback* features

* Feedback features is the aggregated historical data:
  - along various dimensions
    +  ads, publishers or uses, etc ...
  - at varying levels of granularity
    + response rate (CTR or CVR)
    + number of impressions or clicks

---
#### 5.4 Comparison with a feedback model<br/>- composite feedback features
- - -

* *Composite feedback features*
  - multiple attributes along different dimensions
    + e.x. publisher-advertiser, user-publisher-creative
  - to capture the variation of response rate  
    across different dimensions

* Feedback features are quantized  
  using a simple k-means clustering algorithm
  - with a special cluster id for the undefined values

* The size of the final models is typically small

---
#### 5.4 Comparison with a feedback model<br/>- pros and cons
- - -

* Weakness of the feedback models:
  - additional memory for feature value mappings
  - feedback features may give an incorrect signal  
    because of confounding variables

* It is preferable to directly model the response  
  as a function of variables,  
  not to perform any aggregation

* From a practical standpoint,  
  the feedback model may be preferable in cases  
  where the cost of updating the model is high

---
#### 5.4 Comparison with a feedback model<br/> - evaluation
- - -

* They used a relatively small number of features  
  for comparison between:
  - their proposed model based on categorical features
  - a model based on feedback features

* The table below shows a slight advantage  
  for their proposed model
  - the difference would likely be larger  
    as the number of features increases

<img src="/assets/images/criteo_paper/5.4_feedback_features.png" width="40%">

---
#### 5.5 Comparison with a hierarchical model<br/> - overview
- - -

* LMMH (Log-linear Model for Multiple Hierarchies)
  - exploits the hirarchical nature of attributes  
    by encoding the relations
  - the feature hirarchies
    + publisher type -> publisher id
    + advertiser id -> campaign id -> ad id

---
#### 5.5 Comparison with a hierarchical model<br/> - two phase learning
- - -

* Assume the following decomposition:
  <div style="text-align: center;">
  \\(p\_{i} = \lambda\_{h\_{i}} b\_{i} \\)
  </div>

* LMMH splits the modeling task into two phases
  1. a feature-based model is trained using covariates,  
     without hirarchical features
     - using logisctic regression, etc.
     - to calculate a probability estimate \\( b\_{i} \\)
  2. the correction factor \\( \lambda\_{h\_{i}} \\) are learned  
     with feature hierarchies
     - \\( \lambda\_{h\_{i}} \\) does not depend on covariates
     - true rate parameter \\( p\_{i} \\) can be estimated

---
#### 5.5 Comparison with a hierarchical model<br/> - correction factors
- - -

* Correction factors of the full hierarchies:
  <div style="text-align: center;">
  \\(\displaystyle \lambda\_{h\_{i}} = \prod\_{a\_{i} \in h\_{i,ad}} \prod\_{p\_{j} \in h\_{i, pub}} \phi\_{a_i, p_j} \\)
  </div>

  - \\( h\_{i} \\): the hierarchy pair
    + \\( h\_{i, ad} \\): advertiser hierarchies for the pair
    + \\( h\_{i, pub} \\): publisher hierarchies for the pair
  - \\( \lambda\_{h\_{i}} \\): the multiplicative correction factor for the pair
  - \\( \phi\_{a\_{i}, p\_{j}} \\): the state parameter (likelihood)  
    with the advertiser node \\( a\_{i} \\) and publisher node \\( p\_{j} \\)

---
#### 5.5 Comparison with a hierarchical model<br/> - model(1)
- - -

* \\( \phi\_{h\_{i}} \\) can be modeled using a Poisson distribution
  <div style="text-align: center;">
  \\( \phi\_{h\_{i}} = \exp^{-\nu} \cfrac{\nu^{C\_{h\_{i}}}}{C\_{h\_{i}}!} \quad (\nu=\lambda\_{h\_{i}}E\_{h\_{i}}) \\)
  </div>
  <!-- 単位時間中の平均クリック回数が\nuのとき、単位時間中にC回クリックが発生する確率 = \phi -->

  - \\( C\_{h\_{i}} \\): successes (clicks) on hierarchy pair \\( h\_{i} \\)
  - \\( E\_{h\_{i}} \\): expected successes under the baseline model on hierarchy pair \\( h\_{i} \\)

* The likelihood function is:

  <div style="text-align: center;">
  \\(\displaystyle \phi = \prod\_{h\_{i}} \phi\_{h\_{i}}\\)
  </div>

---
#### 5.5 Comparison with a hierarchical model<br/> - model(2)
- - -

* The log-likelihood of \\( \phi \\) is given by:

  <div style="text-align: center;">
  \\(
    \begin{align}
      \displaystyle
      \log \phi &= \sum\_{h\_{i}} \log \phi\_{h\_{i}} \\\
                &= \sum\_{h\_{i}} \log \left( \exp^{-\nu} \cfrac{\nu^{C\_{h\_{i}}}}{C\_{h\_{i}}!} \right) \\\
                &= \sum\_{h\_{i}} \left(
                    - E\_{h\_{i}}\lambda\_{h\_{i}}
                    + C\_{h\_{i}}\log ( \lambda\_{h\_{i}}E\_{h\_{i}} )
                    - \log C\_{h\_{i}} ! \right) \\\
                &= \sum\_{h\_{i}} \left(
                    - E\_{h\_{i}} \lambda\_{h\_{i}}
                    + C\_{h\_{i}} \log \lambda\_{h\_{i}} \right) + constant
    \end{align}
  \\)
  </div>

---
#### 5.5 Comparison with a hierarchical model<br/> - result
- - -

* When estimating \\( \phi \\) in the hierarchical structure of LMMH,  
  child nodes shares their ancestor parameters
  - the closer nodes are to each other,  
    the closer their correction factors will be to the parent

* Results show improvements in all metrics
  - their model's ability to take advantage of all relations, jointly

<img src="/assets/images/criteo_paper/5.5_lmmh.png" width="50%">


---
#### 5.6 Value of publisher information<br/>- overview
- - -

* This subsection provides an analysis of the relevance  
  of publisher information for both CTR and CVR predictions

* They compare the models for both CTR and CVR predictions:
  - a model without any publisher features
  - a model including publisher features

---
#### 5.6 Value of publisher information<br/>- comparison
- - -

* The model with publisher features improves  
  the normalized negative log likelihood
  - by 52.6% for CTR prediction
  - only by 0.5% for CVR prediction

* It means once the user clicks on the ad,  
  the publisher's page does not have much impact  
  on user's conversion behaviour

---
#### 5.6 Value of publisher information<br/> - results
- - -

* Their results differ from those reported in [Rosale et al. 2012]
  - PCC experiments show 5.62% improvements in auROC

* The dataset used in the current experiments  
  contains more reliable user information
  - while the dataset used in the previous experiments  
    includes samples where user features are not available

* In the absence of explicit user attributes,  
  publisher information serve as a proxy for user features
  - The website for Disney games  
    will surely attract more kids than adults

---
#### 5.7 Multiple hash functions
- - -

* A collision between two frequent values can lead to  
  a degradation in the log-likelihood

* One idea to alleviate this issue is  
  to use several hash functions
  - each value is replicated using different hash functions

* The table below shows using several hash functions  
  does not result in any significant improvements
  - conjunctions already induce redundancies

<img src="/assets/images/criteo_paper/5.7_multiple_hash_functions.png" width="55%">
