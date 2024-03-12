library("plotly") # Library

pie.plt.soc <- function(x, title = NULL){ # Population portions across regions
  
  pct <- as.numeric((x[,2] / sum(x[,2])) * 100) # percent values
    
  names(pct) <- x[,1] # Region names
  
  pct[length(pct) + 1] <- sum(pct[pct < 1]) # Numbers for others
  
  names(pct)[length(pct)] <- "Others" # Sum values < 1 %
  
  pct = pct[pct > 1] # Reduce values < 1 %
  
  regions <- names(pct) # Give names back
  
  pct <- as.data.frame(pct) # Make it data frame
  
  plot_ly(pct, labels = ~regions, values = ~pct, type = 'pie',
          textposition = 'outside',textinfo = 'percent') %>%
    layout(title = title,
           xaxis = list(showgrid = F, zeroline = F, showticklabels = F),
           yaxis = list(showgrid = F, zeroline = F, showticklabels = F))
}
pie.plt.soc(pop.ru.df, title = "Russian Regions Proportions") # Test
