lapply(c("ggplot2", "ggrepel"), require, character.only = T) # Libs

ggplot(data = rus.bubble.df.new,
       mapping = aes(x = as.numeric(rus.bubble.df.new[,3]),
                     y = as.numeric(rus.bubble.df.new[,6]),
                     size = rus.bubble.df.new[,5],
                     color = rus.bubble.df.new[,2],
                     label = rus.bubble.df.new[,2])) + geom_point() +
  labs(title="Bubble Plot of Regions by Income and Fertility Rate",
       x = "Montly GDP per Capita (US$)", y = "Fertility Rate per Woman",
       size = "Population", color = "Region") + theme_minimal() +
  geom_text_repel(aes(label = rus.bubble.df.new[,1],
                      fill = rus.bubble.df.new[,2],
                      size = NULL, color = NULL), nudge_y = .0125) + 
  guides(fill=guide_legend(title = "Region", override.aes=aes(label = ""))) +
  theme(plot.title = element_text(hjust = .5)) +
  geom_smooth(method = 'lm', se = F, col = "black") +
  guides(size = guide_legend(override.aes = list(linetype = 0))) 
