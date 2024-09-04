library("rvest") # Library

pop.ru <- function(x){ # Russian Regions by life expectancy
  
  y <- read_html(paste("https://en.wikipedia.org/wiki/", x, sep = "")) %>%
    html_nodes('table') %>% .[[1]] %>% html_nodes('tr') %>%
    html_nodes('td') %>% html_text()
  
  v <- NULL # variables to store data frames
  
  for (n in 0:(length(y)/6)){ # Put data in columns
    
    d <- read.fwf(textConnection(gsub('["\n"]', '', y[7 + 6 * n])),
                  widths = c(nchar(1), nchar(gsub('["\n"]', '', y[7+6*n]))),
                  colClasses = "character")[2]
    
    v <- rbind.data.frame(v, cbind(d, as.numeric(gsub("[\n,]","",y[9+6*n])))) }
  
  colnames(v) <- c("Region", "Population") # Column names
  
  v <- v[apply(v, 1, function(x) all(!is.na(x))),] # Get rid of NA
  
  v[v$Region == "Moscow",][,1] <- "Moscow City" # Distinguish city from oblast
  
  for (n in 1:nrow(v)) if (isTRUE(grepl("Oblast", v[n,1]))){ # Reduce "Oblast"
    
      O <- read.fwf(textConnection(v[n,1]), widths = c(nchar(v[n,1]) - 7, 1),
                    colClasses = "character")[,1] 
      
      v[v$Region == v[n,1],][,1] <- O } 
    
  v[v$Region == "Komi Republic",][,1] <- "Komi"
  v[v$Region == "Khanty–Mansi A.O. (Yugra)",][,1] <- "Khanty-Mansi AO"
  v[v$Region == "Sakha (Yakutia)",][,1] <- "Sakha"
  v[v$Region == "Arkhangelsk Ob",][,1] <- "Arkhangelsk"
  v[v$Region == "North Ossetia–Alania",][,1] <- "North Ossetia"
  v[v$Region == "Yamalo Nenets A.O.",][,1] <- "Yamalo-Nenets AO"
  v[v$Region == "Jewish Autonomous",][,1] <- "Jewish AO"
  v[v$Region == "Nenets Autonomous Okrug",][,1] <- "Nenets AO"
  
  v # Display
}
pop.ru("List_of_federal_subjects_of_Russia_by_population") # Test
