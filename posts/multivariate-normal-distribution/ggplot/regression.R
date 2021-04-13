source('theme.R')
source('colors.R')

library(ggplot2)

areas <- runif(50) * 40 + 10
prices <- areas * 10 + 200 + rnorm(length(areas)) * 70

data <- data.frame(
  area = areas,
  price = prices)

ggplot(data, aes(x=area, y=price)) +
  geom_point() +
  #geom_smooth(method='lm', se = FALSE, color=red) +
  ggtitle('Apartment prices') +
  labs(x="Area (sq. m)", y="Price (euros)") +
  theme_Publication() +
  theme(panel.grid.major=element_blank())
