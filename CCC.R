my = read.csv("sp500c.csv", header = T)
my = my[,complete.cases(t(my))] # 
csel = c(2,3, 6, 89, 67)
p = ts(my[,csel])
plot(p)
###############################################################
y = 100 * diff(log(p));
plot(y)
N= ncol(y); n = nrow(y);
summary(y)
pairs(y)                  #  scatterplots
#############################################################################
#############################################################################
### fit garch( 1,1) models to the N series
library(fGarch)
ht.y = matrix(0, n, N)
for (i in 1:N)
{
  fit = garchFit(~ garch(1,1), data = y[, i], trace = FALSE);
  summary(fit);
  ht = volatility(fit, type = "h");
  ht.y[, i] = ht;
} 
ht.y = ts(ht.y)
plot(ht.y)
### We now construct the devolatilised series y*
y.star = y / sqrt(ht.y) 
plot(y.star)
P = cor(y.star) # Conditional correlations
P