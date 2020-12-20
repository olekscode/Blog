# Understanding Normalization in Machine Learning

Data comes to us in a dirty state. Some values are missing, some entries are inconsistent with each other. Before applying a machine learning algorithm to a given dataset, we must often do several preprocessing steps to ensure that the data is clean and in good shape.

In this blog post, I will introduce you to _normalization_ -- a very important step of data preprocessing that is crytical when applying certain machine learning algorithms. 

## What Is Normalization?

In statistics and machine learning, _normalization_ is the process which transforms multiple columns of a dataset to make them numerically consistent with each other (e.g. be on the same scale) and preserve the valuable information stored in these columns.

The following examples will help you understand what is normalization and why do we need it.

### Example 1. Academic Salaries

The [Salaries]() table which is part of the [carData](https://cran.r-project.org/web/packages/carData/index.html) collection of datasets (Datasets to Accompany J. Fox and S. Weisberg, An R Companion to Applied Regression, Third Edition, Sage, 2019) descibes the 2008-09 nine-month academic salary for Assistant Professors, Associate Professors, and Professors in a college in the U.S.

In this example, we will look at three columns of the dataset:

| Column name | Values |
|---|---|
| Rank | _"Associate Professor"_, _"Assistant Professor"_, or _"Professor"_ |
| Years Since PhD | Integer in range [1 .. 56] |
| Salary | Integer in range [57,800 .. 231,545] |

As you can see, the values of the second and the third column are on a very different scale. The _"Salary"_ column contains much larger numbers which variate on a larger range than the ones from _"Years Since PhD"_ column. Many machine learning algorithms (for example those that calculate distances between data points, such as k-means, k nearest neighbours, support vector machines, etc.) will give higher importance to the columns with larger values. For those algorithms, 10 years of experience will have as little importance as $10 increase in salary, as a result, the _"Years Since PhD"_ column will be practically ignored. You can see this problem visualized in the left part of the figure below.

![](img/AcademicSalary.png)

A common solution is to normalize both _"Salary"_ and _"Years Since PhD"_ columns to the same scale, for example [0..1]. You can see the result in the right hand side of the figure above.

## Different Kinds of Normalization

### Min-max Normalization (Linear Scaling)

$$ x_i' = \frac{x_i - x_{min}}{x_{max} - x_{min}} $$

### Z-Score Normalization

$$ x_i' = \frac{x_i - \mu}{\sigma} $$

$$ \mu = \frac{1}{n} \sum_{i=1}^n x_i $$

$$ \sigma = \sqrt{\frac{1}{n-1} \sum_{i=1}^n (x_i - \mu)^2} $$

### Z-Score Normalization With Mean Absolute Deviation

$$ s_x = \frac{1}{n} \sum_{i=1}^n | x_i - \mu | $$

$$ x_i' = \frac{x_i - \mu}{s_x} $$

### Clipping

$$ x_i' = \left\{\begin{array}{ll}a,& x_i < a\\x_i,& a \leq x_i \leq b\\b,& x_i > b\end{array}\right. $$

### Log Scaling

$$ x_i' = \log(x_i) $$

### Decimal Scaling

$$ x_i' = \frac{x_i}{10^j} $$

Where $j$ is the smallest integer such that $ \max(|x_i'|) < 1 $.

## Which Normalization Technique Should I Use?

The most frequently used normalization techniques are the min-max normalization and z-score normalization. Other methods that I described in the previous section can be useful in some special cases. For example, clipping can be used to remove outliers, log scaling can help if your data is shifted to the left.

The main difference between min-max and z-score normalization techniques in that the prior one requires you to know the range of your data. If you are using normalization with a supervised learning algorithm when new values can come after training, those values can fall outside of the range, which would cause min-max normalization to exceed its bounds. On the other handm if you are using an unsupervised learning algorithm such as k-means clustering and you will not be applying your trained model to the new data, you can use min-max. The advantage of min-max over z-score is that we know the resulting range [0,1].

## Confusing Terminology

As it is with many concepts in the field of machine learning and AI, the terminology which is used to described normalization is very inconsistent accross literature. In some articles, the term _"normalization"_ refers to the min-max technique only and is contrasted with a z-score _"standardization"_. Other articles use the term _"scaling"_ for min-max and reserve _"normalization"_ for z-score.

Perhaps, this confusion comes from the field of statistics, where _"normalization"_ sometimes has other connotations (e.g. transforming data to better fit the normal districution).

I adopt the terminology that is more commonly used in data processing: _"normalization"_ and _"standardization"_ are two terms that can be used interchangeably and encapsulate different techniques such as _"min-max normalization"_ (a.k.a. _"linear scaling"_) and _"z-score normalization"_.

## Implementing Normalization Using Strategy Design Pattern

## References

* Jiawei Han, Micheline Kamber, and Jian Pei. _Data Mining. Concepts and Techniques_ (3rd edition). The Morgan Kaufmann Series in Data Management Systems, 2011, pp. 113-115 (Section 3.5.2. Data Transformation by Normalization).
* [Normalization. Machine Learning Crash Course at developers.google.com](https://developers.google.com/machine-learning/data-prep/transform/normalization)
* [Aniruddha Bhandari. _Feature Scaling for Machine Learning: Understanding the Difference Between Normalization vs. Standardization_ -- Analytics Vidhya, April 3, 2020](https://www.analyticsvidhya.com/blog/2020/04/feature-scaling-machine-learning-normalization-standardization/)