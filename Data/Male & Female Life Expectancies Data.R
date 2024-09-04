library("rvest") # library

dif.life.exp.ru <- function(x){ # Male & Female Life Expectancies in Russia
  
  y <- read_html(paste("https://en.wikipedia.org/wiki/", x, sep = "")) %>%
    html_nodes('table') %>% .[[1]] %>% html_nodes('tr') %>%
    html_nodes('td') %>% html_text()
  
  v <- data.frame(y[seq(from = 1, to = length(y), by = 20)], # Region name
                  y[seq(from = 3, to = length(y), by = 20)],
                  y[seq(from = 4, to = length(y), by = 20)]) # Life Expectancy
  
  colnames(v) <- c("Region", "Male", "Female") # Column names
  
  v[v$Region == "Moscow",][,1] <- "Moscow City" # Distinguish city from oblast
  
  for (n in 1:nrow(v)) if (isTRUE(grepl("Oblast", v[n,1]))){ # Reduce "Oblast"
    
    O <- read.fwf(textConnection(v[n,1]), widths = c(nchar(v[n,1]) - 7, 1),
                  colClasses = "character")[,1] 
    
    v[v$Region == v[n,1],][,1] <- O } 
    
  v[v$Region == "Khanty-Mansi AO(Tyumen ",][,1] <- "Khanty-Mansi AO" 
  v[v$Region == "Sakha (Yakutia)",][,1] <- "Sakha" 
  v[v$Region == "Arkhangelsk Oblast(exc",][,1] <- "Arkhangelsk Oblast"
  v[v$Region == "Yamalo-Nenets AO(Tyumen ",][,1] <- "Yamalo-Nenets AO"
  v[v$Region == "Jewish Autonomous",][,1] <- "Jewish AO" 
  v[v$Region == "Nenets AO(Arkhangelsk ",][,1] <- "Nenets AO" 
  v[v$Region == "Tyumen Oblast(except ",][,1] <- "Tyumen Oblast" 
  
  v # Display
}
dif.life.exp.ru("List_of_federal_subjects_of_Russia_by_life_expectancy") # Test
