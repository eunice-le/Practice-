#load datasets 
us <- read.csv("RBUSBIS.csv")
jp <- read.csv("RBJPBIS.csv")
br <- read.csv("RBBRBIS.csv")
sa <- read.csv("RBZABIS.csv")
  
#merge all 4 sets into a single dataframe 
reer <- cbind(br, jp$RBJPBIS, sa$RBZABIS, us$RBUSBIS)
colnames(reer)[2]<- "Brazil"
colnames(reer)[3]<- "Japan"
colnames(reer)[4]<- "South Africa"
colnames(reer)[5]<- "United States"

#turn the DATE column into date type 
reer$DATE <- as.Date(reer$DATE)

#line graph of the Real Broad Effective Exchange Rate (REER) for 4 countries 
plot(x = reer$DATE, y = reer$Brazil, 
     xlab = "Date", ylab = "REER",
     type = "l", col = "black",
     ylim = c(40,130), xaxt = "n")
lines(x = reer$DATE, y = reer$Japan,
      type = "l", col = "red")
lines(x = reer$DATE, y = reer$`South Africa`,
      type = "l", col = "blue")
lines(x = reer$DATE, y = reer$`United States`,
      type = "l", col = "green")
#label vector for x-axis
years <- c('2000','2001','2002','2003','2004','2005','2006','2007','2008','2009','2010',
           '2011','2012','2013','2014','2015','2016','2017','2018','2019','2020')
dates <- seq(from=min(reer$DATE), by='1 year', length=21)
axis(1, at = dates, labels = years)

#add vertical lines at tick marks for ease of reading 
abline(v=seq(from=min(reer$DATE), by='1 year', length=21), lty = 2, col = "grey")

#add legend
legend("bottomright", legend = c("Brazil", "Japan", "South Africa", "United States"),
        col = c("black", "red", "blue", "green"),
        lty=1, cex=0.5, ncol = 2)



