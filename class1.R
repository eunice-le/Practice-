library(readxl)
library(data.table)
library(ggplot2)
#load data
data <- read_csv('cleaned_carry_trade.csv')
data <- as.data.table(data)
#calculate aud/jpn exchange rate 
data[, xr.audjpn := 1/(xr.jpyusd*xr.usdaud)]
#calculate change in exchange rate 
#negative change: appreciation, positive change: depreciation of aud
data[, xr.change := (xr.audjpn/shift(xr.audjpn, -3) - 1)* 100]
#calculate excess rate, or real return
data[, real.return := (stir.aus - stir.jpn)/4- xr.change]
#calculate the difference between AUD's and JPN's interest rates
data[, difference := stir.aus - stir.jpn]

#line graph of excess/real return over time
plot(x = data$date, y = data$real.return, 
     xlab = 'Date', ylab = 'Real return',
     type = "l")
#scatter plot of Real return and Difference in interest rate 
plot(x = data$real.return, y = data$difference,
     xlab = 'Real return', ylab = 'Interest rate difference',
     type = "p")


