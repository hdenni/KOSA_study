# Formula
data(cars)
plot(cars)

lm(dist~speed, cars)

data(iris)
lm(Petal.Length~Petal.Width, iris)

# ����
x <- rnorm(1e7) #mean 0, sd 1

system.time(x1 <- sort(x, method="shell"))
system.time(x2 <- sort(x, method="quick"))
system.time(x3 <- sort(x, method="radix"))
# quick sort�� ���� ����^^


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
# melt: ���̸�, ���� variable, value ���� ����� ���·� ��ȯ�ϴ� �Լ�
# �� ���� ������ ������ �� ���� ������ ������ �ٲ�
# na.rm: NA���� �����ͼ¿��� �������� ���θ� ����
# - Default: FALSE, NA�� ����
air_melt <- melt(airquality, id=c("Month", "Day"), na.rm=TRUE)
head(air_melt)

# cast() : melt �Լ��� ����� ������ �������� �迭 �Ǵ� ������ ���������� ĳ����
# dcast(): ����� ������ ������
# acast(): ����� ����/���/�迭
dcast_sample <- dcast(air_melt, formula=Month+Day~variable,
      value.var="value", fun.aggregate=NULL)
head(dcast_sample)

pie.sales <- c(0.12, 0.3, 0.26, 0.16, 0.04, 0.12)
names(pie.sales) <- c("Blueberry", "Cherry", "Apple", "Boston Cream", 
                      "Other", "Vannila Cream")
pie(pie.sales, clockwise=TRUE) # �⺻ ����
pie(pie.sales, col=c("purple", "violetred1", "green3", "cornsilk",
                     "cyan", "white"))

install.packages("ggplot2")
library(ggplot2)
ggplot(iris, aes(Petal.Width, Petal.Length))
