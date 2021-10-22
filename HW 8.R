library(tidyverse)
library(ggplot2)
diamonds<- diamonds
ggplot(diamonds, aes(factor(color), (price/carat), fill=color)) + geom_boxplot() + ggtitle("Diamond Price per Carat according Color") + xlab("Color") + ylab("Diamond Price per Carat in US Dollars")



cuberoot_trans = function() trans_new('cuberoot', transform = function(x) x^(1/3), inverse = function(x) x^3)


ggplot(aes(x = carat, y = price, color = color), data = diamonds) + 
  geom_point(alpha = 0.5, size = 1, position = 'jitter') +
  scale_color_brewer(type = 'div',
                     guide = guide_legend(title = 'Cut', 
                                          reverse = T,
                                          override.aes = list(alpha = 1, 
                                                              size = 2))) +  
  scale_x_continuous(trans = cuberoot_trans(), limits = c(0.2, 5),
                     breaks = c(0.2, 0.5, 1, 2, 3, 4, 5)) + 
  scale_y_continuous(trans = log10_trans(), limits = c(350, 30000),
                     breaks = c(350, 1000, 5000, 10000, 15000, 20000, 25000, 30000)) +
  ggtitle('Price by Carat and Color')


