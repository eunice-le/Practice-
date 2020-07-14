library(readxl)
library(data.table)
library(ggplot2)

## LOAD DATA ##
data <- read_csv('cleaned_carry_trade.csv')
#convert data to data table 
data <- as.data.table(data)
#convert 'date' column from string to date
data[, as.Date(date)]

## PROCESS DATA ##
#calculate AUD/JPY exchange rate 
data[, xr.audjpy := 1/(xr.jpyusd*xr.usdaud)]

#convert annualized short-term interest rate (stir) into 3-month
data[, ':=' (stir.jpn = stir.jpn/4, stir.aus = stir.aus/4)]

#calculate 3-month depreciation of AUD
#negative value: appreciation, positive value: depreciation
data[, aud.depreciation := (log(shift(xr.audjpy, -3))-log(xr.audjpy))* 100]

#calculate excess rate, or real return
data[, excess.return := stir.aus - stir.jpn - aud.depreciation]

#calculate the difference between AUD's and JPN's interest rates
data[, difference := stir.aus - stir.jpn]

## PLOT DATA ## 
#line graph of excess/real return over time
plot(x = data$date, y = data$excess.return, 
     xlab = 'Date', ylab = 'Real return',
     type = "l")
#or, using the ggplot package:
ggplot(data[year(date) >= 2000], aes(x = date, y = excess.return)) +
  geom_line(size = 0.5) +
  xlab('Time') + ylab('3-month return') +
  theme_bw(base_size) = 15 +
  theme(panel.border = element_blank())

#scatter plot of Real return and Difference in interest rate 
plot(x = data$excess.return, y = data$difference,
     xlab = 'Real return', ylab = 'Interest rate difference',
     type = "p")
ggplot(data[year(date) >= 2000], aes(x = excess.return, y = difference)) +
         geom_point() + xlab('Real return') + ylab('Interest rate difference') +
         theme_bw(base_size = 11) +
         theme(panel.border = element_blank())

#Cumulative return
b <- data[month(date) %% 3 == 0]  # select only one data point per quarter i.e. month 3, 6, 9, 12
b[, cum.return := cumprod(1+excess.return/100)] # compound return
ggplot(b[year(date) >= 2000], aes(x = date, y = cum.return)) +
  geom_line(size = 0.8) +
  xlab('Time') + ylab('Cumulative return') +
  theme_bw(base_size = 20) +
  theme(panel.border = element_blank())


