HomeWork 4
================

``` r
library(tidyverse)
library(dplyr)
view(diamonds)
#question 1
diamonds %>% 
  group_by(cut) %>%
  summarise(counts = n())
```

    ## # A tibble: 5 x 2
    ##   cut       counts
    ##   <ord>      <int>
    ## 1 Fair        1610
    ## 2 Good        4906
    ## 3 Very Good  12082
    ## 4 Premium    13791
    ## 5 Ideal      21551

``` r
#question 2
datapercent<-sample_frac(diamonds,0.01)

#question 3
Diamonds1 <-diamonds %>%
  group_by(clarity) %>%
  slice_max(order_by=carat,n=100, with_ties=FALSE)%>%
  summarise(mean_size=mean(carat))
  
  

#question 4
avg_size_filt <- filter(diamonds, y<20, y>0, x>0)
ggplot(data = avg_size_filt, mapping = aes(x = x, y = y)) + geom_point()+labs(title="Diamonds", 
       subtitle="Length versus width",
       caption="Source: Diamonds",
       x="length",
       y="Width")
```

![](R_Hw5_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

``` r
avg_size_filt2 <- filter(diamonds, z <10, z>0, x>0)
ggplot(data = avg_size_filt2, mapping = aes(x = x, y = z)) + geom_point()+labs(title="Diamonds", 
       subtitle="Length versus depth",
       caption="Source: Diamonds",
       x="length",
       y="depth") 
```

![](R_Hw5_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->
