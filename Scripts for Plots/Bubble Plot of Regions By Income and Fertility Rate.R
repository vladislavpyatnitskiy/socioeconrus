lapply(c("ggplot2", "ggrepel"), require, character.only = T) # Libs

income.fer.plt <- function(x){ # Scatter Plot for Income and Fertility
  
  N <- nchar(median(x[,"Population"])) - 1
  
  if (N < 3){ l <- c(0, NULL) }
  
  else if (N >= 3 & N < 6){ l <- c(3, "thousands") } 
  
  else if (N >= 6){ l <- c(6, "millions") } 
  
  x[,"Population"] <- as.numeric(x[,"Population"]) / 10 ^ as.numeric(l[1])
  
  size = ifelse(is.null(l[2]), "Population", sprintf("Population in %s", l[2]))
  
  ggplot(
    data = x,
    mapping = aes(
      x = as.numeric(x[,"Income"]),
      y = as.numeric(x[,"Fertility Rate"]),
      size = x[,"Population"],
      color = x[,"Federal District"],
      label = x[,"Federal District"])) +
    geom_point() +
    labs(
      title="Bubble Plot of Regions by Income and Fertility Rate",
      x = "Montly GDP per Capita (US$)",
      y = "Fertility Rate per Woman",
      size = size,
      color = "Region") +
    theme_minimal() +
    geom_text_repel(
      aes(
        label = x[,"Region"],
        fill = x[,"Federal District"],
        size = NULL,
        color = NULL),
      nudge_y = .0125) + 
    guides(fill=guide_legend(title = "Region", override.aes=aes(label = ""))) +
    theme(plot.title = element_text(hjust = .5)) +
    geom_smooth(method = 'lm', se = F, col = "black") +
    guides(size = guide_legend(override.aes = list(linetype = 0))) 
}
income.fer.plt(rus.bubble.df.new) # Test
