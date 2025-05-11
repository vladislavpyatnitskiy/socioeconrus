hist.plt.income <- function(x){ # Histogram Plot of Regions by Income
  
  x <- as.numeric(x[,"Income"]) # make values numeric
  
  s.min <- min(x) # Value minimum
  s.max <- max(x) # Value maximum
  
  hist(
    x,
    freq = T,
    xlab = "Income by Monthly GDP per Capita in US$",
    border = "white",
    xlim = c(s.min, s.max),
    col = "steelblue",
    las = 1,
    breaks = round(length(x), -1),
    main = "Histogram of Russian Regions by GDP per Capita in US$"
    ) # Plot
  
  grid(nx = NULL, ny = NULL, col = "grey", lty = 3, lwd = 1) # Grid
  
  abline(v = mean(x), col = "gold", lty = 8, lwd = 3) # Mean (average) value
  
  abline(h = 0) # Add vertical line at y = 0
  
  axis(side = 4, las = 2) # Right Y-axis
  
  par(mar = rep(4, 4)) # Define borders of the plot
  
  R <- seq(s.min, s.max, by = 1) # Range
  
  lines(
    R,
    dnorm(R, mean = mean(x), sd = sd(x)) * max(x) * 2,
    col = "red3",
    lwd = 2
    ) # Normal Distribution
  
  box() # Define borders
}
hist.plt.income(rus.bubble.df1) # Test
