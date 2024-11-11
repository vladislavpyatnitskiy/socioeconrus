work.age.df <- function(x, C){
  
  y <- as.character(seq(1950, 2050, 1)) # list with years
  
  G <- NULL
  
  for (j in 1:length(x)){ D <- NULL #
    
    for (m in 1:length(y)){ # Get Data for each year
      
      # Download CSV file from website
      f <- read.csv2(file =
                       url(sprintf("https://www.%s.net/api/pp/%s/%s/?csv=true",
                                   "populationpyramid", x[j], y[m]))) 
      
      df <- NULL # name for data frame
      
      for (n in 1:nrow(f)){ # Divide column into three
        
        df <- rbind.data.frame(df, unlist(strsplit(as.character(f[n,]),
                                                   "\\,")))}
      
      nums <- df[,1] # Assign Age groups 
      
      df$Total <- sum(as.numeric(df[,2]), as.numeric(df[,3])) # Sum Age Groups
      
      l <- NULL # 
      
      for (n in 1:nrow(df)){ l <- rbind.data.frame(l,
                                                   sum(as.numeric(df[n,2]),
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
    
    W <- as.data.frame(W)
    
    if (is.null(G)){ G <- W } else { G <- data.frame(G, W) }
  }
  
  rownames(G) <- seq(1950, 2050, 1)
  
  colnames(G) <- C
  
  G
}
work.age.df(c("643"), C = c("Russia"))
