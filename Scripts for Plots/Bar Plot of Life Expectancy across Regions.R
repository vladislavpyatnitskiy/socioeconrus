bar.plt.soc.y <- function(x, main = NULL){ # Life Expectancy across Regions
  
  pct <- data.frame(x[,1], as.numeric(x[,4])) # Create Separate Data Frame
  
  v <- pct[,2] # Make a vector
  
  names(v) <- pct[,1] # assign names
  
  # Colours
  colors37 = c("#466791","#60bf37","#953ada","#4fbe6c","#ce49d3","#a7b43d",
               "#5a51dc","#d49f36","#552095","#507f2d","#db37aa","#84b67c",
               "#a06fda","#df462a","#5b83db","#c76c2d","#4f49a3","#82702d",
               "#dd6bbb","#334c22","#d83979","#55baad","#dc4555","#62aad3",
               "#8c3025","#417d61","#862977","#bba672","#403367","#da8a6d",
               "#a79cd4","#71482c","#c689d0","#6b2940","#d593a7","#895c8b",
               "#bd5975")
  
  v <- sort(v, decreasing = T) # Sort values
  
  p.seq <- seq(round(min(v) - 1), round(max(v) + 1), by = 1) # Values for axes
  
  bar.plt.script <- barplot(v, las = 2, ylim = c(min(v) - 1, max(v) + 1),
                            xpd = F, col = colors37, main = main) # Plot
  
  for (n in p.seq){ abline(h = n, col ="grey",lty = 3) } # Put horiz lines
  abline(v = bar.plt.script, col ="grey",lty = 3) # Put vertical lines
  abline(h = mean(v), col = "red", lwd = 3) # Mean percentage line
  abline(h = median(v), col = "green", lwd = 3) # Median percentage line
  
  legend(x = "bottom", inset = c(0, -1.3), cex = .85, bty = "n", horiz = T,
         legend = c((sprintf("Mean: %s", round(mean(v), 2))),
                    sprintf("Median: %s", round(median(v), 2))),
         col = c("red", "green"), xpd = T, pch = 15)
  
  for (n in 1:2){ axis(side=2*n, at=seq(round(max(v),0)+1,
                                        from=round(min(v),0)-1, by=1), las=1) }
  
  par(mar = c(12, 4.5, 3, 4.5)) # Define borders of the plot
  
  box() # Put Bar Plot into box
}
bar.plt.soc.y(rus.bubble.df1,
              main = "Bar Plot of Life Expectancy across Regions") 
