source('theme.R')
source('colors.R')

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