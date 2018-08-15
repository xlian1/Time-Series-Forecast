# 数据：

data = read.table('clipboard',header = F)

data.ts = ts(data,start = 1,frequency = 12)

library(forecast)

plot.ts(data.ts)
plot(decompose(data.ts))

data.log = log(data.ts)
plot(data.log)

adf = diff(data.log,differences = 1)
plot(adf)

t = auto.arima(data.log,trace = T)
# t = auto.arima(data.ts,trace = T)
# fit = arima(data.ts,order = c(0,1,0),
#             seasonal = list(order = c(0,1,0),periods = 4),
#             method = 'ML')


fit = arima(data.log,order = c(1,1,0),
            seasonal = list(order = c(1,1,0),periods = 12),
            method = 'ML')
pre = forecast.Arima(fit,h = 2,level = c(99.5))

exp(pre$mean)
exp(pre$lower)
exp(pre$upper)


