# Multivariate Normal Distribution in Pharo

The PolyMath library defines different distributions, including normal distribution, student distribution, poisson distribution, etc. However, all of them are distributions of one random variable.

For implementing a classification algorithm called the Gaussian Mixture Models, I needed a multivariate normal distribution that describes multiple dependent random variables.

$$
\mu = \begin{pmatrix}
1 \\ 0
\end{pmatrix},\quad
\Sigma = \begin{pmatrix}
1 & 0.8 \\
0.8 & 1
\end{pmatrix}
$$

$$
X  N(\mu, \Sigma)
$$

```Smalltalk
mu := #(1 0) asPMVector.sigma := PMMatrix rows: #(	(0.5 1)	(1 3)).
	
```