bar.plt.soc.pop <- function(x){ # Bar Plot of Region Populations
  
  df <- as.numeric(x[,"Population"]) / 10 ^ 6 # Numeric values
  
  names(df) <- x[,1] # Give region names
  
  df <- sort(df, decreasing = T) # Sort in a descending way
  
  C = c("#466791","#60bf37","#953ada","#4fbe6c","#ce49d3","#a7b43d","#5a51dc",
        "#d49f36","#552095","#507f2d","#db37aa","#84b67c","#a06fda","#df462a",
        "#5b83db","#c76c2d","#4f49a3","#82702d","#dd6bbb","#334c22","#d83979",
        "#55baad","#dc4555","#62aad3","#8c3025","#417d61","#862977","#bba672",
        "#403367","#da8a6d","#a79cd4","#71482c","#c689d0","#6b2940","#d593a7",
        "#895c8b","#bd5975") # Colours
  
  B <- barplot(
    df,
    las = 2,
    col = C,
    xpd = T,
    main = "Regions by Population (millions)",
    ylim = c(0, max(df) + 1)
    ) # Plot script
  
  grid(nx = 1, ny = NULL, col = "grey", lty = 3, lwd = 1) # Horizontal lines
  abline(v = B, col = "grey", lty = 3) # Vertical lines
  
  cols = c("red", "green") # Colours
  vals = list(mean(df), median(df)) # Mean & Median lines
  
  legend(
    x = "bottom",
    inset = c(0, -.55),
    cex = .95,
    bty = "n",
    horiz = T,
    xpd = T,
    col = cols,
    pch = 15,
    legend = c(
      (
        sprintf(
          "Mean: %s", round(mean(df), 2)
          )
        ),
      sprintf(
        "Median: %s", round(median(df), 2)
        )
      )
    ) 
  
  for (n in 1:2){ abline(h = vals[[n]], col = cols[n], lwd = 3) }
  
  axis(side = 4, las = 2)
  
  par(mar = c(12, 4, 3, 4)) # Define borders of the plot
  
  box() # Put borders
}
bar.plt.soc.pop(rus.bubble.df1) # Test
