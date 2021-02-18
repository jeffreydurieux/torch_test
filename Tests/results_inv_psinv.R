
load("~/Repositories/torch_test/Tests/results_inv_psinv.Rdata")



mat_dims<-c(3,5,10,20,50,100, 200, 300, 500, 1000)




lmat<-length(mat_dims)




user_times_vector<-c(Time_base_inv[,1],Time_torch_invf[,1],Time_torch_invf32[,1],Time_torch_invf64[,1],Time_torch_invd[,1],
                     Time_base_psinv[,1], Time_torch_psinvf[,1],Time_torch_psinvf32[,1],Time_torch_psinvf64[,1],Time_torch_psinvd[,1])


m_dim<-rep(mat_dims,10)


method<-c(rep("base_inv",lmat),rep("torch_invf",lmat),rep("torch_invf32",lmat),rep("torch_invf64",lmat),rep("torch_invd",lmat),
          rep("base_psinvf",lmat),rep("torch_psinvf",lmat),rep("torch_psinvf32",lmat),rep("torch_psinvf64",lmat),rep("torch_psinvd",lmat))



user_timesdf<-data.frame(user_times_vector,m_dim,method)





elapsed_times<-c(Time_base_inv[,3],Time_torch_invf[,3],Time_torch_invf32[,3],Time_torch_invf64[,3],Time_torch_invd[,3],
                 Time_base_psinv[,3],Time_torch_psinvf[,3],Time_torch_psinvf32[,3],Time_torch_psinvf64[,3],Time_torch_psinvd[,3])

m_dim2<-rep(mat_dims,10)


method2<-c(rep("base_inv",lmat),rep("torch_invf",lmat),rep("torch_invf32",lmat),rep("torch_invf64",lmat),rep("torch_invd",lmat),
           rep("base_psinvf",lmat), rep("torch_psinvf",lmat),rep("torch_psinvf32",lmat),rep("torch_psinvf64",lmat),rep("torch_psinvd",lmat))

elapsed_timesdf<-data.frame(elapsed_times,m_dim2,method2)





#Plots
library(ggplot2)

ggplot(data = user_timesdf, mapping = aes(x=m_dim, y=user_times_vector, color=method))+geom_line()

ggplot(data = elapsed_timesdf, mapping = aes(x=m_dim2, y=elapsed_times, color=method2))+geom_line()



# torch methods outperform R base methods when matrices are of sizes around 200x200, 300x300, 500x500. I have run simulation with larger sizes, 
#and the differences are huge, while the differences with small matrices are very small. For your project with huge matrices I would consider using torch.
#but keep in mind that you have to use tensors of types double or float. If you use the default (long), the time is not going to improve.
#Actually, I have not include those cases (tensors of type long) in this small simulation study because they took a lot of time.
