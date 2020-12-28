source('theme.R')
source('colors.R')

library(ggplot2)
library(ggthemes)
library(grid)
library(gridExtra)
library(scales)

library(dplyr)

# https://www.kaggle.com/trpearce/movie-ratings
movies <- read.csv('/Users/oleks/Downloads/Movie-Ratings.csv')

movies <- movies %>% rename(
  Title = Film,
  Rotten.Tomatoes.Ratings = Rotten.Tomatoes.Ratings..,
  Audience.Ratings = Audience.Ratings..,
  Budget = Budget..million...,
  Year = Year.of.release
)

movies <- movies %>% filter(Genre == 'Action' | Genre == 'Comedy')

colors <- c(blue, red)

p1 <- ggplot(movies, aes(x=Budget, y=Audience.Ratings)) +
  geom_point(aes(color=Genre)) +
  geom_rug(aes(color=Genre), alpha=0.2) + 
  scale_color_manual(values=colors) +
  labs(x="Budget", y="Ratings") +
  theme_Publication() +
  theme(legend.position = "none", panel.grid.major=element_blank())

p2 <- ggplot(movies, aes(x=log(Budget), y=Audience.Ratings)) +
  geom_point(aes(color=Genre)) +
  geom_rug(aes(color=Genre), alpha=0.2) + 
  scale_color_manual(values=colors) +
  labs(x="Budget (normalized)", y="Ratings") +
  theme_Publication() +
  theme(legend.position = "none", panel.grid.major=element_blank())

p3 <- ggplot(movies, aes(x=Budget, y=Audience.Ratings)) +
  geom_point(aes(color=Genre)) +
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