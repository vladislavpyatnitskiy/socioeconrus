stack.bar.plt.pop.gender <- function(x){ # Stacked Bar Plot by Gender
  
  y <- as.character(seq(1950, 2050, 5)) # list with years
  
  D <- NULL #
  
  for (m in 1:length(y)){ # Get and transform data for each year
    
    f <- read.csv2(file =
                     url(sprintf("https://www.%s.net/api/pp/%s/%s/?csv=true",
                                 "populationpyramid", x, y[m]))) 
    
    df <- NULL # name for data frame
    
    for (n in 1:nrow(f)){ # Divide column into three
      
      df <- rbind.data.frame(df, unlist(strsplit(as.character(f[n,]), "\\,")))}
    
    colnames(df) <- c("Age", "Male", "Female") # Column names
    
    df <- df[,-1] # Reduce excessive column
    
    for (n in 1:2){ df[,n] <- as.numeric(df[,n]) } # make columns numeric
    
    df <- colSums(df, na.rm = T) # sum for each gender
    
    df <- as.data.frame(df) # Change format to data frame
    
    df <- data.frame(rownames(df), df[,1]) # 
    
    rownames(df) <- c(1, 2) # Change row names to default one
    
    colnames(df) <- c("Gender", y[m]) # Column names
    
    if (is.null(D)){ D <- df } else { D <- merge(D, df, by = "Gender") } } 
  
  df.plt <- NULL # 
  
  for (n in 1:nrow(D)){ for (j in 2:ncol(D)){ # Optimise for ggplot2 format
    
      df.plt <- rbind.data.frame(df.plt, cbind(D[n,1], colnames(D)[j],
                                               as.numeric(D[n,j]))) } }
  
  colnames(df.plt) <- c("Gender", "Year", "Population") # Column names
  
  df.plt$Gender <- factor(df.plt$Gender,level=unique(df.plt$Gender), ordered=F)
  
  df.plt[,3] <- as.numeric(df.plt[,3]) # Change column format to numeric
  
  C = c("red4", "navy") # Colours
  
  ggplot(df.plt, aes(x = Year, y=Population, fill=Gender)) + theme_minimal() +
    geom_bar(position = "fill", stat = "identity") + 
    labs(title = "Russian Population Dynamics by Genders", x = "Years",
         y = "Portions", fill = "Gender") + scale_fill_manual(values = C) +
    scale_y_continuous(breaks = seq(0, 1, 0.05),
                       sec.axis = ggplot2::sec_axis(~.,
                                                    breaks = seq(0,1,.05))) 
}
stack.bar.plt.pop.gender("643") # Test
