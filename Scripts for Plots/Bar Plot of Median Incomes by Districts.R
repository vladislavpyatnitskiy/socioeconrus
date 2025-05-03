bar.plt.soc.group.i <- function(x){ # Median Income across Federal Districts
  
  pct <- data.frame(x[,2], as.numeric(x[,3])) # Create Separate Data Frame
  
  colnames(pct) <- c("Federal District", "Income") # Column names
  
  # Aggregate Median income data to get median values for each district
  pct <- aggregate(Income ~ `Federal District`, data = pct, median)
  
  v <- pct[,2] # Make a vector
  
  names(v) <- pct[,1] # assign names
  
  C = c("#466791","#60bf37","#953ada","#4fbe6c","#ce49d3","#a7b43d","#5a51dc",
        "#d49f36","#552095","#507f2d","#db37aa","#84b67c","#a06fda","#df462a",
        "#5b83db","#c76c2d","#4f49a3","#82702d","#dd6bbb","#334c22","#d83979",
        "#55baad","#dc4555","#62aad3","#8c3025","#417d61","#862977","#bba672",
        "#403367","#da8a6d","#a79cd4","#71482c","#c689d0","#6b2940","#d593a7",
        "#895c8b","#bd5975") # Colours
  
  v <- sort(v, decreasing = T) # Sort values
  
  B <- barplot(
    v,
    las = 1, 
    ylim = c(min(v) - 10, max(v) + 10),
    xpd = F,
    col = C,
    main = "Median Incomes across Federal Districts"
    ) # Plot
  
  grid(nx = 1, ny = NULL, col = "grey", lty = 3, lwd = 1) # Horizontal lines
  abline(v = B, col = "grey", lty = 3) # Put vertical lines
  
  cols = c("red", "green") # Colours
  vals = list(mean(v), median(v)) # Mean & Median lines
  
  legend(
    "bottom",
    xpd = T,
    col = cols,
    pch = 15,
    cex = .8,
    horiz = T,
    inset = c(0, -.18),
    bty = "n",
    legend = c(
      (sprintf("Mean: US$ %s", round(mean(v), 2))),
      sprintf("Median: US$ %s", round(median(v), 2))
      )
    )
  
  par(mar = c(4, 4, 4, 4)) # Define borders of the plot
  
  for (n in 1:2){ abline(h = vals[[n]], col = cols[n], lwd = 3) }
  
  axis(side = 4, las = 2)
  
  box() # Put Bar Plot into box
}
bar.plt.soc.group.i(rus.bubble.df1) # Test
