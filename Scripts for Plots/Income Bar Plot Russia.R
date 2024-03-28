bar.plt.soc <- function(x){ # Bar Plot of Population's Monthly Income
  
  df <- as.numeric(x[,3]) # Numeric values
  
  m <- max(df) # Set maximum and minimum values
  mn <- min(df)
  
  names(df) <- x[,1] # Give region names
  
  df <- sort(df, decreasing = T) # Sort in a descending way
  
  # Calculate ceiling value for axes
  mn <- trunc(round(mn)/10^(nchar(round(mn)) - 1)) * 10^(nchar(round(mn)) - 1)
  m <- ceiling(round(m) / 10^(nchar(round(m)) - 1)) * 10^(nchar(round(m)) - 1)
  
  # Colours
  colors37 = c("#466791","#60bf37","#953ada","#4fbe6c","#ce49d3","#a7b43d",
               "#5a51dc","#d49f36","#552095","#507f2d","#db37aa","#84b67c",
               "#a06fda","#df462a","#5b83db","#c76c2d","#4f49a3","#82702d",
               "#dd6bbb","#334c22","#d83979","#55baad","#dc4555","#62aad3",
               "#8c3025","#417d61","#862977","#bba672","#403367","#da8a6d",
               "#a79cd4","#71482c","#c689d0","#6b2940","#d593a7","#895c8b",
               "#bd5975")
  
  # Plot script
  plt.script <- barplot(df, names.arg = names(df), las = 2, col = colors37,
                        main="Russian Regions by Montly GDP per Capita in $US",
                        ylim = c(mn, m), xpd = F)
  
  par(mar = c(10, 4, 3, 4)) # Define borders of the plot
  
  p.seq <- seq(mn, m, 100) # Set axes values
  
  for (n in p.seq){ abline(h = n, col = "grey", lty=3) } # Put horizontal lines
  abline(v = plt.script, col = "grey",lty = 3) # Put vertical lines
  abline(h = mean(df), col = "red", lwd = 3) # Mean percentage line
  abline(h = median(df), col = "green", lwd = 3) # Median percentage line
  
  legend(x = "bottom", inset = c(0, -0.57), cex = .85, bty = "n", horiz = T,
         legend = c((sprintf("Mean: $%s", round(mean(df), 2))),
                    sprintf("Median: $%s", round(median(df), 2))),
         col = c("red", "green"), xpd = T, pch = 15)
  
  for (n in 1:2){ axis(side = 2 * n, at = p.seq, las = 1) } # Set y-axes
  
  box() # Put borders
}
bar.plt.soc(rus.bubble.df1) # Test
