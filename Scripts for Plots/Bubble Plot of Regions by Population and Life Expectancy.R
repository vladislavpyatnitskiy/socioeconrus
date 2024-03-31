lapply(c("ggplot2", "ggrepel"), require, character.only = T) # Libs

options(scipen=1000000)

ggplot(data = rus.bubble.df.new,
       mapping = aes(x = as.numeric(rus.bubble.df.new[,5]),
                     y = as.numeric(rus.bubble.df.new[,4]),
                     color = rus.bubble.df.new[,2],
                     label = rus.bubble.df.new[,2])) + geom_point() +
  labs(title="Scatter Plot of Regions by Population and Life Expectancy",
       x = "Population", y = "Life Expectancy (Years)", color = "Region") +
  geom_text_repel(aes(label = rus.bubble.df.new[,1],
                      fill = rus.bubble.df.new[,2]), nudge_y = .0125) + 
  guides(fill=guide_legend(title = "Region", override.aes=aes(label = ""))) +
  theme(plot.title = element_text(hjust = .5)) + theme_minimal() +
  scale_x_continuous(trans='log10') +
  geom_smooth(method = 'lm', se = F, col = "black") +
  guides(size = guide_legend(override.aes = list(linetype = 0))) 
