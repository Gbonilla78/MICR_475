R Notebook
================

# Question 1

## First plot for visualization

``` r
library(tidyverse)
library(ggplot2)
library(scales)



ggplot(diamonds, aes(factor(color), (x=price/carat), fill=color)) + geom_boxplot() + ggtitle("Diamond Price per Carat according Color") + xlab("Color") + ylab("Diamond Price per Carat in US Dollars")
```

![](Hw8_Final_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

# Question 1

## Second plot for visualization

``` r
cuberoot_trans = function()trans_new('cuberoot', transform = function(x) x^(1/3), inverse = function(x) x^3)

ggplot(aes(x = carat, y = price, color = color), data = diamonds) + 
  geom_point(alpha = 0.5, size = 1, position = 'jitter') +
  scale_color_brewer(type = 'div',
                     guide = guide_legend(title = 'Color', 
                                          reverse = T,
                                          override.aes = list(alpha = 1, 
                                                              size = 2))) +  
  scale_x_continuous(trans = cuberoot_trans(), limits = c(0.2, 5),
                     breaks = c(0.2, 0.5, 1, 2, 3, 4, 5)) + 
  scale_y_continuous(trans = log10_trans(), limits = c(350, 30000),
                     breaks = c(350, 1000, 5000, 10000, 15000, 20000, 25000, 30000)) +
  ggtitle('Price by Carat and Color')
```

![](Hw8_Final_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

# Question 2

``` r
library(nls2)
library(broom)


monod_mod <- formula(density ~ (conc*dmax)/(conc + k))

sqrt_mod <- formula(density ~ beta_1 * sqrt(conc) + beta_0)
single_sqrt_model <- nls2(sqrt_mod,
                          data = DNase,
                          start = list(beta_1 = 0.5, beta_0 = 0.1))

compare_models <- DNase %>%
  group_by(Run) %>%
  nest() %>%
  mutate(sqrt_mod = map(data, ~ nls2(
    sqrt_mod,
    data = .,
    start = list(beta_1 = 0.5, beta_0 = 0.1)
  )),
  monod_mod = map(data,  ~ nls2(
    monod_mod, data = ., start = list(dmax = .3, k = .4)
  )),
  sqrt_aic= map_dbl(sqrt_mod,~glance(.)$AIC),
  monod_aic=map_dbl(monod_mod,~glance(.)$AIC))

longer_data <- compare_models %>%
  pivot_longer(sqrt_aic:monod_aic, names_to = "Model", values_to = "Value")%>%
  ggplot(aes(x = Run, y=Value)) +
  facet_wrap(vars(Model), ncol = 3) +
  geom_point() +
  geom_line() +
  labs(x = "Run Number", y = "AIC Value") 


print(longer_data)
```

![](Hw8_Final_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->
