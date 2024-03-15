bar.plt.soc.group.f <- function(x, main = NULL){ # Fertility Rates by Districts
  
  pct <- data.frame(x[,2], as.numeric(x[,3])) # Create Separate Data Frame
  
  colnames(pct) <- c("Federal District", "Fertility Rate") # Column names
  
  # Aggregate life expectancy data to get median values for each district
  pct <- aggregate(`Fertility Rate` ~ `Federal District`, data=pct, median)
  
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
  
  p.seq <- seq(round(min(v), 1), round(max(v),1), by = .1) 
  
  bar.plt.script <- barplot(v, las = 1,ylim=c(round(min(v),1),round(max(v),1)),
                            xpd = F, col = colors37, main = main) # Plot
  
  for (n in p.seq){ abline(h = n, col ="grey",lty = 3) } # Put horiz lines
  abline(v = bar.plt.script, col ="grey",lty = 3) # Put vertical lines
  abline(h = mean(v), col = "red", lwd = 3) # Mean percentage line
  abline(h = median(v), col = "green", lwd = 3) # Median percentage line
  
  # Legend for Mean and Median lines
  legend("topright", legend=c((sprintf("Mean:    %s",round(mean(v),2))),
                              sprintf("Median: %s", round(median(v),2))),
         fill = c("red", "green"), cex = .8, bty = "n")
  
  axis(side = 2, las = 1) # Set up y-axis
  axis(side = 4, at = p.seq, las = 1) # Set up y-axis
  par(mar = c(4, 4, 4, 4))
  box() # Put Bar Plot into box
}
bar.plt.soc.group.f(fer.ru.df,
                    main =
                      "Bar Plot of Fertility Rate across Federal Districts") 
