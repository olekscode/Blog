source('theme.R')
source('colors.R')

library(ggplot2)
library(ggthemes)
library(grid)
library(gridExtra)
library(scales)
library(ggforce)
library(MASS)

colors <- c(red, yellow, blue)
n <- 150

sample1 <- mvrnorm(n = n, c(1, 0), matrix(c(1, 0, 0, 1), 2, 2))
sample2 <- mvrnorm(n = n, c(-1, 6), matrix(c(3, 1, 3, 1), 2, 2))
sample3 <- mvrnorm(n = n, c(-4, -2), matrix(c(1, 0, 0, 1), 2, 2))

points <- as.data.frame(rbind(sample1, sample2, sample3))
points <- cbind(rep(c('A', 'B', 'C'), each=n), points)

colnames(points) <- c('class', 'x', 'y')

p1 <- ggplot(points, aes(x, y)) +
  geom_point() + 
  scale_color_manual(values=colors) +
  theme_Publication() +
  theme(
    legend.position = "none",
    panel.grid.major=element_blank(),
    axis.title=element_blank(),
    axis.text=element_blank(),
    axis.ticks=element_blank())

p2 <- ggplot(points, aes(x, y)) +
  geom_point(aes(color=class)) + 
  geom_mark_ellipse(aes(fill=class, color=NA)) +
  scale_color_manual(values=colors) +
  scale_fill_manual(values=colors) +
  theme_Publication() +
  theme(
    legend.position = "none",
    panel.grid.major=element_blank(),
    axis.title=element_blank(),
    axis.text=element_blank(),
    axis.ticks=element_blank())

grid.arrange(arrangeGrob(p1, p2, ncol=2))