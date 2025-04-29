bar.plt.soc.group.y.diff <- function(x){ # Difference in life expectancy
  
  # Aggregate life expectancy data to get median values for each district
  x <- aggregate(`Difference` ~ `Federal District`, data = x, median)
  
  v <- x[,2] # Make a vector
  
  names(v) <- x[,1] # assign names
  
  C = c("#466791","#60bf37","#953ada","#4fbe6c","#ce49d3","#a7b43d","#5a51dc",
        "#d49f36","#552095","#507f2d","#db37aa","#84b67c","#a06fda","#df462a",
        "#5b83db","#c76c2d","#4f49a3","#82702d","#dd6bbb","#334c22","#d83979",
        "#55baad","#dc4555","#62aad3","#8c3025","#417d61","#862977","#bba672",
        "#403367","#da8a6d","#a79cd4","#71482c","#c689d0","#6b2940","#d593a7",
        "#895c8b","#bd5975") # Colours
  
  v <- sort(v, decreasing = T) # Sort values
  
  B <- barplot(v, las = 1, ylim = c(min(v) - 1, max(v) + 1), xpd = F, col = C,
               main = "Difference of Life Expectancy across Federal Districts", 
               sub="Note: Difference between Female & Male Life Expectancy") 
  
  grid(nx = 1, ny = NULL, col = "grey", lty = 3, lwd = 1) # Horizontal lines
  abline(v = B, col ="grey",lty = 3) # Vertical lines
  
  cols = c("red", "green") # Colours
  vals = list(mean(v), median(v)) # Mean & Median lines
  
  # Legend for Mean and Median lines
  legend(x="bottom", inset=c(0, -.175), cex=.85, bty="n", horiz=T, col = cols,
         legend = c((sprintf("Mean: %s", round(mean(v), 2))),
                    sprintf("Median: %s", round(median(v), 2))), xpd=T, pch=15)
  
  for (n in 1:2){ abline(h = vals[n], col = cols[n], lwd = 3) }
  
  axis(side = 4, las = 2) # Right y-axis
  
  par(mar = c(6, 4, 4, 4)) # Define borders of the plot
  
  box() # Put Bar Plot into box
}
bar.plt.soc.group.y.diff(merge(rus.bubble.df1[,1:2], dif.df)) 
