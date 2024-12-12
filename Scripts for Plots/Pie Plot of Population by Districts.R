pie.plt.soc.group <- function(x){ # Population by districts
  
  pct <- data.frame(x[,2], x[,5]) # Federal District and Population data
  
  colnames(pct) <- c("Federal District", "Portion") # Assign column names
  
  pct <- aggregate(Portion ~ `Federal District`, data = pct, sum) # Sum
  
  pct[,2] <- round((pct[,2] / sum(pct[,2])) * 100, 2) # Round
  
  C = c("#466791","#60bf37","#953ada","#4fbe6c","#ce49d3","#a7b43d","#5a51dc",
        "#d49f36","#552095","#507f2d","#db37aa","#84b67c","#a06fda","#df462a",
        "#5b83db","#c76c2d","#4f49a3","#82702d","#dd6bbb","#334c22","#d83979",
        "#55baad","#dc4555","#62aad3","#8c3025","#417d61","#862977","#bba672",
        "#403367","#da8a6d","#a79cd4","#71482c","#c689d0","#6b2940","#d593a7",
        "#895c8b","#bd5975") # Colours
  
  pie(pct[,2], labels = c(sprintf("%s %s%%", pct[,1], pct[,2])), col = C,
      main = "Russian Population by Federal Districts", radius = 1.75) # Plot
}
pie.plt.soc.group(rus.bubble.df1) # Test
