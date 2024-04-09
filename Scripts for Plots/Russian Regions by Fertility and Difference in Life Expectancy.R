lapply(c("ggplot2", "ggrepel"), require, character.only = T)

ggplot(data = fer.df.dif,
       mapping = aes(x=as.numeric(fer.df.dif[,4]),y=as.numeric(fer.df.dif[,3]),
                     color = fer.df.dif[,2], label = fer.df.dif[,2])) + 
  labs(title="Russian Regions by Fertility and Difference in Life Expectancy",
       x = "Difference in Life Expectancy between Women and Men in Russia",
       y = "Fertility Rate per Woman", size = "Population", color = "Region") +
  geom_text_repel(aes(label = fer.df.dif[,1], fill = fer.df.dif[,2],
                      size = NULL, color = NULL), nudge_y = .0125) + 
  guides(fill=guide_legend(title = "Region", override.aes=aes(label = ""))) +
  theme(plot.title = element_text(hjust = .5)) + geom_point() +
  geom_smooth(method = 'lm', se = F, col = "black") + theme_minimal() +
  guides(size = guide_legend(override.aes = list(linetype = 0))) 
