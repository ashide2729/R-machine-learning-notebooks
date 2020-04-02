# Installing the required packages
pkgs <- c("dplyr","factoextra",  "NbClust")
install.packages(pkgs)

# Loading the libraries
library(dplyr)
library(factoextra)
library(NbClust)

# Defining path and loading dataset
PATH <- '<path>'
customer_df <- read.csv(PATH, header =  TRUE)

# Overview of the dataset attributes
str(customer_df)

# Removing unwanted column
customer_df <- customer_df %>% select(-MEMBERSHIP_ID) 

# Quality check
str(customer_df)

# Checking the distribution of attributes in the dataset
summary(customer_df) %>% kableExtra::kable() %>% kableExtra::kable_styling()

# Checking correlation between attribuites
corrplot::corrplot(cor(customer_df), type = "upper", tl.cex = 0.9)

# Removing one of MIDSCALE_PCT and UPSCALE_PCT because of 
# high correlation as the weithage increases during clustering
customer_df <- customer_df %>% select(-MIDSCALE_PCT) 

# Quality check
corrplot::corrplot(cor(customer_df), type = "upper", tl.cex = 0.9)

# Scaling the attributes values because of uneven scaling
customer_df_scaled <- scale(customer_df)

# Applying clustering algorithms

# Elbow method
fviz_nbclust(customer_df_scaled, kmeans, method = "wss") +
    labs(subtitle = "Elbow method")
# The optimal number of clusters is 5  

# Silhouette method
fviz_nbclust(customer_df_scaled, kmeans, method = "silhouette")+
    labs(subtitle = "Silhouette method")
# The optimal number of clusters is 2  

#---------------------------------------------------------------------
# Conclusion:-
# The optimal number of clusters by elbow and silhouette methods are
# 5 & 2 respectively. 
# The elbow method is sometimes ambiguous and hence silhouette method
# is preferred over it as it can be clearly seen from the graph
#---------------------------------------------------------------------

# Few other no. of clusters determining techniques for better understanding 

# Gap statistic
# fviz_nbclust(customer_df_scaled, kmeans, nstart = 25,  method = "gap_stat", nboot = 500)+
#     labs(subtitle = "Gap statistic method")

# Code for finding optimal clusters using all the available methods in the package
# NbClust(data = customer_df_scaled, diss = NULL, distance = "euclidean",
#         min.nc = 2, max.nc = 15, method = "kmeans")
