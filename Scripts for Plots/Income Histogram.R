hist.plt.soc <- function(x){ # Histogram Plot of Regions by Income
  
  x <- as.numeric(x) # make values numeric
  
  s.min <- min(x) # Minimum value
  s.max <- max(x) # Maximum value
  
  # Round maximum values
  s.max <- ceiling(round(s.max) / 10 ^ (nchar(round(s.max)) - 1)) *
    10 ^ (nchar(round(s.max)) - 1)
  
  p.seq <- seq(s.max / 20, s.max, s.max / 20) # values for x-axis
  
  # Plot
  hist(x, freq = T, xlab = "Income by Monthly GDP per Capita in US$",
       border = "white", xlim = c(s.min, s.max), col = "steelblue", las = 1,
       breaks = round(length(x), -1),
       main = "Histogram of Russian Regions by GDP per Capita in US$")
  
  for (n in p.seq){ abline(v = n, col = "grey", lty = 3) } #
  
  abline(h = 0) # Add vertical line at y = 0
  axis(side = 1, at = p.seq) # Set x-axis values
  
  for (n in seq(1, 100, 1)){ abline(h = n, col = "grey", lty = 3) } # y-axis
  
  for (n in 1:2){ axis(side = 2 * n, at = seq(100, 0), las = 1) } # Set y-axes
  
  par(mar = c(4, 4, 4, 4)) # Define borders of the plot
  
  # Add Normal Distribution
  lines(seq(s.min, s.max, by = 1),
        dnorm(seq(s.min, s.max, by = 1), mean = mean(x),
              sd = sd(x)) * max(x) * 2, col = "red3", lwd = 2)
  
  box() # Define borders
}
hist.plt.soc(rus.bubble.df1[,3]) # Test
