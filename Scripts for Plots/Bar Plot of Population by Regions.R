bar.plt.soc.pop <- function(x){ # Bar Plot of Fertility Rates
  
  df <- as.numeric(x[,5]) / 10 ^ 6 # Numeric values
  
  m <- max(df) # Set maximum value
  
  names(df) <- x[,1] # Give region names
  
  df <- sort(df, decreasing = T) # Sort in a descending way
  
  # Calculate ceiling value for axes
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
  bar.plt.script <- barplot(df,
                            names.arg = names(df),
                            las = 2,
                            col = colors37,
                            main = "Regions by Population (millions)",
                            ylim = c(0, max(df) + 1), 
                            xpd = T)
  
  par(mar = c(10, 4, 3, 4)) # Define borders of the plot
  
  p.seq <- round(seq(0, m, m / 20), 1) # Set axes values
  
  for (n in p.seq){ abline(h = n, col ="grey",lty = 3) } # Put horiz lines
  abline(v = bar.plt.script, col ="grey",lty = 3) # Put vertical lines
  abline(h = mean(df), col = "red", lwd = 3) # Mean percentage line
  abline(h = median(df), col = "green", lwd = 3) # Median percentage line
  
  # Mean and median legend
  legend("topright", legend = c((sprintf("Mean:    %s million",
                                         round(mean(df),2))),
                                sprintf("Median: %s million",
                                        round(median(df),2))),
         fill = c("red", "green"), cex = .8, bty = "n")
  
  axis(side = 2, at = p.seq, las = 1) # Set axes
  axis(side = 4, at = p.seq, las = 1)
  
  box() # Put borders
}
bar.plt.soc.pop(rus.bubble.df1) # Test
