#########################################################################
# The original time series is FTSE MIB market indexS
# We transform it into log - returns (in percentage points)
Y = ts(read.csv("ftse_mib.csv", header = T), frequency=1,start=1)
P = Y[,7];
plot(P, col="red")
y = 100* diff(log(P))  # returns
plot(y, col="blue")
hist(y, 60, main= "Histogram",freq=FALSE, ylab = "")
lines(density(y),col="blue")
sq.ret = y^2; # squared returns 
plot(sq.ret, col = 'red')
acf(sq.ret)
acf(diff(sq.ret))
######################################################################### 
# Exponential smoothing - via HoltWinters function
es = HoltWinters(sq.ret, gamma = FALSE, beta = FALSE)
es2 = HoltWinters(sq.ret, alpha = 0.06, gamma = FALSE, beta = FALSE)
plot(sq.ret)
es$alpha
lines(fitted(es)[,1], col = 2)  # lambda estimated as minimiser of Sum of Squares Forecast Errors 
lines(fitted(es2)[,1], col = 3) # lambda = 0.06
#########################################################################
# Fit an ARIMA(0,1,1) to abs returns 
dsq.ret = diff(sq.ret) 
acf(dsq.ret) # strong negative autocorrelation at lag 1 for the 1st differences
mod011 = arima(sq.ret, order = c(0,1,1))
mod011
tsdiag(mod011)
theta = mod011$coef
1+theta # implied lambda (compare with es$lambda)
####### Forecasting out of sample 
H = 10 # maximum forecast horizon
sqret.for = predict(mod011, n.ahead=H)
sqret.for
U = sqret.for$pred+2*sqret.for$se
L = sqret.for$pred-2*sqret.for$se
miny = min(sq.ret,L)
maxy = max(sq.ret,U)
par(mfrow=c(1,1))  
ts.plot(window(sq.ret, 3900, 4549), sqret.for$pred, col=1:2, ylim=c(miny,maxy))
lines(U, col="blue", lty = "dashed")
lines(L, col="blue", lty = "dashed")
 
