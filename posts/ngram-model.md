# N-gram Language Models

Before writing a chapter about n-gram models, I will briefly describe them in this blog posts.

## What is a language model?

**Statistical language model** or simply a **language model** is a probabilistic model that can predict the next word in a sequence of words. If \(V\) is the vocablary of some language (for example, a vocabulary of all English words), then given a sequence of \(k-1\) words \(w_1, ..., w_{k-1}\), a language model would assign a conditional probability for every possible word \(w_k \in V\):

\[ P(w_k | w_1, ..., w_{k-1}) \]

The probability of the entire sequence is the product of probabilities of each of its words:

\[ P(w_1, \dots, w_k) = P(w_1)P(w_2|w_1)P(w_3|w_1, w_2)\dots P(w_k|w_1,\dots,w_{k-1}) \]
\[ = \prod_{i=1}^kP(w_i|w_1^{i-1}) \]

## N-gram language models

An **n-gram** is simply a sequence of n words. The **n-gram language model** can predict n-th word in a sequence based on the previous n-1 words (instead of all previous words).

Bigram models make a **Markov assumption**: a probability of the next word depends only on one previous word.