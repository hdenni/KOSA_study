# R�� ������ ����
## ���� ����
# vector: 1���� / matrix: 2���� / array: 3����
a <- c(1,2,3)
b <- c(4,5,6)
c <- matrix(c(a,b), nrow=3)
d <- c("Hello", "world")

## 2�� ����
# list: 1���� / dataframe: 2���� 
e <- list(a,b,d)

data(iris)

iris$value <- 1
# in Python: iris["value"]
# ������ �����̶�� iris.sepal_length�� ����
# in R: iris$value

names(iris) # iris�� columns name return
# in Python, iris.columns

# columns �̸� ����
names(iris) <- c("a", "b", "c", "d", "e", "f")
# in Python: iris.columns = ["a", "b", ...]

head(iris) # iris.head()

# Python concat() - Dataframe
# index�� ��������, c_[a,b], colum_stack((a,b)), stack() - array

x = iris[,-5] # iris.iloc(,), iris.loc(,)
y = iris[,5] # [] �ȿ� ����, index ��� ���� 

iris2 <- cbind(x,y)
head(iris2)
head(iris)

install.packages("reshape")
library(reshape) # import reshape
iris3 <- rename(iris2, c(y="species"))

iris[1,] # iris.iloc(0,:)
iris[,1] # iris.iloc(:,1)
iris[,1:3] # iris.iloc[:, 1:3]
iris[, -1] # iris.iloc...? Python�� ������ �� �� �ε������� ����� �� ���
# ���� �ε����� �����̸� �ش� �ε����� ������
iris[1:5, ]
iris[-c(1,2,3,4,5), ] # 1~5�� �����ϰ� ���
iris[, c(T,T,F,T,F)] # 1,2,4�� ���

head(subset(iris, select=c(1,2,3)))
head(subset(iris, select=c("Sepal.Length", "Petal.Length", "Species")))
head(subset(iris, iris$Sepal.Length>=5.0))
head(subset(iris, iris$Sepal.Length>=5.0, select=c(1,2,3)))
head(subset(iris, subset=iris$Sepal.Length>=5.0, select=c(1,2,3)))

?head

head(iris, n=5)
tail(iris, n=4)

class(iris) # type
class(10) 

a <- 20
if(a>20){
  print("20���� ŭ")
}else{
  print("20���� �۰ų� ����")
}

ifelse(a>20, "20���� ŭ", "20���� �۰ų� ����")
# a>20? "��":"����"

jumsu <- 70
a <- jumsu%/%10
switch(a,"F","F","F","F","F","D","C","B","A","A")

# 0:10, seq(0,10) -> in Python, range(0,11)
for (i in 0:10){
  print(i)
}

i<-1
while(i<6){
  print(i)
  i=i+1
}

repeat{
  print("Hello")
  if(i>=10){
    break
  }
  i<-i+1
}

for(i in 0:10){
  if(i==5) next # continue
  print(i)
}

for (i in 1:5){
  isbreak <- FALSE
  for(j in 2:4){
    if(i==j){
      isbreak <- TRUE
      #break
      next
    }
    print(paste(i,j))
  }
  if(isbreak==TRUE){
    #break
    next
  }
}

a <- c(TRUE, F, T)
b <- c(TRUE, F, F)
a&b # ������Ʈ ���� AND
a&&b # AND
a|b # ������Ʈ ���� OR
a||b # OR

# <- �Ϲ����� �Ҵ�
# <<- ���������� �� �Ҵ�
# = �Ű�����, �Լ��� �μ��� �� �Ҵ�
pow = function(x,y=2){
  result <-x^y #Python: x**y
  print(paste0(x,"�� ", y, "������ ", result, "�Դϴ�."))
}
pow(x=2,y=3)
pow(3,5)

pow(x=2)
pow(3,5)

add <- function(a,b){
  return (a+b)
}

add(2,3)

add <- function(a,b,c){
  return(a+b+c)
}

add(2,3)

add <- function(a, ...){ # def add(a, *args):
  args <- list(...)
  sum = a
  for (data in args){
    sum = sum + data
  }
  return (sum)
}

add(3)
add(3,4)
add(3,4,5,6,7)

data(iris)
head(iris)
write.table(iris, file="iris.csv", sep=",", row.names=FALSE)
# iris.to_csv("iris.csv", index=False)

# fileEncoding: file���� ����ϴ� ���ڵ�
# encoding: R���� ����ϴ� ���ڵ�
# cp949 : Window�� �⺻ ���ڵ�
iris2 = read.table("iris.csv", header=TRUE, sep=",", fileEncoding="utf-8"
                                                   , encoding="cp949")
# iris2 = pd.read_csv("iris.csv", encoding="utf-8")
head(iris2)

write.csv(iris, file="iris2.csv") # ���ȣ�� �����
write.csv(iris, file="iris3.csv", row.names=FALSE) # ���ȣ ���� ����

summary(iris) # iris.describe()
cat(summary(iris), file="iris.summary.txt")
# �м� ��� ����. ���ڿ��� �̾� ����ϴµ� ���
# file ���ڸ� �����ϸ� ���Ͽ� �����͸� ������ �� ����

# apply(X, MARGIN, FUN, ...)
# X: ��� �ڷ� ��ü(���, �迭)
# MARGIN: ����
# (1: �ະ�� �Լ� ����, 2:������ �Լ� ����, 
# 3: ����(3���� �迭����)���� �Լ� ����)
# FUN: ������ �Լ� �̸�
iris_x = subset(iris, select=c(1:4)) # iris.iloc[:, :-1]
head(iris_x)
apply(iris_x, 2, mean)
head(apply(iris_x, 1, mean))
apply(iris_x, c(1,2), round) # ������ �������� ��� ��Һ��� ����

# iris �����Ϳ��� setoas ���� ������ ���̿� �ʺ��� ��� ���ϱ�
setosaData <- subset(iris, select=c(3:4), subset=iris$Species=="setosa")
apply(setosaData, 2, mean)

# lapply(X, FUN) : list apply
# sapply(X, FUN, ..., SIMPLIFY=TRUE, USE.NAMES=TRUE) 
# simplification apply. ����Ʈ��� ���, ���� ������ ����� ��ȯ
# SIMPLIFY: TRUE�̸� ���� ����� ����, ��ķ� ��ȯ / FALSE: ����Ʈ
# USE.NAMES: TRUE�̸� �̸� �Ӽ��� ��ȯ

# vapply(X, FUN, FUN.VALUE, ..., USE.NAMES=TRUE)
# values simplification apply
# sapply�� ���������, FUN�� ��� ���� FUN.VALUE�� ȣȯ�Ǵ��� Ȯ��
# FUN.VALUE�� ���� ������ ������ ��ȯ ���� ����(����, �� ����)
# ex. length(FUN.VALUE)==1

# mapply(FUN, ..., MoreAgrs=NULL, SIMPLIFY=TRUE, USE.NAMES=TRUE)
# sapply�� ���, �ټ��� ���ڸ� �Լ��� �ѱ�ٴµ��� ���̰� ����
# MoreArgs: FUN �Լ��� ������ �ٸ� ���� ���

# ex. ������ ������ �ҵ��� ���Ƿ� ���ø��Ͽ� ������ ���������� ����
job <- c(3,3,5,2,2,3,5,3,4,4,6,3)
income <- c(4879,6509,4183,0,3894,0,3611,6454,4975,8780,0,4362)
cust <- data.frame(job, income)

# ���� �ҵ��� 0�� ��� �̸� ���� ������ ������ ��� �ҵ����� ��ü
zero2mean <- function(job, income){
  if (income==0){
    return (income.avg[job+1])
  }else{
    return (income)
  }
}

cust$income.new <- mapply(zero2mean, cust$job, cust$income)

# tapply(X, INDEX, FUN=NULL, ..., default=NA, simplify=TRUE)
# �׷캰 ó���� ���� ���, �� �����Ͱ� ���� �׷캰�� �־��� �Լ��� ����

tapply(iris$Sepal.Length, iris$Species, mean)
class(job)
job <- factor(job, levels=c(0:8))
class(job)

length(job)
length(income)
tapply(income, job, mean)
tapply(income, job, mean, default=-1)

tapply(iris, iris$Species, sum)


install.packages("doBy")
library(doBy)
head(orderBy(~Species+Sepal.Length, data=iris))

sampleBy(~Species, data=iris, frac=0.1)

