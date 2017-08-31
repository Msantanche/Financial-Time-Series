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
install.packages('rmgarch')
library(rmgarch)
# Specification of univariate GARCH models for volatilities
garch11.spec = ugarchspec(mean.model = list(armaOrder = c(0,0)), 
                          variance.model = list(garchOrder = c(1,1), model = "sGARCH"),
                          distribution.model = "norm" );
# Engle's DCC specification for conditional correlations
dcc.spec = dccspec(uspec = multispec( replicate(N, garch11.spec) ), 
                   dccOrder = c(1,1),
                   distribution = "mvnorm")
# Estimate model
dcc.est = dccfit(dcc.spec, data = y)
dcc.est

slotNames(dcc.est)
names(dcc.est@mfit)
dcc.est@mfit$Qbar  # The estimated matrix Qbar
dcc.est@mfit$cvar  # 

plot(sigma(dcc.est)[,1])
plot(sigma(dcc.est)[,2])
names(dcc.est@model)
plot(dcc.est)
#############################################################################

dcc.pred = dccforecast(dcc.est, n.ahead= 5)
dcc.pred