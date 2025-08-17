lapply(c("ggplot2", "ggrepel"), require, character.only = T) # Libs

pop.life.exp.plt <- function(x){
  
  N <- nchar(median(x[,"Population"])) - 1
  
  if (N < 3){ l <- c(0, NULL) }
  
  else if (N >= 3 & N < 6){ l <- c(3, "thousands") } 
  
  else if (N >= 6){ l <- c(6, "millions") } 
  
  x[,"Population"] <- as.numeric(x[,"Population"]) / 10 ^ as.numeric(l[1])
  
  size = ifelse(is.null(l[2]), "Population", sprintf("Population in %s", l[2]))
  
  ggplot(
    data = x,
    mapping = aes(
      x = as.numeric(x[,"Population"]),
      y = as.numeric(x[,"Life Expectancy"]),
      color = x[,"Federal District"],
      label = x[,"Federal District"])) +
    geom_point() +
    labs(
      title="Scatter Plot of Regions by Population and Life Expectancy",
      x = size,
      y = "Life Expectancy (Years)",
      color = "Region") +
    geom_text_repel(
      aes(
        label = x[,"Region"],
        fill = x[,"Federal District"]),
      nudge_y = .0125) + 
    guides(fill=guide_legend(title = "Region", override.aes=aes(label = ""))) +
    theme(plot.title = element_text(hjust = .5)) +
    theme_minimal() +
    scale_x_continuous(trans='log10') +
    geom_smooth(method = 'lm', se = F, col = "black") +
    guides(size = guide_legend(override.aes = list(linetype = 0))) 
}
pop.life.exp.plt(rus.bubble.df.new)
