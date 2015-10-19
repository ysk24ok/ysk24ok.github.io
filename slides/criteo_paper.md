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

  - the predicted probablity of an example \\( x \\) belonging to class 1 is:
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
