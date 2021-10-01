# Estimatin Pi Using the Monte Carlo Method

I would like to share with you one of the most beautiful programming exercises. It demonstrates the power of numerical estimation.

## Magic Number Pi

## Monte Carlo Methods

The method is named after the casino in Monte Carlo.

## Estimating Pi: Idea

$$ \pi \approx \frac{N_{inner}}{N_{total}} $$

The point $(x, y)$ is located inside the circle with radius R if

$$ \sqrt{x^2 + y^2} \leq R $$

### Algorithm

1. Generate M points (x, y) where both x and y are random numbers in range [-1, 1]
2. Calculate N - the number of points that fall inside a circle with radius R=1, centered at (0,0)
3. Estimate $\pi$ as N / M

The higher the M, the better the precision of $\pi$.

## Implementation in Python

```Python
from random import random
from math import sqrt

def is_inside(x, y):
    return sqrt(x**2 + y**2) < 1
    
def generate_point():
    x = random()
    y = random()
    return (x, y)
    
def estimate_pi(m):
    points = [generate_point() for _ in range(m)]
    n = sum([is_inside(*point) for point in points])
    return 4 * n / m
    
print(estimate_pi(100))
```

## Implementation in Pharo

```Smalltalk
Circle >> contains: point
    ^ (point x - origin x) ** 2 + (point y - origin y) ** 2 < radius.
    
PiEstimator >> initialize
    super initialize.
    circle := Circle origin: 0@0 radius: 1.
    
PiEstimator >> generatePoint
    ^ random next @ random next
    
PiEstimator >> estimatePi
    | points pointsInsideCircle |
    
    points := (1 to: numberOfPoints) collect: [ :i | self generatePoint ].
    pointsInsideCircle := points select: [ :point | circle includes: point ].
    
    ^ pointsInsideCircle size / numberOfPoints
```

## Conclusion

