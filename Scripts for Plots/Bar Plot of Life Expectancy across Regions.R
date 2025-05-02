bar.plt.soc.y <- function(x){ # Life Expectancy across Regions
  
  pct <- data.frame(x[,1], as.numeric(x[,4])) # Create Separate Data Frame
  
  v <- pct[,2] # Make a vector
  
  names(v) <- pct[,1] # Assign names
  
  C = c("#466791","#60bf37","#953ada","#4fbe6c","#ce49d3","#a7b43d","#5a51dc",
        "#d49f36","#552095","#507f2d","#db37aa","#84b67c","#a06fda","#df462a",
        "#5b83db","#c76c2d","#4f49a3","#82702d","#dd6bbb","#334c22","#d83979",
        "#55baad","#dc4555","#62aad3","#8c3025","#417d61","#862977","#bba672",
        "#403367","#da8a6d","#a79cd4","#71482c","#c689d0","#6b2940","#d593a7",
        "#895c8b","#bd5975") # Colours
  
  v <- sort(v, decreasing = T) # Sort values
  
  B <- barplot(v, las = 2, ylim = c(min(v) - 1, max(v) + 1), xpd = F, col = C,
               main = "Bar Plot of Life Expectancy across Regions") 
  
  grid(nx = 1, ny = NULL, col = "grey", lty = 3, lwd = 1) # Horizontal lines
  abline(v = B, col = "grey", lty = 3) # Put vertical lines
  
  cols = c("red", "green") # Colours
  vals = list(mean(v), median(v)) # Mean, Median & Rep rate
  
  legend(x="bottom",inset=c(0, -0.55),cex=.85,bty="n",horiz=T,xpd=T, pch = 15,
         legend = c((sprintf("Mean: %s", round(vals[[1]], 2))),
                    sprintf("Median: %s", round(vals[[2]], 2))), col=cols)
  
  for (n in 1:2){ abline(h = vals[[n]], col = cols[n], lwd = 3) }
  
  axis(side = 4, las = 2)
  
  par(mar = c(12, 4.5, 3, 4.5)) # Define borders of the plot
  
  box() # Put Bar Plot into box
}
bar.plt.soc.y(rus.bubble.df1) # Test
