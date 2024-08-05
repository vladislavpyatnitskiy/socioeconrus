library("rvest") # Library

life.exp.ru <- function(x){ # Life Expectancy of Russian regions data 
  
  y <- read_html(paste("https://en.wikipedia.org/wiki/", x, sep = "")) %>%
    html_nodes('table') %>% .[[1]]  %>% html_nodes('tr') %>%
    html_nodes('td') %>% html_text() # Get data from HTML
  
  v <- data.frame(y[seq(from = 1, to = length(y), by = 20)], # Region name
                  y[seq(from = 2, to = length(y), by = 20)]) # Life Expectancy
  
  colnames(v) <- c("Region", "Life Expectancy") # Column names
    
  v[v$Region == "Khanty-Mansi AO(Tyumen Oblast)",][,1] <- "Khanty-Mansi AO" 
  v[v$Region == "Sakha (Yakutia)",][,1] <- "Sakha" 
  v[v$Region == "Arkhangelsk Oblast(except AO)",][,1] <- "Arkhangelsk Oblast"
  v[v$Region == "Yamalo-Nenets AO(Tyumen Oblast)",][,1] <- "Yamalo-Nenets AO"
  v[v$Region == "Jewish Autonomous Oblast",][,1] <- "Jewish AO" 
  v[v$Region == "Nenets AO(Arkhangelsk Oblast)",][,1] <- "Nenets AO" 
  v[v$Region == "Tyumen Oblast(except two AO)",][,1] <- "Tyumen Oblast" 
  
  v # Display
}
life.exp.ru("List_of_federal_subjects_of_Russia_by_life_expectancy") # Test
