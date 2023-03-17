{"metadata":{"kernelspec":{"name":"ir","display_name":"R","language":"R"},"language_info":{"name":"R","codemirror_mode":"r","pygments_lexer":"r","mimetype":"text/x-r-source","file_extension":".r","version":"4.0.5"}},"nbformat_minor":4,"nbformat":4,"cells":[{"source":"<a href=\"https://www.kaggle.com/code/amirmotefaker/movie-recommendation-system-using-r?scriptVersionId=122477627\" target=\"_blank\"><img align=\"left\" alt=\"Kaggle\" title=\"Open in Kaggle\" src=\"https://kaggle.com/static/images/open-in-kaggle.svg\"></a>","metadata":{},"cell_type":"markdown","outputs":[],"execution_count":0},{"cell_type":"markdown","source":"# What Is a Recommendation System?\n- A recommendation system is an artificial intelligence or AI algorithm, usually associated with machine learning, that uses Big Data to suggest or recommend additional products to consumers. These can be based on various criteria, including past purchases, search history, demographic information, and other factors. Recommender systems are highly useful as they help users discover products and services they might otherwise have not found on their own.\n\n- Recommender systems are trained to understand the preferences, previous decisions, and characteristics of people and products using data gathered about their interactions. These include impressions, clicks, likes, and purchases. Because of their capability to predict consumer interests and desires on a highly personalized level, recommender systems are a favorite with content and product providers. They can drive consumers to just about any product or service that interests them, from books to videos to health classes to clothing.\n\n# What is a product recommendation\n- In the product discovery phase, you can use more than one tool to show the consumer the most suitable options, offer the right personalized products, and design a satisfying experience. Product recommendations are one of the most powerful of these tools.\n\n# Advantage of product recommendations\n- Recommendations for related products: \n    - Provides a list of related products that are similar to the chosen one, either in use or in price which creates a cross-selling opportunity. For example at the cart step, offering complementary products to the ones already added to the cart, you can encourage your customer to shop a little bit more.\n- Recommendations based on past purchases: \n    - If you already bought a digital camera, a recommendation of its lenses might make sense.\n- Recommendations based on search: \n    - Product recommendation engines may look at search history to suggest products based on terms consumers have used.\n\n# Types of Recommendation Systems:\n- **Collaborative filtering** algorithms recommend items (this is the filtering part) based on preference information from many users (this is the collaborative part). \n\n- **Content filtering**, by contrast, uses the attributes or features of an item  (this is the content part) to recommend other items similar to the user’s preferences. \n\n- **Hybrid recommender systems** combine the advantages of the types above to create a more comprehensive recommending system.\n\n- **Context filtering** includes users’ contextual information in the recommendation process. \n\n# Recommendation Engine Benefits\n- Drive Traffic\n    - Through personalized email messages and targeted blasts, a recommendation engine can encourage elevated amounts of traffic to your site, thus increasing the opportunity to scoop up more data to further enrich a customer profile.\n\n- Deliver Relevant Content\n    - By analyzing the customer’s current site usage and previous browsing history, a recommendation engine can deliver relevant product recommendations as he or she shops based on said profile. The data is collected in real time so the software can react as shopping habits change on the fly.\n\n- Engage Shoppers\n    - Shoppers become more engaged when personalized product recommendations are made to them across the customer journey. Through individualized product recs, customers are able to delve more deeply into your product line without having to dive into (and very likely get lost in) an ecommerce rabbit hole.\n\n- Convert Shoppers to Customers\n    - Converting shoppers into customers takes a special touch. Personalized interactions from a recommendation engine show your customer that he or she is valued as an individual, in turn, engendering long-term loyalty.\n\n- Increase Average Order Value\n    - Average order values typically go up when an engine is leveraged to display personalized options as shoppers are more willing to spend generously on items they thoroughly covet.\n\n- Increase Number of Items per Order\n    - In addition to the average order value rising, the number of items per order also typically rises when an engine is employed. When the customer is shown options that meet his or her interest, they are far more likely to add items to to their active purchase cart.\n\n- Control Merchandising and Inventory Rules\n    - A recommendation engine can add your marketing and inventory control directives to a customer’s profile to feature products that are on clearance or overstocked so as to avoid unnecessary shopping friction and tone deafness.\n\n- Reduce Workload and Overhead\n    - The volume of data required to create a personal shopping experience for each customer is usually far too large to be managed manually. Using an engine automates this process, easing the workload for your IT staff.\n\n- A Recommendation Engine Provides Reports\n    - Detailed reports are an integral part of a personalization system. Accurate and up-to-the-minute reporting will allow you to make informed decisions about the direction of a campaign or the structure of a product page.\n\n- Offer Advice and Direction\n    - An experienced recommendation provider like Kibo can offer advice on how to use the data collected from your recommendation engine. Acting as a partner and a consultant, the provider should have the industry know-how needed to help guide you and your ecommerce site to a prosperous future.\n\n\nDataset: [MovieLens](https://grouplens.org/datasets/movielens/)\n\n### The main goal of this machine learning project is to build a recommendation system that recommends movies to users.","metadata":{"_uuid":"051d70d956493feee0c6d64651c6a088724dca2a","_execution_state":"idle"}},{"cell_type":"markdown","source":"# Importing Libraries","metadata":{}},{"cell_type":"code","source":"library(recommenderlab)  # Lab for Developing and Testing Recommender Algorithms\nlibrary(ggplot2)   # ggplot2 is a system for declaratively creating graphics, based on The Grammar of Graphics.                  \nlibrary(data.table)  # data.table is an R package that provides an enhanced version of data.frames, which are the standard data structure for storing data in base R.\nlibrary(reshape2)  # reshape2 is an R package written by Hadley Wickham that makes it easy to transform data between wide and long formats.","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:39.891053Z","iopub.execute_input":"2023-03-16T15:41:39.893934Z","iopub.status.idle":"2023-03-16T15:41:43.520465Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Retrieving the Data","metadata":{}},{"cell_type":"code","source":"movie_data <- read.csv(\"/kaggle/input/movielens-dataset-movies/movies.csv\",stringsAsFactors=FALSE)\nrating_data <- read.csv(\"/kaggle/input/movielens-dataset-for-recommendation-system/ratings.csv\")\nstr(movie_data)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:43.524107Z","iopub.execute_input":"2023-03-16T15:41:43.558731Z","iopub.status.idle":"2023-03-16T15:41:44.037614Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"summary(movie_data)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:44.040336Z","iopub.execute_input":"2023-03-16T15:41:44.041838Z","iopub.status.idle":"2023-03-16T15:41:44.067569Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"head(movie_data)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:44.070944Z","iopub.execute_input":"2023-03-16T15:41:44.072642Z","iopub.status.idle":"2023-03-16T15:41:44.105396Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"summary(rating_data)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:44.108052Z","iopub.execute_input":"2023-03-16T15:41:44.10965Z","iopub.status.idle":"2023-03-16T15:41:44.170329Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"head(rating_data)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:44.172989Z","iopub.execute_input":"2023-03-16T15:41:44.17454Z","iopub.status.idle":"2023-03-16T15:41:44.2035Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Data Pre-processing\n\n- From the above table, we observe that the userId column, as well as the movie I'd column, consists of integers. Furthermore, we need to convert the genres present in the movie_data data frame into a more usable format for the users. In order to do so, we will first create a one-hot encoding to create a matrix that comprises corresponding genres for each of the films.","metadata":{}},{"cell_type":"code","source":"movie_genre <- as.data.frame(movie_data$genres, stringsAsFactors=FALSE)\nlibrary(data.table)\nmovie_genre2 <- as.data.frame(tstrsplit(movie_genre[,1], '[|]', \n                                   type.convert=TRUE), \n                         stringsAsFactors=FALSE)\ncolnames(movie_genre2) <- c(1:10)\nlist_genre <- c(\"Action\", \"Adventure\", \"Animation\", \"Children\", \n                \"Comedy\", \"Crime\",\"Documentary\", \"Drama\", \"Fantasy\",\n                \"Film-Noir\", \"Horror\", \"Musical\", \"Mystery\",\"Romance\",\n                \"Sci-Fi\", \"Thriller\", \"War\", \"Western\")\ngenre_mat1 <- matrix(0,10330,18)\ngenre_mat1[1,] <- list_genre\ncolnames(genre_mat1) <- list_genre\nfor (index in 1:nrow(movie_genre2)) {\n  for (col in 1:ncol(movie_genre2)) {\n    gen_col = which(genre_mat1[1,] == movie_genre2[index,col]) \n    genre_mat1[index+1,gen_col] <- 1\n}\n}\ngenre_mat2 <- as.data.frame(genre_mat1[-1,], stringsAsFactors=FALSE) #remove first row, which was the genre list\nfor (col in 1:ncol(genre_mat2)) {\n  genre_mat2[,col] <- as.integer(genre_mat2[,col]) #convert from characters to integers\n} \nstr(genre_mat2)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:44.206089Z","iopub.execute_input":"2023-03-16T15:41:44.207553Z","iopub.status.idle":"2023-03-16T15:41:49.739134Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# Create a ‘search matrix’ that will allow us to perform an easy search of the films by specifying the genre present in our list.\nSearchMatrix <- cbind(movie_data[,1:2], genre_mat2[])\nhead(SearchMatrix)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:49.743847Z","iopub.execute_input":"2023-03-16T15:41:49.746678Z","iopub.status.idle":"2023-03-16T15:41:49.827053Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"### For the movie recommendation system to make sense of our ratings through recommended labs, we have to convert our matrix into a sparse matrix. This new matrix is of the class ‘realRatingMatrix’:","metadata":{}},{"cell_type":"code","source":"ratingMatrix <- dcast(rating_data, userId~movieId, value.var = \"rating\", na.rm=FALSE)\nratingMatrix <- as.matrix(ratingMatrix[,-1]) #remove userIds\n#Convert rating matrix into a recommenderlab sparse matrix\nratingMatrix <- as(ratingMatrix, \"realRatingMatrix\")\nratingMatrix","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:49.831197Z","iopub.execute_input":"2023-03-16T15:41:49.833542Z","iopub.status.idle":"2023-03-16T15:41:53.263545Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"### Overview of some of the important parameters that provide us with various options for building recommendation systems for movies:","metadata":{}},{"cell_type":"code","source":"recommendation_model <- recommenderRegistry$get_entries(dataType = \"realRatingMatrix\")\nnames(recommendation_model)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:53.268081Z","iopub.execute_input":"2023-03-16T15:41:53.270755Z","iopub.status.idle":"2023-03-16T15:41:53.315068Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"lapply(recommendation_model, \"[[\", \"description\")\n# lapply() is a function that takes a vector,list or data frame as input and gives the output as list by appplying a certain operation on it.","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:53.319585Z","iopub.execute_input":"2023-03-16T15:41:53.322151Z","iopub.status.idle":"2023-03-16T15:41:53.358447Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"### Based Collaborative Filtering","metadata":{}},{"cell_type":"code","source":"recommendation_model$IBCF_realRatingMatrix$parameters","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:53.362248Z","iopub.execute_input":"2023-03-16T15:41:53.364464Z","iopub.status.idle":"2023-03-16T15:41:53.392135Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Exploring Similar Data\n- Collaborative Filtering involves suggesting movies to the users that are based on collecting preferences from many other users. For example, if user A likes to watch action films and so does user B, then the movies that user B will watch in the future will be recommended to A and vice-versa. Therefore, recommending movies is dependent on creating a relationship of similarity between the two users. With the help of recommended lab, we can compute similarities using various operators like cosine, Pearson as well as Jaccard.","metadata":{}},{"cell_type":"markdown","source":"## User's Similarities","metadata":{}},{"cell_type":"code","source":"similarity_mat <- similarity(ratingMatrix[1:4, ],\n                               method = \"cosine\",\n                               which = \"users\")\nas.matrix(similarity_mat)\nimage(as.matrix(similarity_mat), main = \"User's Similarities\")","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:53.395915Z","iopub.execute_input":"2023-03-16T15:41:53.398264Z","iopub.status.idle":"2023-03-16T15:41:53.800362Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- In the above matrix, each row and column represents a user. We have taken four users and each cell in this matrix represents the similarity that is shared between the two users.","metadata":{}},{"cell_type":"markdown","source":"### Delineate the similarity that is shared between the films:","metadata":{}},{"cell_type":"markdown","source":"## Movies similarity","metadata":{}},{"cell_type":"code","source":"movie_similarity <- similarity(ratingMatrix[, 1:4], method =\n                                 \"cosine\", which = \"items\")\nas.matrix(movie_similarity)\nimage(as.matrix(movie_similarity), main = \"Movies similarity\")","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:53.805392Z","iopub.execute_input":"2023-03-16T15:41:53.808147Z","iopub.status.idle":"2023-03-16T15:41:54.086318Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"### Extract the most unique ratings:","metadata":{}},{"cell_type":"code","source":"rating_values <- as.vector(ratingMatrix@data)\nunique(rating_values) # extracting unique ratings","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:54.090683Z","iopub.execute_input":"2023-03-16T15:41:54.093415Z","iopub.status.idle":"2023-03-16T15:41:54.878883Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"### Create a table of ratings that will display the most unique ratings:","metadata":{}},{"cell_type":"code","source":"Table_of_Ratings <- table(rating_values) # creating a count of movie ratings\nTable_of_Ratings","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:54.883176Z","iopub.execute_input":"2023-03-16T15:41:54.885809Z","iopub.status.idle":"2023-03-16T15:42:00.959808Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Most Viewed Movies Visualization\n - In this section of the machine learning project, we will explore the most viewed movies in our dataset. We will first count the number of views in a film and then organize them in a table that would group them in descending order.","metadata":{}},{"cell_type":"code","source":"movie_views <- colCounts(ratingMatrix) # count views for each movie\ntable_views <- data.frame(movie = names(movie_views),\n                          views = movie_views) # create dataframe of views\ntable_views <- table_views[order(table_views$views,\n                                 decreasing = TRUE), ] # sort by number of views\ntable_views$title <- NA\nfor (index in 1:10325){\n  table_views[index,3] <- as.character(subset(movie_data,\n                                         movie_data$movieId == table_views[index,1])$title)\n}\ntable_views[1:6,]","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:00.963158Z","iopub.execute_input":"2023-03-16T15:42:00.965045Z","iopub.status.idle":"2023-03-16T15:42:33.158044Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"### Visualize a bar plot for the total number of views of the top films. We will carry this out using ggplot2:","metadata":{}},{"cell_type":"code","source":"ggplot(table_views[1:6, ], aes(x = title, y = views)) +\n  geom_bar(stat=\"identity\", fill = 'steelblue') +\n  geom_text(aes(label=views), vjust=-0.3, size=3.5) +\n  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +\n  ggtitle(\"Total Views of the Top Films\")","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:33.16213Z","iopub.execute_input":"2023-03-16T15:42:33.164035Z","iopub.status.idle":"2023-03-16T15:42:33.575608Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- From the above bar-plot, we observe that Pulp Fiction is the most-watched film followed by Forrest Gump.","metadata":{}},{"cell_type":"markdown","source":"# Heatmap of Movie Ratings\n- Visualize a heatmap of the movie ratings. This heatmap will contain the first 25 rows and 25 columns as follows ","metadata":{}},{"cell_type":"code","source":"image(ratingMatrix[1:20, 1:25], axes = FALSE, main = \"Heatmap of the first 25 rows and 25 columns\")","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:33.578486Z","iopub.execute_input":"2023-03-16T15:42:33.580104Z","iopub.status.idle":"2023-03-16T15:42:33.792944Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Performing Data Preparation\n## We will conduct data preparation in the following three steps:\n\n- Selecting useful data.\n- Normalizing data.\n- Binarizing the data.\n\n### For finding useful data in our dataset, we have set the threshold for the minimum number of users who have rated a film as 50. This is also same for minimum number of views that are per film. This way, we have filtered a list of watched films from least-watched ones.","metadata":{}},{"cell_type":"code","source":"movie_ratings <- ratingMatrix[rowCounts(ratingMatrix) > 50,\n                             colCounts(ratingMatrix) > 50]\nmovie_ratings","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:33.797357Z","iopub.execute_input":"2023-03-16T15:42:33.7991Z","iopub.status.idle":"2023-03-16T15:42:33.839535Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- From the above output of ‘movie_ratings’, we observe that there are 420 users and 447 films as opposed to the previous 668 users and 10325 films.","metadata":{}},{"cell_type":"markdown","source":"###  We can now delineate our matrix of relevant users as follows:","metadata":{}},{"cell_type":"code","source":"minimum_movies<- quantile(rowCounts(movie_ratings), 0.98)\nminimum_users <- quantile(colCounts(movie_ratings), 0.98)\nimage(movie_ratings[rowCounts(movie_ratings) > minimum_movies,\n                     colCounts(movie_ratings) > minimum_users],\nmain = \"Heatmap of the top users and movies\")","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:33.843613Z","iopub.execute_input":"2023-03-16T15:42:33.845894Z","iopub.status.idle":"2023-03-16T15:42:34.083141Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"### Visualize the distribution of the average ratings per user:","metadata":{}},{"cell_type":"code","source":"average_ratings <- rowMeans(movie_ratings)\nqplot(average_ratings, fill=I(\"steelblue\"), col=I(\"red\")) +\n  ggtitle(\"Distribution of the average rating per user\")","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:34.087177Z","iopub.execute_input":"2023-03-16T15:42:34.089091Z","iopub.status.idle":"2023-03-16T15:42:34.577243Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Data Normalization\n- In the case of some users, there can be high ratings or low ratings provided to all of the watched films. This will act as a bias while implementing our model. In order to remove this, we normalize our data. Normalization is a data preparation procedure to standardize the numerical values in a column to a common scale value. This is done in such a way that there is no distortion in the range of values. Normalization transforms the average value of our rating column to 0. We then plot a heatmap that delineates our normalized ratings.","metadata":{}},{"cell_type":"code","source":"normalized_ratings <- normalize(movie_ratings)\nsum(rowMeans(normalized_ratings) > 0.00001)\nimage(normalized_ratings[rowCounts(normalized_ratings) > minimum_movies,\n                          colCounts(normalized_ratings) > minimum_users],\nmain = \"Normalized Ratings of the Top Users\")","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:34.579921Z","iopub.execute_input":"2023-03-16T15:42:34.581483Z","iopub.status.idle":"2023-03-16T15:42:34.766379Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Performing Data Binarization\n- Binarizing the data means that we have two discrete values 1 and 0, which will allow our recommendation systems to work more efficiently. We will define a matrix that will consist of 1 if the rating is above 3 otherwise it will be 0.","metadata":{}},{"cell_type":"code","source":"binary_minimum_movies <- quantile(rowCounts(movie_ratings), 0.95)\nbinary_minimum_users <- quantile(colCounts(movie_ratings), 0.95)\n#movies_watched <- binarize(movie_ratings, minRating = 1)\ngood_rated_films <- binarize(movie_ratings, minRating = 3)\nimage(good_rated_films[rowCounts(movie_ratings) > binary_minimum_movies,\ncolCounts(movie_ratings) > binary_minimum_users],\nmain = \"Heatmap of the top users and movies\")","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:34.76915Z","iopub.execute_input":"2023-03-16T15:42:34.77077Z","iopub.status.idle":"2023-03-16T15:42:34.953875Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Collaborative Filtering System\n- In this section of the project, we will develop our very own Item Based Collaborative Filtering System. This type of collaborative filtering finds similarity in the items based on the people’s ratings of them. The algorithm first builds a similar-items table of the customers who have purchased them into a combination of similar items. This is then fed into the recommendation system.\n\n- The similarity between single products and related products can be determined with the following algorithm:\n    - For each Item i1 present in the product catalog, purchased by customer C.\n    - And, for each item, i2 was also purchased by customer C.\n    - Create a record that the customer purchased items i1 and i2.\n    - Calculate the similarity between i1 and i2.\n\n- We will build this filtering system by splitting the dataset into an 80% training set and a 20% test set.","metadata":{}},{"cell_type":"code","source":"sampled_data<- sample(x = c(TRUE, FALSE),\n                      size = nrow(movie_ratings),\n                      replace = TRUE,\n                      prob = c(0.8, 0.2))\ntraining_data <- movie_ratings[sampled_data, ]\ntesting_data <- movie_ratings[!sampled_data, ]","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:34.956529Z","iopub.execute_input":"2023-03-16T15:42:34.957963Z","iopub.status.idle":"2023-03-16T15:42:34.995383Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Building the Recommendation System\n- We will now explore the various parameters of our Item Based Collaborative Filter. These parameters are default in nature. In the first step, k denotes the number of items for computing their similarities. Here, k is equal to 30. Therefore, the algorithm will now identify the k most similar items and store their number. We use the cosine method which is the default one but you can also use the Pearson method.","metadata":{}},{"cell_type":"code","source":"recommendation_system <- recommenderRegistry$get_entries(dataType =\"realRatingMatrix\")\nrecommendation_system$IBCF_realRatingMatrix$parameters","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:34.99804Z","iopub.execute_input":"2023-03-16T15:42:34.999532Z","iopub.status.idle":"2023-03-16T15:42:35.025655Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"recommen_model <- Recommender(data = training_data,\n                          method = \"IBCF\",\n                          parameter = list(k = 30))\nrecommen_model","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:35.028301Z","iopub.execute_input":"2023-03-16T15:42:35.030006Z","iopub.status.idle":"2023-03-16T15:42:35.321919Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"class(recommen_model)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:35.324333Z","iopub.execute_input":"2023-03-16T15:42:35.325706Z","iopub.status.idle":"2023-03-16T15:42:35.343415Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"### Now explore our data science recommendation system model as follows:\n\n- Using the getModel() function, we will retrieve the recommen_model. We will then find the class and dimensions of our similarity matrix that is contained within model_info. Finally, we will generate a heatmap, that will contain the top 20 items and visualize the similarity shared between them.","metadata":{}},{"cell_type":"code","source":"model_info <- getModel(recommen_model)\nclass(model_info$sim)\ndim(model_info$sim)\ntop_items <- 20\nimage(model_info$sim[1:top_items, 1:top_items],\n   main = \"Heatmap of the first rows and columns\")","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:35.346086Z","iopub.execute_input":"2023-03-16T15:42:35.347496Z","iopub.status.idle":"2023-03-16T15:42:35.494426Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"### In the next step of ML project, we will carry out the sum of rows and columns with the similarity of the objects above 0. We will visualize the sum of columns through a distribution as follows:","metadata":{}},{"cell_type":"markdown","source":"# Distribution of the column count","metadata":{}},{"cell_type":"code","source":"sum_rows <- rowSums(model_info$sim > 0)\ntable(sum_rows)\nsum_cols <- colSums(model_info$sim > 0)\nqplot(sum_cols, fill=I(\"steelblue\"), col=I(\"red\"))+ ggtitle(\"Distribution of the column count\")","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:35.497017Z","iopub.execute_input":"2023-03-16T15:42:35.498477Z","iopub.status.idle":"2023-03-16T15:42:35.845467Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Build Recommender System on the dataset\n- We will create a top_recommendations variable which will be initialized to 10, specifying the number of films to each user. We will then use the predict() function that will identify similar items and will rank them appropriately. Here, each rating is used as a weight. Each weight is multiplied with related similarities. Finally, everything is added in the end.:","metadata":{}},{"cell_type":"code","source":"top_recommendations <- 10 # the number of items to recommend to each user\npredicted_recommendations <- predict(object = recommen_model,\n                          newdata = testing_data,\n                          n = top_recommendations)\npredicted_recommendations","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:35.848756Z","iopub.execute_input":"2023-03-16T15:42:35.850341Z","iopub.status.idle":"2023-03-16T15:42:35.960914Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"user1 <- predicted_recommendations@items[[1]] # recommendation for the first user\nmovies_user1 <- predicted_recommendations@itemLabels[user1]\nmovies_user2 <- movies_user1\nfor (index in 1:10){\n  movies_user2[index] <- as.character(subset(movie_data,\n                                         movie_data$movieId == movies_user1[index])$title)\n}\nmovies_user2","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:35.963605Z","iopub.execute_input":"2023-03-16T15:42:35.965138Z","iopub.status.idle":"2023-03-16T15:42:36.048774Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"recommendation_matrix <- sapply(predicted_recommendations@items,\n                      function(x){ as.integer(colnames(movie_ratings)[x]) }) # matrix with the recommendations for each user\n#dim(recc_matrix)\nrecommendation_matrix[,1:4]","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:36.05157Z","iopub.execute_input":"2023-03-16T15:42:36.053161Z","iopub.status.idle":"2023-03-16T15:42:36.086866Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Distribution of the Number of Items for IBCF","metadata":{}},{"cell_type":"code","source":"number_of_items <- factor(table(recommendation_matrix))\n\nchart_title <- \"Distribution of the Number of Items for IBCF\"\n\nqplot(number_of_items, fill=I(\"steelblue\"), col=I(\"red\")) + ggtitle(chart_title)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:36.089619Z","iopub.execute_input":"2023-03-16T15:42:36.091197Z","iopub.status.idle":"2023-03-16T15:42:36.406427Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Movie Title, No. of Items","metadata":{}},{"cell_type":"code","source":"number_of_items_sorted <- sort(number_of_items, decreasing = TRUE)\nnumber_of_items_top <- head(number_of_items_sorted, n = 4)\ntable_top <- data.frame(as.integer(names(number_of_items_top)),\nnumber_of_items_top)\nfor(i in 1:4) {\ntable_top[i,1] <- as.character(subset(movie_data,\nmovie_data$movieId == table_top[i,1])$title)\n}\n\ncolnames(table_top) <- c(\"Movie Title\", \"No. of Items\")\nhead(table_top)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:36.408892Z","iopub.execute_input":"2023-03-16T15:42:36.410387Z","iopub.status.idle":"2023-03-16T15:42:36.467416Z"},"trusted":true},"execution_count":null,"outputs":[]}]}