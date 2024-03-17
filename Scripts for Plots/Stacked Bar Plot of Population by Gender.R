library("ggplot2") # library

stack.bar.plt.ru <- function(x, portion = F){ # Population Pyramid of Russia
  
  f <- read.csv2(file = url(x)) # Download CSV file from website
  
  df <- NULL # name for data frame
  
  for (n in 1:nrow(f)){ # Divide column into three
    
    df <- rbind.data.frame(df, unlist(strsplit(as.character(f[n,]), "\\,"))) }
  
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
  
  if (isFALSE(portion)){ # Plot values
    
    ggplot(df.plt) +
      geom_bar(aes(x = Age, y = Percent, fill = Gender), position = "stack",
               stat = "identity") +
      labs(title = "Stacked Bar Plot of Russia's Population",
           x = "Age Group", y = "Percentage") +
      theme_minimal() + scale_fill_manual(values = c("red4", "steelblue")) +
      scale_y_continuous(breaks = seq(0, 100, 0.5),
                         sec.axis=ggplot2::sec_axis(~.,breaks = seq(0,100,.5)))
    
    } else { # Plot of portions
  
    ggplot(df.plt) +
      geom_bar(aes(x = Age, y = Percent, fill = Gender), position = "fill",
               stat = "identity") +
      labs(title = "Stacked Bar Plot of Russia's Population by Portion",
           x = "Age Group", y = "Percentage") +
      theme_minimal() + scale_fill_manual(values = c("red4", "steelblue")) +
      scale_y_continuous(breaks = seq(0, 1, 0.05),
                         sec.axis = ggplot2::sec_axis(~.,
                                                      breaks = seq(0,1,.05))) }
}
stack.bar.plt.ru("https://www.populationpyramid.net/api/pp/643/2020/?csv=true",
                 portion = T)
