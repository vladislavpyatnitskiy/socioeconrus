hist.plt.year <- function(x){ # Histogram Plot of Regions by Life Expectancy
  
  x <- as.numeric(x[,"Life Expectancy"])
  
  s.min <- min(x) # Minimum value
  s.max <- max(x) # Maximum value
  
  hist(
    x,
    freq = T,
    xlab = "Years",
    border = "white",
    xlim = c(s.min, s.max),
    col = "steelblue",
    las = 1,
    breaks = round(length(x), -1),
    main = "Histogram of Life Expectancies by Russian Regions"
    )
  
  grid(nx = NULL, ny = NULL, col = "grey", lty = 3, lwd = 1) # Grid
  
  abline(h = 0) # Add vertical line at y = 0
  
  axis(side = 4, las = 2) # Right Y-axis
  
  R <- seq(round(s.min, -1), s.max, by = 0.01) # Range for Normal Distribution
  
  lines(
    R,
    dnorm(R, mean = mean(x), sd = sd(x)) * s.max / 4,
    col = "red3",
    lwd = 3
    ) # Add Normal Distribution
  
  par(mar = rep(4, 4)) # Define borders of the plot
  
  box() # Define borders
}
hist.plt.year(rus.bubble.df1) 
