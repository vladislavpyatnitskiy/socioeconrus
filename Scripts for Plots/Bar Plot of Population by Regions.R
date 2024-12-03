bar.plt.soc.pop <- function(x){ # Bar Plot of Region Populations
  
  df <- as.numeric(x[,5]) / 10 ^ 6 # Numeric values
  
  m <- max(df) # Set maximum value
  
  names(df) <- x[,1] # Give region names
  
  df <- sort(df, decreasing = T) # Sort in a descending way
  
  # Calculate ceiling value for axes
  m <- ceiling(round(m) / 10^(nchar(round(m)) - 1)) * 10^(nchar(round(m)) - 1)
  
  C = c("#466791","#60bf37","#953ada","#4fbe6c","#ce49d3","#a7b43d","#5a51dc",
        "#d49f36","#552095","#507f2d","#db37aa","#84b67c","#a06fda","#df462a",
        "#5b83db","#c76c2d","#4f49a3","#82702d","#dd6bbb","#334c22","#d83979",
        "#55baad","#dc4555","#62aad3","#8c3025","#417d61","#862977","#bba672",
        "#403367","#da8a6d","#a79cd4","#71482c","#c689d0","#6b2940","#d593a7",
        "#895c8b","#bd5975") # Colours
  
  bar.plt.script <- barplot(df, names.arg = names(df), las = 2,col = C, xpd=T,
                            main = "Regions by Population (millions)",
                            ylim = c(0, max(df) + 1)) # Plot script
  
  p.seq <- round(seq(0, m, m / 20), 1) # Set axes values
  
  for (n in p.seq){ abline(h = n, col = "grey", lty = 3) } # Put horiz lines
  abline(v = bar.plt.script, col = "grey", lty = 3) # Put vertical lines
  
  cols = c("red", "green") # Colours
  vals = list(list(mean(df), median(df)), cols) # Mean & Median lines
  
  legend(x="bottom",inset=c(0, -.6),cex=.85,bty="n",horiz=T,xpd=T, col=cols,
         legend = c((sprintf("Mean: %s", round(mean(df), 2))),
                    sprintf("Median: %s", round(median(df), 2))), pch=15) 
  
  for (n in 1:2){ abline(h = vals[[1]][[n]], col = vals[[2]][n], lwd = 3) }
  for (n in 1:2){ axis(side = 2 * n, at = p.seq, las = 1) } # Set up y-axis
  
  par(mar = c(10, 4, 3, 4)) # Define borders of the plot
  
  box() # Put borders
}
bar.plt.soc.pop(rus.bubble.df1) # Test
