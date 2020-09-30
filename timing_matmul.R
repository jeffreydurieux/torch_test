# Wed Sep 30 13:35:10 2020
# Author: Jeffrey Durieux, MSc

# torch tests

# https://torch.mlverse.org/docs/articles/getting-started/warmup.html

library(torch)
library(microbenchmark)

set.seed(42)

X <- matrix(rnorm(5*2), nrow = 5)
Y <- matrix(runif(2*2, min = -4, max = 4), nrow = 2)
Z
Z <- X %*% Y
dim(Z)


Xx <- torch_tensor(X)
Yy <- torch_tensor(Y)

Zz <- torch_matmul(Xx,Yy)
Zz <- as.array(Zz)

# check equality, strange behavior over here. Not equal (maybe not exactly equal after certain decimals??)
Z
Zz
identical(Z,Zz)
Z == Zz
cor(Z,Zz)

Zzz <- torch_tensor(Z)
torch_eq(Zzz,Zz)
torch_equal(Zzz,Zz)

X <- matrix(rnorm(10000*2000), nrow = 10000)
Y <- matrix(runif(2000*2000, min = -4, max = 4), nrow = 2000)

Xx <- torch_tensor(X)
Yy <- torch_tensor(Y)

set.seed(42)
dim(X);dim(Y)
system.time(X%*%Y)
system.time(torch_matmul(Xx,Yy))

microbenchmark(X%*%Y, torch_matmul(Xx,Yy), times = 5)
