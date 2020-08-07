#load libraries 
library(readxl)
library(data.table)
library(ggplot2)
library(tidyr)

#load dataset
data <- read.csv('cofer_clean.csv')
#convert the above tibble to a data table 
data <- as.data.table(data)
#change the name of year values
names(data)[6:30] <- c(1995:2019)
#gather the year columns into a single column 
data.long <- gather(data, Year, Amount, '1995':'2019')

#subset data
data.w <- data.long[data.long$Country.Name == 'World',]
data.e <- data.long[data.long$Country.Name == 'Emerging and Developing Economies',]
data.a <- data.long[data.long$Country.Name == 'Advanced Economies',]

#plot 1 for World 
ggplot(data.w, aes(x = Year, y = Amount, color = Indicator.Name, group = Indicator.Name)) +
  geom_point() + geom_line() + 
  scale_color_manual(values = c("dark red","dark blue",'black','grey','violet',
                                'dark green','red','blue','green','brown','dark orange',
                                'purple','orange','steel blue')) +
  theme_classic(base_size = 12) + ggtitle('World Total Amount')

#plot 1 for emerging economies 
ggplot(data.e, aes(x = Year, y = Amount, color = Indicator.Name, group = Indicator.Name)) +
  geom_point() + geom_line() + 
  scale_color_manual(values = c("dark red","dark blue",'black','grey','violet',
                                'dark green','red','blue','green','brown','dark orange',
                                'purple','orange','steel blue')) +
  theme_classic(base_size = 12) + ggtitle('Emerging Economies Total Amount')

#plot 1 for advanced econommies
ggplot(data.a, aes(x = Year, y = Amount, color = Indicator.Name, group = Indicator.Name)) +
  geom_point() + geom_line() + 
  scale_color_manual(values = c("dark red","dark blue",'black','grey','violet',
                                'dark green','red','blue','green','brown','dark orange',
                                'purple','orange','steel blue')) +
  theme_classic(base_size = 12) + ggtitle('Advanced Economies Total Amount')

