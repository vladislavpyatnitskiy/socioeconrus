library("ggplot2") # Library

pyramid.plt.ru <- function(x, c, name = NULL){ # Population Pyramid of Russia
  
  y <- sprintf("https://www.populationpyramid.net/api/pp/%s/%s/?csv=true",c,x)
  
  y <- read.csv2(file = url(y)) # Download CSV file from website
  
  df <- NULL # name for data frame
  
  for (n in 1:nrow(y)){ # Divide column into three
    
    df <- rbind.data.frame(df, unlist(strsplit(as.character(y[n,]), "\\,"))) }
  
  colnames(df) <- c("Age", "Male", "Female") # Column names
  
  D <- NULL # Optimise for ggplot2 format
  
  for (n in 1:nrow(df)){ # Optimise for ggplot2 format
    
    D <- rbind.data.frame(D, rbind(c(df[n,1], colnames(df)[2],
                                     as.numeric(df[n,2])),
                                   c(df[n,1], colnames(df)[3],
                                     as.numeric(df[n,3])))) }
  
  # Calculate percentage of each gender and age group
  D[,ncol(D) + 1] <- (as.numeric(D[,3]) / sum(as.numeric(D[,3]))) * 100
  
  colnames(D) <- c("Age", "Gender", "Number", "Percent") # Column names
  
  # Make age factor so it woill not be sorted according to numbers
  D$Age <- factor(D$Age, level = unique(D$Age), ordered = F)
  
  D$b <- ifelse(D$Gender == "Male", -1, 1) # Colour column
  
  D <- D[order(-D$b), ] # Order in a descending way
  
  D[,4] <- D[,4] * D[,5] # 
  
  N <- ifelse(is.null(name), sprintf("Population Pyramid in %s", x),
              sprintf("Population Pyramid of %s in %s", name, x))
  
  ggplot(D) + geom_bar(aes(x=Percent, y=Age, fill=Gender), stat = "identity") +
    labs(title = N, x = "Percentage (%)", y = "Age Group") +
    scale_x_continuous(breaks = seq(-10, 10, 1)) +
    theme_minimal() + scale_fill_manual(values = c("red4", "steelblue"))
}
pyramid.plt.ru(2025, 643, "Russia")
