bar.plt.soc.group <- function(x){ # Bar Plot of Population by Districts
  
  x <- aggregate(Population ~ `Federal District`, data = x, sum) # Sum
  
  regions <- x[,1] # Make Federal District names as row names
  
  pct <- x[,-1] # Reduce excessive names 
  
  names(pct) <- regions # Put names 
  
  pct <- sort(pct, decreasing = T) / 10 ^ 6 # Sort values
  
  C = c("#466791","#60bf37","#953ada","#4fbe6c","#ce49d3","#a7b43d","#5a51dc",
        "#d49f36","#552095","#507f2d","#db37aa","#84b67c","#a06fda","#df462a",
        "#5b83db","#c76c2d","#4f49a3","#82702d","#dd6bbb","#334c22","#d83979",
        "#55baad","#dc4555","#62aad3","#8c3025","#417d61","#862977","#bba672",
        "#403367","#da8a6d","#a79cd4","#71482c","#c689d0","#6b2940","#d593a7",
        "#895c8b","#bd5975") # Colours
  
  B <- barplot(
    pct,
    ylim = c(min(pct) - 1, max(pct) + 1),
    col = C,
    las = 1,
    xpd = F,
    main = "Population among Federal Districts in millions"
    )
  
  par(mar = c(4, 4, 4, 4)) # Define borders of the plot
  
  grid(nx = 1, ny = NULL, col = "grey", lty = 3, lwd = 1) # Horizontal lines
  abline(v = B, col = "grey", lty = 3) # Put vertical lines
  
  abline(h = mean(pct), col = "red", lwd = 3) # Mean percentage line
  abline(h = median(pct), col = "green", lwd = 3) # Median percentage line
  
  legend(
    "bottom",
    xpd = T,
    col = c("red", "green"),
    pch = 15,
    cex = .8,
    bty = "n",
    horiz = T,
    inset = c(0,-.165),
    legend = c(
      (
        sprintf(
          "Mean: %s millions", round(mean(pct), 2)
          )
        ),
      sprintf(
        "Median: %s millions", round(median(pct), 2)
        )
      )
    ) 
  
  axis(side = 4, las = 2)
  
  box() # Put Plot in Box
}
bar.plt.soc.group(rus.bubble.df1[,c(2,5)]) # Test
