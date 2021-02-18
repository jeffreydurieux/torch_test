load("~/Repositories/torch_test/Tests/results_mm_sq.Rdata")

#mat_dims<-c(3,5,10,20,50,100, 200, 300, 500, 1000, 1500, 2000, 2500, 3000, 5000, 10000)


mat_dims<-c(3,5,10,20,50,100, 200, 300, 500, 1000)




lmat<-length(mat_dims)

user_times_vector<-c(Time_base_mm[1:lmat,1],Time_torch_mmf[1:lmat,1],Time_torch_mmf32[1:lmat,1],Time_torch_mmf64[1:lmat,1],Time_torch_mmd[1:lmat,1],
                     Time_torch_sqf[1:lmat,1],Time_torch_sqf32[1:lmat,1],Time_torch_sqf64[1:lmat,1],Time_torch_sqd[1:lmat,1])

m_dim<-rep(mat_dims,9)


# method<-c(rep("base_mm",16),rep("torch_mmf",16),rep("torch_mmf32",16),rep("torch_mmf64",16),rep("torch_mmd",16),
#           rep("torch_sqf",16),rep("torch_sqf32",16),rep("torch_sqf64",16),rep("torch_sqd",16))

method<-c(rep("base_mm",10),rep("torch_mmf",10),rep("torch_mmf32",10),rep("torch_mmf64",10),rep("torch_mmd",10),
          rep("torch_sqf",10),rep("torch_sqf32",10),rep("torch_sqf64",10),rep("torch_sqd",10))


user_timesdf<-data.frame(user_times_vector,m_dim,method)










elapsed_times<-c(Time_base_mm[1:lmat,3],Time_torch_mmf[1:lmat,3],Time_torch_mmf32[1:lmat,3],Time_torch_mmf64[1:lmat,3],Time_torch_mmd[1:lmat,3],
                 Time_torch_sqf[1:lmat,3],Time_torch_sqf32[1:lmat,3],Time_torch_sqf64[1:lmat,3],Time_torch_sqd[1:lmat,3])

m_dim2<-rep(mat_dims,9)


# method2<-c(rep("base_mm",16),rep("torch_mmf",16),rep("torch_mmf32",16),rep("torch_mmf64",16),rep("torch_mmd",16),
#           rep("torch_sqf",16),rep("torch_sqf32",16),rep("torch_sqf64",16),rep("torch_sqd",16))

method2<-c(rep("base_mm",10),rep("torch_mmf",10),rep("torch_mmf32",10),rep("torch_mmf64",10),rep("torch_mmd",10),
            rep("torch_sqf",10),rep("torch_sqf32",10),rep("torch_sqf64",10),rep("torch_sqd",10))

elapsed_timesdf<-data.frame(elapsed_times,m_dim2,method2)





#Plots
library(ggplot2)
user_timesdf <- user_timesdf[1:50,]
ggplot(data = user_timesdf, mapping = aes(x=m_dim, y=user_times_vector, color=method))+geom_line()


elapsed_timesdf <- elapsed_timesdf[1:50,]
ggplot(data = elapsed_timesdf, mapping = aes(x=m_dim2, y=elapsed_times, color=method2))+geom_line()



#From a matrix of size 200x200 the torch methods perform better. The larger the matrices, the more difference between base R and torch.
#The torch methods perform similarly. In some cases the square method works better than the matrix multiplications, and in some other cases just the opposite.
