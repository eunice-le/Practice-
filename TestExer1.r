#load dataset 
test <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQnYBOhW4szQZpfSHpdBA6VIIMbp1hDbuSwVa9l0_RMztb9yw-PjwHfs7grLJOULuWV6CP791uliPDX/pub?gid=931513581&single=true&output=csv")

#mean of values 
mean.ad <- mean(test$Advertising)
mean.sale <- mean(test$Sales)

###(a)###
#scatter plot of sales and advertising 
plot(x = test$Advertising, y = test$Sales,
     type = "p", xlab = "Advertising", ylab = "Sales",
     ylim = c(0,55))

###(b)###
#calculate coefficient b 
numerator <- c()
denominator <- c()
for (i in 1:length(test$Observation)) {
  numerator[i] <- (test$Advertising[i]-mean.ad)*(test$Sales[i]-mean.sale)
  denominator[i] <- (test$Advertising[i]-mean.ad)^2
}
b <- sum(numerator)/sum(denominator) #b = -0.3

#calculate coefficient a
a <- mean.sale - b*mean.ad #a = 29.6

#calculating coefficients using linear regression model 
lm1 <- lm(test$Sales ~ test$Advertising)
summary(lm1) 
#intercept = 29.6, slope = -0.3
#std error of b = 0.46, t-value of b = -0.7
#the 2 methods of calculating a and b yield similar results 

###(c)###
#calculating the residual e 
e <- c()
for (i in 1:length(test$Observation)){
  e[i] <- test$Sales[i] - (29.6 - 0.3*test$Advertising[i])
}
#drawing a histogram of residuals 
hist(e, xlab = 'Residuals', main = 'Histogram of residuals')

###(e)###
#delete the outlier (row 12) from the data 
test1 <- test[-c(12),]

#using linear regression function to calculate coefficients 
lm2 <- lm(test1$Sales ~ test1$Advertising)
summary(lm2)
#a = 21.1, b = 0.3
#Std error of b = 0.09, t-value of b = 4.25






























