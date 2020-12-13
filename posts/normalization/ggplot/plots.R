library(ggplot2)
library(ggthemes)
library(grid)
library(gridExtra)
library(scales)

library(carData)

data(Salaries)

theme_Publication <- function(base_size=14, base_family="helvetica") {
  (theme_foundation(base_size=base_size)
   + theme(plot.title = element_text(face = "bold",
                                     size = rel(1.2), hjust = 0.5),
           text = element_text(),
           panel.background = element_rect(colour = NA),
           plot.background = element_rect(colour = NA),
           panel.border = element_rect(colour = NA),
           axis.title = element_text(face = "bold",size = rel(1)),
           axis.title.y = element_text(angle=90,vjust =2),
           axis.title.x = element_text(vjust = -0.2),
           axis.text = element_text(), 
           axis.line = element_line(colour="black"),
           axis.ticks = element_line(),
           panel.grid.major = element_line(colour="#f0f0f0"),
           panel.grid.minor = element_blank(),
           legend.key = element_rect(colour = NA),
           legend.title = element_text(face="italic"),
           plot.margin=unit(c(10,5,5,5),"mm"),
           strip.background=element_rect(colour="#f0f0f0",fill="#f0f0f0"),
           strip.text = element_text(face="bold")
   ))
}

lime <- '#c7ea46'
fern <- '#4f7942'
uniform <- '#444c38'
green <- '#66a182'
yellow <- '#edae49'
red <- '#d1495b'
blue <- '#00798c'

colors <- c(red, yellow, green)

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