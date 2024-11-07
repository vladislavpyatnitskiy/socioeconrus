library(timeSeries) # Library

work.age.plt <- function(x, C = "Country"){ # Population Pyramid of Russia
  
  y <- as.character(seq(1950, 2050, 1)) # list with years
  
  D <- NULL #
  
  for (m in 1:length(y)){ # Get Data for each year
    
    # Download CSV file from website
    f <- read.csv2(file =
                     url(sprintf("https://www.%s.net/api/pp/%s/%s/?csv=true",
                                 "populationpyramid", x, y[m]))) 
    
    df <- NULL # name for data frame
    
    for (n in 1:nrow(f)){ # Divide column into three
      
      df <- rbind.data.frame(df, unlist(strsplit(as.character(f[n,]), "\\,")))}
    
    nums <- df[,1] # Assign Age groups 
    
    df$Total <- sum(as.numeric(df[,2]), as.numeric(df[,3])) # Sum Age Groups
    
    l <- NULL # 
    
    for (n in 1:nrow(df)){ l <- rbind.data.frame(l, sum(as.numeric(df[n,2]),
                                                        as.numeric(df[n,3]))) }
    
    l <- data.frame(df[,1], l) #
    
    colnames(l) <- c("Age", y[m]) # Column names
    
    if (is.null(D)){ D <- l } else { D <- merge(D, l, by = "Age") } } 
  
  D <- D[match(nums, D$Age),] # Change Order of Market Caps
  
  S <- NULL
  
  for (m in 2:ncol(D)){ S <- c(S, sum(D[,m])) }
  
  rownames(D) <- seq(nrow(D))
  
  K <- D[4:13,]
  
  M <- NULL
  
  for (m in 2:ncol(K)){ M <- c(M, sum(K[,m])) }
  
  W <- M / S
  
  names(W) <- y
  
  plot(names(W), W, type = "l", las = 2, xlab = "Years",
       main = sprintf("%s's Working Age Population Dynamics", C),
       ylab = "Working Age Population Portion")
}  
work.age.plt("643", "Russia")
