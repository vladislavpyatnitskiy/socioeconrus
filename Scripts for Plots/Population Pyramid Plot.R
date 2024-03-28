library("ggplot2") # Library

pyramid.plt.ru <- function(x){ # Population Pyramid of Russia
  
  y <- sprintf("https://www.populationpyramid.net/api/pp/643/%s/?csv=true", x)
  
  y <- read.csv2(file = url(y)) # Download CSV file from website
  
  df <- NULL # name for data frame
  
  for (n in 1:nrow(y)){ # Divide column into three
    
    df <- rbind.data.frame(df, unlist(strsplit(as.character(y[n,]), "\\,"))) }
  
  colnames(df) <- c("Age", "Male", "Female") # Column names
  
  df.plt <- NULL
  
  for (n in 1:nrow(df)){ # Optimise for ggplot2 format
    
    df.plt <- rbind.data.frame(df.plt, rbind(c(df[n,1], colnames(df)[2],
                                               as.numeric(df[n,2])),
                                             c(df[n,1], colnames(df)[3],
                                               as.numeric(df[n,3])))) }
  
  # Calculate percentage of each gender and age group
  df.plt[,ncol(df.plt) + 1] <- (as.numeric(df.plt[,3]) /
                                  sum(as.numeric(df.plt[,3]))) * 100
  
  colnames(df.plt) <- c("Age", "Gender", "Number", "Percent") # Column names
  
  # Make age factor so it woill not be sorted according to numbers
  df.plt$Age <- factor(df.plt$Age, level = unique(df.plt$Age), ordered = F)
  
  df.plt$b <- ifelse(df.plt$Gender == "Male", -1, 1) # Colour column
  
  df.plt <- df.plt[order(-df.plt$b), ] # Order in a descending way
  
  df.plt[,4] <- df.plt[,4] * df.plt[,5] # 
  
  ggplot(df.plt) +
    geom_bar(aes(x = Percent, y = Age, fill = Gender), stat = "identity") +
    labs(title = sprintf("Population Pyramid of Russia in %s", x),
         x = "Percentage (%)", y = "Age Group") +
    scale_x_continuous(breaks = seq(-10, 10, 1)) +
    theme_minimal() + scale_fill_manual(values = c("red4", "steelblue"))
}
pyramid.plt.ru("2023")
