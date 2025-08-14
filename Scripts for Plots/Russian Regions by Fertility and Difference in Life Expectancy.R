lapply(c("ggplot2", "ggrepel"), require, character.only = T)

diff.fer.plt <- function(x){
  
  ggplot(
    data = x,
    mapping = aes(
      x=as.numeric(x[,"Difference"]),
      y=as.numeric(x[,"Fertility Rate"]),
      color = x[,"Federal District"],
      label = x[,"Federal District"])
    ) + 
    labs(
      title="Russian Regions by Fertility and Difference in Life Expectancy",
      x = "Difference in Life Expectancy between Women and Men in Russia",
      y = "Fertility Rate per Woman",
      size = "Population",
      color = "Region") +
    geom_text_repel(
      aes(
        label = x[,"Region"],
        fill = x[,"Federal District"],
        size = NULL,
        color = NULL),
      nudge_y = .0125) + 
    guides(fill=guide_legend(title = "Region", override.aes=aes(label = ""))) +
    theme(plot.title = element_text(hjust = .5)) +
    geom_point() +
    geom_smooth(method = 'lm', se = F, col = "black") +
    theme_minimal() +
    guides(size = guide_legend(override.aes = list(linetype = 0))) 
}
diff.fer.plt(fer.df.dif)
