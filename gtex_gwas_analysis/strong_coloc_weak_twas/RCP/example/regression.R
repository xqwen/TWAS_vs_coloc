impute <-function(x) {
   if(sum(is.na(x)) > 0){
   x[which(is.na(x))] = mean(x,na.rm=T)
   }
   return(x)
}



args = commandArgs(trailingOnly=TRUE)
num = as.numeric(args[1])


d = read.table("reg.dat",head=T)
attach(d)
d = apply(d,2,impute)

df = data.frame(d)

rst = summary(lm(expression ~ ., data=df))

p = dim(d)[2]
cat("\n\nModel fit:\n")
rst$coef[(p-num+1):p,]


geno = d[,(p-num+1):p]

cat("\n\nAllele frerquencies:\n")
apply(geno,2,mean)/2

cat("\n\nLD between SNPs (R^2)\n")

cor(geno)^2
