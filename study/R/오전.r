# R의 데이터 구조
## 동종 모음
# vector: 1차원 / matrix: 2차원 / array: 3차원
a <- c(1,2,3)
b <- c(4,5,6)
c <- matrix(c(a,b), nrow=3)
d <- c("Hello", "world")

## 2종 모음
# list: 1차원 / dataframe: 2차원 
e <- list(a,b,d)

data(iris)

iris$value <- 1
# in Python: iris["value"]
# 참조가 목적이라면 iris.sepal_length도 가능
# in R: iris$value

names(iris) # iris의 columns name return
# in Python, iris.columns

# columns 이름 변경
names(iris) <- c("a", "b", "c", "d", "e", "f")
# in Python: iris.columns = ["a", "b", ...]

head(iris) # iris.head()

# Python concat() - Dataframe
# index를 기준으로, c_[a,b], colum_stack((a,b)), stack() - array

x = iris[,-5] # iris.iloc(,), iris.loc(,)
y = iris[,5] # [] 안에 논리식, index 모두 가능 

iris2 <- cbind(x,y)
head(iris2)
head(iris)

install.packages("reshape")
library(reshape) # import reshape
iris3 <- rename(iris2, c(y="species"))

iris[1,] # iris.iloc(0,:)
iris[,1] # iris.iloc(:,1)
iris[,1:3] # iris.iloc[:, 1:3]
iris[, -1] # iris.iloc...? Python은 음수가 맨 뒤 인덱스부터 적용될 때 사용
# 열은 인덱스가 음수이면 해당 인덱스를 제외함
iris[1:5, ]
iris[-c(1,2,3,4,5), ] # 1~5열 제외하고 출력
iris[, c(T,T,F,T,F)] # 1,2,4열 출력

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
  print("20보다 큼")
}else{
  print("20보다 작거나 같음")
}

ifelse(a>20, "20보다 큼", "20보다 작거나 같음")
# a>20? "참":"거짓"

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
a&b # 엘리먼트 단위 AND
a&&b # AND
a|b # 엘리먼트 단위 OR
a||b # OR

# <- 일반적인 할당
# <<- 전역변수에 값 할당
# = 매개변수, 함수의 인수로 값 할당
pow = function(x,y=2){
  result <-x^y #Python: x**y
  print(paste0(x,"의 ", y, "제곱은 ", result, "입니다."))
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

# fileEncoding: file에서 사용하는 인코딩
# encoding: R에서 사용하는 인코딩
# cp949 : Window의 기본 인코딩
iris2 = read.table("iris.csv", header=TRUE, sep=",", fileEncoding="utf-8"
                                                   , encoding="cp949")
# iris2 = pd.read_csv("iris.csv", encoding="utf-8")
head(iris2)

write.csv(iris, file="iris2.csv") # 행번호가 저장됨
write.csv(iris, file="iris3.csv", row.names=FALSE) # 행번호 저장 안함

summary(iris) # iris.describe()
cat(summary(iris), file="iris.summary.txt")
# 분석 결과 저장. 문자열을 이어 출력하는데 사용
# file 인자를 지정하면 파일에 데이터를 저장할 수 있음

# apply(X, MARGIN, FUN, ...)
# X: 대상 자료 객체(행렬, 배열)
# MARGIN: 차원
# (1: 행별로 함수 적용, 2:열별로 함수 적용, 
# 3: 차원(3차원 배열에서)별로 함수 적용)
# FUN: 적용할 함수 이름
iris_x = subset(iris, select=c(1:4)) # iris.iloc[:, :-1]
head(iris_x)
apply(iris_x, 2, mean)
head(apply(iris_x, 1, mean))
apply(iris_x, c(1,2), round) # 데이터 프레임의 모든 요소별로 적용

# iris 데이터에서 setoas 종의 꽃잎의 길이와 너비의 평균 구하기
setosaData <- subset(iris, select=c(3:4), subset=iris$Species=="setosa")
apply(setosaData, 2, mean)

# lapply(X, FUN) : list apply
# sapply(X, FUN, ..., SIMPLIFY=TRUE, USE.NAMES=TRUE) 
# simplification apply. 리스트대신 행렬, 벡터 등으로 결과를 변환
# SIMPLIFY: TRUE이면 연산 결과를 벡터, 행렬로 반환 / FALSE: 리스트
# USE.NAMES: TRUE이면 이름 속성도 반환

# vapply(X, FUN, FUN.VALUE, ..., USE.NAMES=TRUE)
# values simplification apply
# sapply와 비슷하지만, FUN의 모든 값이 FUN.VALUE와 호환되는지 확인
# FUN.VALUE에 의해 지정된 유형의 반환 값을 가짐(안전, 더 빠름)
# ex. length(FUN.VALUE)==1

# mapply(FUN, ..., MoreAgrs=NULL, SIMPLIFY=TRUE, USE.NAMES=TRUE)
# sapply와 비슷, 다수의 인자를 함수에 넘긴다는데서 차이가 있음
# MoreArgs: FUN 함수에 전달할 다른 인자 목록

# ex. 고객들의 직업과 소득을 임의로 샘플링하여 데이터 프레임으로 만듦
job <- c(3,3,5,2,2,3,5,3,4,4,6,3)
income <- c(4879,6509,4183,0,3894,0,3611,6454,4975,8780,0,4362)
cust <- data.frame(job, income)

# 고객의 소득이 0인 경우 미리 계산된 고객들의 직업별 평균 소득으로 대체
zero2mean <- function(job, income){
  if (income==0){
    return (income.avg[job+1])
  }else{
    return (income)
  }
}

cust$income.new <- mapply(zero2mean, cust$job, cust$income)

# tapply(X, INDEX, FUN=NULL, ..., default=NA, simplify=TRUE)
# 그룹별 처리를 위해 사용, 각 데이터가 속한 그룹별로 주어진 함수를 수행

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

