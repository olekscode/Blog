# Paper Summary: "Mining Framework Usage Changes from Instantiation Code" by Schäfer et al.

This is a quick summary of a _"Mining Framework Usage Changes from Instantiation Code"_ paper by Thorsten Schäfer, Jan Jonas, and Mira Mezini published at ICSE 2008. Authors ropose to mine framework usage change rules from already ported instantiations, whcih can be eithe applications buit on top of the framework or the test casesmaintained by framework developers.

Frameworks evolve and release new versions. Those updates often break existing users, which requires client developers to update their code according to the changes. This process is tedious, time-consuming, and error-prone, which is why it could benefit from automation.

Severall approaches have been proposed before to detect refactorings that were applied to the framework code, however, those approaches have two major shortcomings:

1. Some changes are not caused by refactorings
2. Some refactoring operations are complex and can not be detected

To address those issues, Schäfer et al. propose a new approach that mines usage changes from the code that is dependent on the framework. This can either be the client system that was already updated to the new version or the unit tests of the framework.