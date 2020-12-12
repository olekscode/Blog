# Understanding Normalization in Machine Learning

Data comes to us in a dirty state. Some values are missing, some entries are inconsistent with each other. Before applying a machine learning algorithm to a given dataset, we must often do several preprocessing steps to ensure that the data is clean and in good shape.

In this blog post, I will introduce you to **normalization** -- a very important step of data preprocessing that is crytical when applying certain machine learning algorithms. 

## What Is Normalization?

## Different Kinds of Normalization

### Linear Scaling

\[ x_i' = \frac{x_i - x_{min}}{x_{max} - x_{min}} \]

### Clipping

\[ x_i' = \left\{
    \begin{array}{ll}
      a,& x_i < a\\
      x_i,& a \leq x_i \leq b\\
      b,& x_i > b
    \end{array}
  \right. \]

### Log Scaling

\[ x_i' = \log(x_i) \]

### Z-Score

\[ x_i' = \frac{x_i - \mu}{\sigma} \]

## Which Normalization Technique Should I Use?

## Implementing Normalization Using Strategy Design Pattern

## References

* [Normalization. Machine Learning Crash Course at developers.google.com](https://developers.google.com/machine-learning/data-prep/transform/normalization)
* [Aniruddha Bhandari. _Feature Scaling for Machine Learning: Understanding the Difference Between Normalization vs. Standardization_ -- Analytics Vidhya, April 3, 2020](https://www.analyticsvidhya.com/blog/2020/04/feature-scaling-machine-learning-normalization-standardization/)