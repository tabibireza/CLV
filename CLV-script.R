# customer lifetime value 
# Matrix Factorization for Recommender(RECO) Systems
# to predict the rating the movies in the test dataset
getwd ()
data_train <- read.csv("train.csv")
data_test <- read.csv("test.csv")
summary(data_train)
install.packages("recosystem")
library("recosystem")
set.seed(145)

# tunning the model  parameter values that will increase the predictive
# we use index1=TRUE because the user and item ids start with 1, rather than 0
# two settings of latent vector dimensionality dim=5, or dim=10
# three different values of the learning rate, lrate
# 100 iterations
# involving 5 fold cross validation.
r= Reco()
attributes(r)
opts<-r$tune(data_memory(data_train$User,data_train$Movie, 
                         rating=data_train$Rating, 
                         index1=TRUE),
             opts=list(dim=c(5,10),
                       lrate=c(0.05,0.1, 0.15),
                       niter=200,
                       nfold=5,
                       verbose=FALSE))
attributes(opts)
opts$min

#  the model on the training data. We restrict ourself to 200
r$train(data_memory(data_train$User, data_train$Movie, rating=data_train$Rating, index1=TRUE), opts=c(opts$min, nthread=1, niter=200))

# store the latent vectors P and Q for the users and the movies
res <- r$output(out_memory(), out_memory())

#  predict the ratings in the test data using the predict command
predMem=r$predict(data_memory(data_test$User,data_test$Movie, rating=NULL, index1=TRUE),out_memory())
predMem

# compare the predictive accuracy of several methods by comparing their rmse values
rmse=sqrt(mean((predMem-data_test$Rating)^2))
rmse






                                                                                                                                  


