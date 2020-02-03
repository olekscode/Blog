# N-gram Language Models

Before writing a chapter about n-gram models, I will briefly describe them in this blog posts.

## What is a language model?

**Statistical language model** or simply a **language model** is a probabilistic model that can predict the next word in a sequence of words. If \(V\) is the vocablary of some language (for example, a vocabulary of all English words), then given a sequence of \(k-1\) words \(w_1, \dots, w_{k-1}\), a language model would assign a conditional probability for every possible word \(w_k \in V\):

\[ P(w_k | w_1, \dots, w_{k-1} \]

## What is an n-gram

N-gram is simply a sequence of n words.