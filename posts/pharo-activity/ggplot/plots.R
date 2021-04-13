source('colors.R')

library(ggplot2)
library(ggthemes)
library(tidyverse)

weekdays <- c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')

weekdayCommits <- data.frame(
  weekday=weekdays,
  commits=c(9.82, 9.56, 8.86, 8.94, 9.44, 4.49, 5))

weekdayCommits$weekday <- factor(weekdayCommits$weekday, levels=rev(weekdays))

fridayCommits <- data.frame(
  weekday=c('Friday', 'Friday'),
  isSprint=c(FALSE, TRUE),
  commits=c(9.44, 21.55))

overallAverage <- mean(c(9.82, 9.56, 8.86, 8.94, 9.44, 4.49, 5))
weekdayAverage <-mean(c(9.82, 9.56, 8.86, 8.94, 9.44))
weekendAverage <- mean(c(4.49, 5))

baseTheme <- theme(
  legend.position="none",
  panel.grid.major=element_blank(),
  panel.grid.minor=element_blank(),
  panel.background = element_blank(),
  plot.margin=unit(c(10,10,5,5),"mm"),
  axis.text.x=element_blank(),
  axis.ticks.x=element_blank(),
  axis.title = element_blank())

ggplot() +
  geom_col(data=weekdayCommits, aes(x=weekday, y=commits), fill=blue, width=0.4) +
  geom_col(data=fridayCommits, aes(x=weekday, y=commits, fill=isSprint), width=0.8, position='dodge') +
  scale_fill_manual(values=c(blue, lightGrey)) +
  geom_errorbar(
    data=weekdayCommits %>% filter(weekday %in% c('Saturday', 'Sunday')),
    aes(weekday, ymax = mean(commits), ymin = mean(commits)),
    size=0.5,
    linetype='longdash',
    color=red,
    width=1) +
  geom_errorbar(
    data=weekdayCommits %>% filter(!(weekday %in% c('Saturday', 'Sunday'))),
    aes(weekday, ymax = mean(commits), ymin = mean(commits)),
    size=0.5,
    linetype='longdash',
    color=red,
    width=1) +
  geom_errorbar(
    data=weekdayCommits,
    aes(weekday, ymax = mean(commits), ymin = mean(commits)),
    size=0.5,
    linetype='longdash',
    color=red,
    width=1) +
  geom_text(data=weekdayCommits %>% filter(weekday != 'Friday'), aes(x=weekday, y=commits, label=commits), position=position_dodge(width=0.9), hjust=-0.25) +
  geom_text(data=fridayCommits, aes(x=weekday, y=commits, label=commits, fill=isSprint), position=position_dodge(width=0.9), hjust=-0.25) +
  annotate(
    geom='text', x='Sunday', y=weekendAverage + 0.5, 
    label='Weekend average:', hjust='left', vjust='top', size=3.5) +
  ggtitle('Average number of commits in Pharo repository') +
  coord_flip() +
  baseTheme




