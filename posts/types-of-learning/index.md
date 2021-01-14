# Supervised, Unsupervised, and Reinforcement Learning

Machine learning is the process of improviong the performance of algorithms by adjusting their parameters based on a data.

We distinguish three types of learning based on the data that is used as input.

In this blog post, I will not go into details of specific machine learning algorithms such as linear regression, neural networks, k-means clustering etc. Instead, I will explain the general ideas behind the three types of learning problems. Every machine learning out there can then be expressed in terms of those definitions.

## Supervised Learning

In this type of machine learning, the input is the matrix of observations $X$ and the vector of labels $y$.

Supervised learning is a problem of finding the parametrised function

$$
\hat y_i = h_{\theta}(X_i)
$$

$$
L(\theta) = \frac{1}{n} \sum_{i=1}^n (y_i - \hat y_i)^2
$$

$$
\hat \theta = \text{argmin}_{\theta} L(\theta)
$$

## Unsupervised Learning

Unsupervised learning takes the unlabeled dataset.

## Reinforcement Learning

Reinforcement learning