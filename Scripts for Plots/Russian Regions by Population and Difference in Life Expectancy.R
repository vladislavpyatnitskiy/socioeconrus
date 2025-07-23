lapply(c("ggplot2", "ggrepel"), require, character.only = T) # Libraries

scatter.plt.soc.pop.dif <- function(x){ # Difference with Life Expectancy
  
  N <- nchar(median(x[,"Population"])) - 1
  
  if (N < 3){ l <- c(0, NULL) }
  
  else if (N >= 3 & N < 6){ l <- c(3, "thousands") } 
  
  else if (N >= 6){ l <- c(6, "millions") } 
  
  x[,"Population"] <- as.numeric(x[,"Population"]) / 10 ^ as.numeric(l[1])
  
  xlab = ifelse(is.null(l[2]), "Population", sprintf("Population in %s", l[2]))
  
  ggplot(
    data = x,
    mapping = aes(
      x=x[,"Population"],
      y=as.numeric(x[,"Difference"]),
      color = x[,"Federal District"],
      label = x[,"Federal District"])
    ) + 
    labs(
      title="Russian Regions by Population and Difference in Life Expectancy",
      x = xlab,
      y = "Difference in Life Expectancy between Women and Men in Russia",
      size = "Population",
      color = "Region"
      ) +
    theme_minimal() +
    geom_text_repel(
      aes(
        label = x[,"Region"],
        fill = x[,"Federal District"],
        size = NULL,
        color = NULL),
      nudge_y = .0125
      ) + 
    guides(
      fill=guide_legend(
        title = "Region",
        override.aes=aes(label = "")
        )
      ) +
    theme(plot.title = element_text(hjust = .5)
          ) +
    geom_point() +
    geom_smooth(method = 'lm', se = F, col = "black") +
    scale_x_continuous(trans = 'log10') +
    guides(size = guide_legend(override.aes = list(linetype = 0))) 
}
scatter.plt.soc.pop.dif(df.new.rus)
