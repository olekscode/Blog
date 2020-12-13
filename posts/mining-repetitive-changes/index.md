# Mining Repetitive Changes from Source Code History

Many changes that programmers make to the code as they refactor it are systematic and repetitive. In this post, I will tell you about an interesting approach that allows us to identify some of those repetitive changes and see what we can learn from them.

The examples in this post will be demonstrated in [Pharo](https://pharo.org/) although the same approach can be implemented in any programming language.

## General Idea

Given a project repository and two versions

1. Collect all commits between those two versions
2. Extract method changes from commits
3. Identify deleted and added entities in every method change
4. Use a data mining algorithm to identify frequent sets of deleted and added entities

