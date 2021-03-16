source('theme.R')
source('colors.R')

library(latex2exp)
library(ggplot2)
library(ggthemes)
library(grid)
library(gridExtra)
library(scales)

library(carData)

data(Salaries)

colors <- c(red, yellow, blue)

levels(Salaries$rank) <- c(
  "Assistant Professor",
  "Associate Professor",
  "Professor")

normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

p1 <- ggplot(Salaries, aes(x=yrs.since.phd, y=salary)) +
  geom_point(aes(color=rank)) +
  scale_color_manual(values=colors) +
  labs(x="Years since PhD", y="Nine-month salary") +
  scale_x_continuous(label=comma, breaks=c(max(Salaries$yrs.since.phd)), limits=c(0, max(Salaries$salary))) +
  scale_y_continuous(label=dollar_format(), breaks=c(min(Salaries$salary), max(Salaries$salary)), limits=c(0, max(Salaries$salary))) +
  theme_Publication() +
  theme(legend.position = "none", panel.grid.major=element_blank())

p2 <- ggplot(Salaries, aes(x=normalize(yrs.since.phd), y=normalize(salary))) +
  geom_point(aes(color=rank)) +
  scale_color_manual(values=colors) +
  scale_x_continuous(breaks=c(0, 1)) +
  scale_y_continuous(breaks=c(0, 1)) +
  labs(x="Years since PhD (normalized)", y="Nine-month salary (normalized)") +
  theme_Publication() +
  theme(legend.position = "none", panel.grid.major=element_blank())

p3 <- ggplot(Salaries, aes(x=yrs.since.phd, y=salary)) +
  geom_point(aes(color=rank)) +
  scale_color_manual(values=colors) +
  theme_Publication() +
  theme(legend.title=element_blank(), legend.position="bottom")

# Create user-defined function, which extracts legends from ggplots
extract_legend <- function(my_ggp) {
  step1 <- ggplot_gtable(ggplot_build(my_ggp))
  step2 <- which(sapply(step1$grobs, function(x) x$name) == "guide-box")
  step3 <- step1$grobs[[step2]]
  return(step3)
}

# Apply user-defined function to extract legend
shared_legend <- extract_legend(p3)

# Draw plots with shared legend
grid.arrange(arrangeGrob(p1, p2, ncol=2),
             shared_legend, nrow=2, heights = c(6, 1))

values <- runif(30000)
values <- rnorm(10000)
data <- data.frame(values)

ggplot(data, aes(x=values)) +
  geom_histogram(aes(y=..density..), binwidth=.1, colour="black", fill="white") +
  #annotate("rect", xmin=0, xmax=1, ymin=0, ymax=1,
  #         alpha = .2, fill = "#FF6666") +
  #scale_x_continuous(breaks=c(0, 1)) +
  geom_density(alpha=.2, fill="#FF6666") +
  #ggtitle('Uniformly distributed values') +
  theme_Publication() +
  theme(
    panel.grid.major=element_blank(),
    axis.ticks.y=element_blank(),
    axis.text.y=element_blank(),
    axis.line.y=element_blank(),
    axis.title=element_blank())

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


