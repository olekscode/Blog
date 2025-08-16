# Accessing Project Packages Through Baseline

Sometimes we need to access the list of all packages in our project. In this short post, I provide an example for doing that using the project's baseline.

Given that we already know the baseline of our project, we can do the following:

```Smalltalk
baselineClass := BaselineOfCormas.baselineClass allPackageNames.
```

Alternatively, we can access package specs and project specs (external dependencies) using the instance of baseline:

```Smalltalk
baseline := baselineClass new.packageSpecs := baseline project version spec packageSpecsInLoadOrder.packageSpecs select: [ :spec | spec type = 'package' ].packageSpecs select: [ :spec | spec type = 'project' ].
```

In case we do not know what is the baseline of our project, we can ask any package to give us the list of all baselines to which it belongs and then use some heuristic to select a relevant baseline:

```Smalltalk
package := CMAbstractModel package.BaselineOf allSubclasses select: [ :each |
	each allPackageNames includes: package name ].
```