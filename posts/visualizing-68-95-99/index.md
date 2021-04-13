# Visualization of the 68-95-99.7 Rule using ggplot2

```R
library(latex2exp)
library(ggplot2)
library(ggthemes)
library(grid)
library(gridExtra)
library(scales)

values <- rnorm(1000)

ggplot(data.frame(x=rnorm(1000)), aes(x)) +
  stat_function(fun=dnorm, color="black", xlim=c(-3.5, 3.5)) +
  geom_area(stat="function", fun=dnorm, fill="#FF6666", alpha=.1, xlim=c(-3, 3)) +
  geom_area(stat="function", fun=dnorm, fill="#FF6666", alpha=.2, xlim=c(-2, 2)) +
  geom_area(stat="function", fun=dnorm, fill="#FF6666", alpha=.3, xlim=c(-1, 1)) +
  geom_segment(aes(x=-1, xend=1, y=0.43, yend=0.43)) +
  geom_segment(aes(x=-1, xend=-1, y=0.43, yend=dnorm(-1)), linetype='dashed', color="#FF6666") +
  geom_segment(aes(x=1, xend=1, y=0.43, yend=dnorm(1)), linetype='dashed', color="#FF6666") +
  annotate("text", x=0, y=0.45, label="68%") +
  geom_segment(aes(x=-2, xend=2, y=0.48, yend=0.48)) +
  geom_segment(aes(x=-2, xend=-2, y=0.48, yend=dnorm(-2)), linetype='dashed', color="#FF6666") +
  geom_segment(aes(x=2, xend=2, y=0.48, yend=dnorm(2)), linetype='dashed', color="#FF6666") +
  annotate("text", x=0, y=0.5, label="95%") +
  geom_segment(aes(x=-3, xend=3, y=0.53, yend=0.53)) +
  geom_segment(aes(x=-3, xend=-3, y=0.53, yend=dnorm(-3)), linetype='dashed', color="#FF6666") +
  geom_segment(aes(x=3, xend=3, y=0.53, yend=dnorm(3)), linetype='dashed', color="#FF6666") +
  annotate("text", x=0, y=0.55, label="99.7%") +
  scale_x_continuous(
    breaks=c(-3, -2, -1, 0, 1, 2, 3),
    labels=c(TeX('$\\mu-3\\sigma$'), TeX('$\\mu-2\\sigma$'), TeX('$\\mu - \\sigma$'), TeX('$\\mu$'), TeX('$\\mu + \\sigma$'), TeX('$\\mu+2\\sigma$'), TeX('$\\mu+3\\sigma$'))) +
  theme_Publication() +
  theme(
    panel.grid.major=element_blank(),
    axis.ticks.y=element_blank(),
    axis.text.y=element_blank(),
    axis.line.y=element_blank(),
    axis.title=element_blank())
```