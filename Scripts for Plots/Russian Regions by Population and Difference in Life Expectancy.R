lapply(c("ggplot2", "ggrepel"), require, character.only = T)

options(scipen = 10000000)
ggplot(data = df.new.rus,
       mapping = aes(x=as.numeric(df.new.rus[,7]),y=as.numeric(df.new.rus[,4]),
                     color = df.new.rus[,2], label = df.new.rus[,2])) + 
  labs(title="Russian Regions by Population and Difference in Life Expectancy",
       x = "Population",
       y = "Difference in Life Expectancy between Women and Men in Russia",
       size = "Population", color = "Region") + theme_minimal() +
  geom_text_repel(aes(label = df.new.rus[,1], fill = df.new.rus[,2],
                      size = NULL, color = NULL), nudge_y = .0125) + 
  guides(fill=guide_legend(title = "Region", override.aes=aes(label = ""))) +
  theme(plot.title = element_text(hjust = .5)) + geom_point() +
  geom_smooth(method = 'lm', se = F, col = "black") +
  scale_x_continuous(trans='log10') +
  guides(size = guide_legend(override.aes = list(linetype = 0))) 
