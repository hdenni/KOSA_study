# Formula
data(cars)
plot(cars)

lm(dist~speed, cars)

data(iris)
lm(Petal.Length~Petal.Width, iris)

# 정렬
x <- rnorm(1e7) #mean 0, sd 1

system.time(x1 <- sort(x, method="shell"))
system.time(x2 <- sort(x, method="quick"))
system.time(x3 <- sort(x, method="radix"))
# quick sort가 가장 빠름^^


install.packages("RJDBC")
library(RJDBC)
drv <- JDBC("oracle.jdbc.OracleDriver", classPath="ojdbc6.jar")
conn <- dbConnect(drv, "jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr")
emp <- dbReadTable(conn, "employees")
head(emp)
class(emp)

data("airquality")
head(airquality)
install.packages("reshape2")
library(reshape2)
# melt: 열이름, 값을 variable, value 열에 저장된 형태로 변환하는 함수
# 열 단위 데이터 구조를 행 단위 데이터 구조로 바꿈
# na.rm: NA값을 데이터셋에서 삭제할지 여부를 결정
# - Default: FALSE, NA값 유지
air_melt <- melt(airquality, id=c("Month", "Day"), na.rm=TRUE)
head(air_melt)

# cast() : melt 함수가 적용된 데이터 프레임을 배열 또는 데이터 프레임으로 캐스팅
# dcast(): 결과가 데이터 프레임
# acast(): 결과가 벡터/행렬/배열
dcast_sample <- dcast(air_melt, formula=Month+Day~variable,
      value.var="value", fun.aggregate=NULL)
head(dcast_sample)

pie.sales <- c(0.12, 0.3, 0.26, 0.16, 0.04, 0.12)
names(pie.sales) <- c("Blueberry", "Cherry", "Apple", "Boston Cream", 
                      "Other", "Vannila Cream")
pie(pie.sales, clockwise=TRUE) # 기본 색상
pie(pie.sales, col=c("purple", "violetred1", "green3", "cornsilk",
                     "cyan", "white"))

install.packages("ggplot2")
library(ggplot2)
ggplot(iris, aes(Petal.Width, Petal.Length))
