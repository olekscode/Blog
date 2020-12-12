# Understanding Normalization in Machine Learning

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

## Implementing Normalization Using Strategy Design Pattern