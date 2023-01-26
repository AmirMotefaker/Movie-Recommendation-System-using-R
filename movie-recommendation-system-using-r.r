{"cells":[{"source":"<a href=\"https://www.kaggle.com/code/amirmotefaker/movie-recommendation-system-using-r?scriptVersionId=117367248\" target=\"_blank\"><img align=\"left\" alt=\"Kaggle\" title=\"Open in Kaggle\" src=\"https://kaggle.com/static/images/open-in-kaggle.svg\"></a>","metadata":{},"cell_type":"markdown","outputs":[],"execution_count":0},{"cell_type":"markdown","id":"889493de","metadata":{"_execution_state":"idle","_uuid":"051d70d956493feee0c6d64651c6a088724dca2a","papermill":{"duration":0.00403,"end_time":"2023-01-26T12:40:24.023237","exception":false,"start_time":"2023-01-26T12:40:24.019207","status":"completed"},"tags":[]},"source":["# What Is a Recommendation System?\n","- A recommendation system is an artificial intelligence or AI algorithm, usually associated with machine learning, that uses Big Data to suggest or recommend additional products to consumers. These can be based on various criteria, including past purchases, search history, demographic information, and other factors. Recommender systems are highly useful as they help users discover products and services they might otherwise have not found on their own.\n","\n","- Recommender systems are trained to understand the preferences, previous decisions, and characteristics of people and products using data gathered about their interactions. These include impressions, clicks, likes, and purchases. Because of their capability to predict consumer interests and desires on a highly personalized level, recommender systems are a favorite with content and product providers. They can drive consumers to just about any product or service that interests them, from books to videos to health classes to clothing.\n","\n","# Types of Recommendation Systems:\n","- **Collaborative filtering** algorithms recommend items (this is the filtering part) based on preference information from many users (this is the collaborative part). \n","\n","- **Content filtering**, by contrast, uses the attributes or features of an item  (this is the content part) to recommend other items similar to the user’s preferences. \n","\n","- **Hybrid recommender systems** combine the advantages of the types above to create a more comprehensive recommending system.\n","\n","- **Context filtering** includes users’ contextual information in  the recommendation process. \n","\n","\n","### The main goal of this machine learning project is to build a recommendation system that recommends movies to users."]},{"cell_type":"markdown","id":"e06d8a1c","metadata":{"papermill":{"duration":0.003205,"end_time":"2023-01-26T12:40:24.029928","exception":false,"start_time":"2023-01-26T12:40:24.026723","status":"completed"},"tags":[]},"source":["# Importing Libraries"]},{"cell_type":"code","execution_count":1,"id":"af5805eb","metadata":{"execution":{"iopub.execute_input":"2023-01-26T12:40:24.039356Z","iopub.status.busy":"2023-01-26T12:40:24.037651Z","iopub.status.idle":"2023-01-26T12:40:26.489655Z","shell.execute_reply":"2023-01-26T12:40:26.488387Z"},"papermill":{"duration":2.458983,"end_time":"2023-01-26T12:40:26.492006","exception":false,"start_time":"2023-01-26T12:40:24.033023","status":"completed"},"tags":[]},"outputs":[{"name":"stderr","output_type":"stream","text":["Loading required package: Matrix\n","\n","Loading required package: arules\n","\n","\n","Attaching package: ‘arules’\n","\n","\n","The following objects are masked from ‘package:base’:\n","\n","    abbreviate, write\n","\n","\n","Loading required package: proxy\n","\n","\n","Attaching package: ‘proxy’\n","\n","\n","The following object is masked from ‘package:Matrix’:\n","\n","    as.matrix\n","\n","\n","The following objects are masked from ‘package:stats’:\n","\n","    as.dist, dist\n","\n","\n","The following object is masked from ‘package:base’:\n","\n","    as.matrix\n","\n","\n","Loading required package: registry\n","\n","Registered S3 methods overwritten by 'registry':\n","  method               from \n","  print.registry_field proxy\n","  print.registry_entry proxy\n","\n","\n","Attaching package: ‘reshape2’\n","\n","\n","The following objects are masked from ‘package:data.table’:\n","\n","    dcast, melt\n","\n","\n"]}],"source":["library(recommenderlab)\n","library(ggplot2)                    \n","library(data.table)\n","library(reshape2)"]},{"cell_type":"markdown","id":"64842952","metadata":{"papermill":{"duration":0.003788,"end_time":"2023-01-26T12:40:26.500558","exception":false,"start_time":"2023-01-26T12:40:26.49677","status":"completed"},"tags":[]},"source":["# Retrieving the Data"]},{"cell_type":"code","execution_count":2,"id":"68f355c8","metadata":{"execution":{"iopub.execute_input":"2023-01-26T12:40:26.533509Z","iopub.status.busy":"2023-01-26T12:40:26.509681Z","iopub.status.idle":"2023-01-26T12:40:26.779391Z","shell.execute_reply":"2023-01-26T12:40:26.778115Z"},"papermill":{"duration":0.277797,"end_time":"2023-01-26T12:40:26.782146","exception":false,"start_time":"2023-01-26T12:40:26.504349","status":"completed"},"tags":[]},"outputs":[{"name":"stdout","output_type":"stream","text":["'data.frame':\t10329 obs. of  3 variables:\n"," $ movieId: int  1 2 3 4 5 6 7 8 9 10 ...\n"," $ title  : chr  \"Toy Story (1995)\" \"Jumanji (1995)\" \"Grumpier Old Men (1995)\" \"Waiting to Exhale (1995)\" ...\n"," $ genres : chr  \"Adventure|Animation|Children|Comedy|Fantasy\" \"Adventure|Children|Fantasy\" \"Comedy|Romance\" \"Comedy|Drama|Romance\" ...\n"]}],"source":["movie_data <- read.csv(\"/kaggle/input/movielens-dataset-movies/movies.csv\",stringsAsFactors=FALSE)\n","rating_data <- read.csv(\"/kaggle/input/movielens-dataset-for-recommendation-system/ratings.csv\")\n","str(movie_data)"]},{"cell_type":"code","execution_count":3,"id":"4ac78949","metadata":{"execution":{"iopub.execute_input":"2023-01-26T12:40:26.793503Z","iopub.status.busy":"2023-01-26T12:40:26.792085Z","iopub.status.idle":"2023-01-26T12:40:26.808854Z","shell.execute_reply":"2023-01-26T12:40:26.80754Z"},"papermill":{"duration":0.024772,"end_time":"2023-01-26T12:40:26.811173","exception":false,"start_time":"2023-01-26T12:40:26.786401","status":"completed"},"tags":[]},"outputs":[{"data":{"text/plain":["    movieId          title              genres         \n"," Min.   :     1   Length:10329       Length:10329      \n"," 1st Qu.:  3240   Class :character   Class :character  \n"," Median :  7088   Mode  :character   Mode  :character  \n"," Mean   : 31924                                        \n"," 3rd Qu.: 59900                                        \n"," Max.   :149532                                        "]},"metadata":{},"output_type":"display_data"}],"source":["summary(movie_data)"]},{"cell_type":"code","execution_count":4,"id":"10ed45c2","metadata":{"execution":{"iopub.execute_input":"2023-01-26T12:40:26.822612Z","iopub.status.busy":"2023-01-26T12:40:26.821226Z","iopub.status.idle":"2023-01-26T12:40:26.844186Z","shell.execute_reply":"2023-01-26T12:40:26.842763Z"},"papermill":{"duration":0.030538,"end_time":"2023-01-26T12:40:26.846007","exception":false,"start_time":"2023-01-26T12:40:26.815469","status":"completed"},"tags":[]},"outputs":[{"data":{"text/html":["<table class=\"dataframe\">\n","<caption>A data.frame: 6 × 3</caption>\n","<thead>\n","\t<tr><th></th><th scope=col>movieId</th><th scope=col>title</th><th scope=col>genres</th></tr>\n","\t<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n","</thead>\n","<tbody>\n","\t<tr><th scope=row>1</th><td>1</td><td>Toy Story (1995)                  </td><td>Adventure|Animation|Children|Comedy|Fantasy</td></tr>\n","\t<tr><th scope=row>2</th><td>2</td><td>Jumanji (1995)                    </td><td>Adventure|Children|Fantasy                 </td></tr>\n","\t<tr><th scope=row>3</th><td>3</td><td>Grumpier Old Men (1995)           </td><td>Comedy|Romance                             </td></tr>\n","\t<tr><th scope=row>4</th><td>4</td><td>Waiting to Exhale (1995)          </td><td>Comedy|Drama|Romance                       </td></tr>\n","\t<tr><th scope=row>5</th><td>5</td><td>Father of the Bride Part II (1995)</td><td>Comedy                                     </td></tr>\n","\t<tr><th scope=row>6</th><td>6</td><td>Heat (1995)                       </td><td>Action|Crime|Thriller                      </td></tr>\n","</tbody>\n","</table>\n"],"text/latex":["A data.frame: 6 × 3\n","\\begin{tabular}{r|lll}\n","  & movieId & title & genres\\\\\n","  & <int> & <chr> & <chr>\\\\\n","\\hline\n","\t1 & 1 & Toy Story (1995)                   & Adventure\\textbar{}Animation\\textbar{}Children\\textbar{}Comedy\\textbar{}Fantasy\\\\\n","\t2 & 2 & Jumanji (1995)                     & Adventure\\textbar{}Children\\textbar{}Fantasy                 \\\\\n","\t3 & 3 & Grumpier Old Men (1995)            & Comedy\\textbar{}Romance                             \\\\\n","\t4 & 4 & Waiting to Exhale (1995)           & Comedy\\textbar{}Drama\\textbar{}Romance                       \\\\\n","\t5 & 5 & Father of the Bride Part II (1995) & Comedy                                     \\\\\n","\t6 & 6 & Heat (1995)                        & Action\\textbar{}Crime\\textbar{}Thriller                      \\\\\n","\\end{tabular}\n"],"text/markdown":["\n","A data.frame: 6 × 3\n","\n","| <!--/--> | movieId &lt;int&gt; | title &lt;chr&gt; | genres &lt;chr&gt; |\n","|---|---|---|---|\n","| 1 | 1 | Toy Story (1995)                   | Adventure|Animation|Children|Comedy|Fantasy |\n","| 2 | 2 | Jumanji (1995)                     | Adventure|Children|Fantasy                  |\n","| 3 | 3 | Grumpier Old Men (1995)            | Comedy|Romance                              |\n","| 4 | 4 | Waiting to Exhale (1995)           | Comedy|Drama|Romance                        |\n","| 5 | 5 | Father of the Bride Part II (1995) | Comedy                                      |\n","| 6 | 6 | Heat (1995)                        | Action|Crime|Thriller                       |\n","\n"],"text/plain":["  movieId title                             \n","1 1       Toy Story (1995)                  \n","2 2       Jumanji (1995)                    \n","3 3       Grumpier Old Men (1995)           \n","4 4       Waiting to Exhale (1995)          \n","5 5       Father of the Bride Part II (1995)\n","6 6       Heat (1995)                       \n","  genres                                     \n","1 Adventure|Animation|Children|Comedy|Fantasy\n","2 Adventure|Children|Fantasy                 \n","3 Comedy|Romance                             \n","4 Comedy|Drama|Romance                       \n","5 Comedy                                     \n","6 Action|Crime|Thriller                      "]},"metadata":{},"output_type":"display_data"}],"source":["head(movie_data)"]},{"cell_type":"code","execution_count":5,"id":"db071c15","metadata":{"execution":{"iopub.execute_input":"2023-01-26T12:40:26.857573Z","iopub.status.busy":"2023-01-26T12:40:26.856169Z","iopub.status.idle":"2023-01-26T12:40:26.896993Z","shell.execute_reply":"2023-01-26T12:40:26.895603Z"},"papermill":{"duration":0.049007,"end_time":"2023-01-26T12:40:26.899405","exception":false,"start_time":"2023-01-26T12:40:26.850398","status":"completed"},"tags":[]},"outputs":[{"data":{"text/plain":["     userId         movieId           rating        timestamp        \n"," Min.   :  1.0   Min.   :     1   Min.   :0.500   Min.   :8.286e+08  \n"," 1st Qu.:192.0   1st Qu.:  1073   1st Qu.:3.000   1st Qu.:9.711e+08  \n"," Median :383.0   Median :  2497   Median :3.500   Median :1.115e+09  \n"," Mean   :364.9   Mean   : 13381   Mean   :3.517   Mean   :1.130e+09  \n"," 3rd Qu.:557.0   3rd Qu.:  5991   3rd Qu.:4.000   3rd Qu.:1.275e+09  \n"," Max.   :668.0   Max.   :149532   Max.   :5.000   Max.   :1.452e+09  "]},"metadata":{},"output_type":"display_data"}],"source":["summary(rating_data)"]},{"cell_type":"code","execution_count":6,"id":"64ee04fd","metadata":{"execution":{"iopub.execute_input":"2023-01-26T12:40:26.911072Z","iopub.status.busy":"2023-01-26T12:40:26.909863Z","iopub.status.idle":"2023-01-26T12:40:26.931828Z","shell.execute_reply":"2023-01-26T12:40:26.929966Z"},"papermill":{"duration":0.029882,"end_time":"2023-01-26T12:40:26.933762","exception":false,"start_time":"2023-01-26T12:40:26.90388","status":"completed"},"tags":[]},"outputs":[{"data":{"text/html":["<table class=\"dataframe\">\n","<caption>A data.frame: 6 × 4</caption>\n","<thead>\n","\t<tr><th></th><th scope=col>userId</th><th scope=col>movieId</th><th scope=col>rating</th><th scope=col>timestamp</th></tr>\n","\t<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n","</thead>\n","<tbody>\n","\t<tr><th scope=row>1</th><td>1</td><td> 16</td><td>4.0</td><td>1217897793</td></tr>\n","\t<tr><th scope=row>2</th><td>1</td><td> 24</td><td>1.5</td><td>1217895807</td></tr>\n","\t<tr><th scope=row>3</th><td>1</td><td> 32</td><td>4.0</td><td>1217896246</td></tr>\n","\t<tr><th scope=row>4</th><td>1</td><td> 47</td><td>4.0</td><td>1217896556</td></tr>\n","\t<tr><th scope=row>5</th><td>1</td><td> 50</td><td>4.0</td><td>1217896523</td></tr>\n","\t<tr><th scope=row>6</th><td>1</td><td>110</td><td>4.0</td><td>1217896150</td></tr>\n","</tbody>\n","</table>\n"],"text/latex":["A data.frame: 6 × 4\n","\\begin{tabular}{r|llll}\n","  & userId & movieId & rating & timestamp\\\\\n","  & <int> & <int> & <dbl> & <int>\\\\\n","\\hline\n","\t1 & 1 &  16 & 4.0 & 1217897793\\\\\n","\t2 & 1 &  24 & 1.5 & 1217895807\\\\\n","\t3 & 1 &  32 & 4.0 & 1217896246\\\\\n","\t4 & 1 &  47 & 4.0 & 1217896556\\\\\n","\t5 & 1 &  50 & 4.0 & 1217896523\\\\\n","\t6 & 1 & 110 & 4.0 & 1217896150\\\\\n","\\end{tabular}\n"],"text/markdown":["\n","A data.frame: 6 × 4\n","\n","| <!--/--> | userId &lt;int&gt; | movieId &lt;int&gt; | rating &lt;dbl&gt; | timestamp &lt;int&gt; |\n","|---|---|---|---|---|\n","| 1 | 1 |  16 | 4.0 | 1217897793 |\n","| 2 | 1 |  24 | 1.5 | 1217895807 |\n","| 3 | 1 |  32 | 4.0 | 1217896246 |\n","| 4 | 1 |  47 | 4.0 | 1217896556 |\n","| 5 | 1 |  50 | 4.0 | 1217896523 |\n","| 6 | 1 | 110 | 4.0 | 1217896150 |\n","\n"],"text/plain":["  userId movieId rating timestamp \n","1 1       16     4.0    1217897793\n","2 1       24     1.5    1217895807\n","3 1       32     4.0    1217896246\n","4 1       47     4.0    1217896556\n","5 1       50     4.0    1217896523\n","6 1      110     4.0    1217896150"]},"metadata":{},"output_type":"display_data"}],"source":["head(rating_data)"]},{"cell_type":"markdown","id":"a6c47e8d","metadata":{"papermill":{"duration":0.004666,"end_time":"2023-01-26T12:40:26.943302","exception":false,"start_time":"2023-01-26T12:40:26.938636","status":"completed"},"tags":[]},"source":["# Data Pre-processing"]},{"cell_type":"markdown","id":"095a478a","metadata":{"papermill":{"duration":0.005148,"end_time":"2023-01-26T12:40:26.953188","exception":false,"start_time":"2023-01-26T12:40:26.94804","status":"completed"},"tags":[]},"source":["- From the above table, we observe that the userId column, as well as the movieId column, consist of integers. Furthermore, we need to convert the genres present in the movie_data dataframe into a more usable format by the users. In order to do so, we will first create a one-hot encoding to create a matrix that comprises of corresponding genres for each of the films."]},{"cell_type":"code","execution_count":7,"id":"bff3d662","metadata":{"execution":{"iopub.execute_input":"2023-01-26T12:40:26.96561Z","iopub.status.busy":"2023-01-26T12:40:26.964363Z","iopub.status.idle":"2023-01-26T12:40:29.127288Z","shell.execute_reply":"2023-01-26T12:40:29.125803Z"},"papermill":{"duration":2.171055,"end_time":"2023-01-26T12:40:29.129153","exception":false,"start_time":"2023-01-26T12:40:26.958098","status":"completed"},"tags":[]},"outputs":[{"name":"stdout","output_type":"stream","text":["'data.frame':\t10329 obs. of  18 variables:\n"," $ Action     : int  0 0 0 0 0 1 0 0 1 1 ...\n"," $ Adventure  : int  1 1 0 0 0 0 0 1 0 1 ...\n"," $ Animation  : int  1 0 0 0 0 0 0 0 0 0 ...\n"," $ Children   : int  1 1 0 0 0 0 0 1 0 0 ...\n"," $ Comedy     : int  1 0 1 1 1 0 1 0 0 0 ...\n"," $ Crime      : int  0 0 0 0 0 1 0 0 0 0 ...\n"," $ Documentary: int  0 0 0 0 0 0 0 0 0 0 ...\n"," $ Drama      : int  0 0 0 1 0 0 0 0 0 0 ...\n"," $ Fantasy    : int  1 1 0 0 0 0 0 0 0 0 ...\n"," $ Film-Noir  : int  0 0 0 0 0 0 0 0 0 0 ...\n"," $ Horror     : int  0 0 0 0 0 0 0 0 0 0 ...\n"," $ Musical    : int  0 0 0 0 0 0 0 0 0 0 ...\n"," $ Mystery    : int  0 0 0 0 0 0 0 0 0 0 ...\n"," $ Romance    : int  0 0 1 1 0 0 1 0 0 0 ...\n"," $ Sci-Fi     : int  0 0 0 0 0 0 0 0 0 0 ...\n"," $ Thriller   : int  0 0 0 0 0 1 0 0 0 1 ...\n"," $ War        : int  0 0 0 0 0 0 0 0 0 0 ...\n"," $ Western    : int  0 0 0 0 0 0 0 0 0 0 ...\n"]}],"source":["movie_genre <- as.data.frame(movie_data$genres, stringsAsFactors=FALSE)\n","library(data.table)\n","movie_genre2 <- as.data.frame(tstrsplit(movie_genre[,1], '[|]', \n","                                   type.convert=TRUE), \n","                         stringsAsFactors=FALSE)\n","colnames(movie_genre2) <- c(1:10)\n","list_genre <- c(\"Action\", \"Adventure\", \"Animation\", \"Children\", \n","                \"Comedy\", \"Crime\",\"Documentary\", \"Drama\", \"Fantasy\",\n","                \"Film-Noir\", \"Horror\", \"Musical\", \"Mystery\",\"Romance\",\n","                \"Sci-Fi\", \"Thriller\", \"War\", \"Western\")\n","genre_mat1 <- matrix(0,10330,18)\n","genre_mat1[1,] <- list_genre\n","colnames(genre_mat1) <- list_genre\n","for (index in 1:nrow(movie_genre2)) {\n","  for (col in 1:ncol(movie_genre2)) {\n","    gen_col = which(genre_mat1[1,] == movie_genre2[index,col]) \n","    genre_mat1[index+1,gen_col] <- 1\n","}\n","}\n","genre_mat2 <- as.data.frame(genre_mat1[-1,], stringsAsFactors=FALSE) #remove first row, which was the genre list\n","for (col in 1:ncol(genre_mat2)) {\n","  genre_mat2[,col] <- as.integer(genre_mat2[,col]) #convert from characters to integers\n","} \n","str(genre_mat2)"]},{"cell_type":"code","execution_count":8,"id":"e5b53f55","metadata":{"execution":{"iopub.execute_input":"2023-01-26T12:40:29.142151Z","iopub.status.busy":"2023-01-26T12:40:29.140737Z","iopub.status.idle":"2023-01-26T12:40:29.172868Z","shell.execute_reply":"2023-01-26T12:40:29.171524Z"},"papermill":{"duration":0.040406,"end_time":"2023-01-26T12:40:29.174827","exception":false,"start_time":"2023-01-26T12:40:29.134421","status":"completed"},"tags":[]},"outputs":[{"data":{"text/html":["<table class=\"dataframe\">\n","<caption>A data.frame: 6 × 20</caption>\n","<thead>\n","\t<tr><th></th><th scope=col>movieId</th><th scope=col>title</th><th scope=col>Action</th><th scope=col>Adventure</th><th scope=col>Animation</th><th scope=col>Children</th><th scope=col>Comedy</th><th scope=col>Crime</th><th scope=col>Documentary</th><th scope=col>Drama</th><th scope=col>Fantasy</th><th scope=col>Film-Noir</th><th scope=col>Horror</th><th scope=col>Musical</th><th scope=col>Mystery</th><th scope=col>Romance</th><th scope=col>Sci-Fi</th><th scope=col>Thriller</th><th scope=col>War</th><th scope=col>Western</th></tr>\n","\t<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n","</thead>\n","<tbody>\n","\t<tr><th scope=row>1</th><td>1</td><td>Toy Story (1995)                  </td><td>0</td><td>1</td><td>1</td><td>1</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n","\t<tr><th scope=row>2</th><td>2</td><td>Jumanji (1995)                    </td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n","\t<tr><th scope=row>3</th><td>3</td><td>Grumpier Old Men (1995)           </td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n","\t<tr><th scope=row>4</th><td>4</td><td>Waiting to Exhale (1995)          </td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n","\t<tr><th scope=row>5</th><td>5</td><td>Father of the Bride Part II (1995)</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>\n","\t<tr><th scope=row>6</th><td>6</td><td>Heat (1995)                       </td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td></tr>\n","</tbody>\n","</table>\n"],"text/latex":["A data.frame: 6 × 20\n","\\begin{tabular}{r|llllllllllllllllllll}\n","  & movieId & title & Action & Adventure & Animation & Children & Comedy & Crime & Documentary & Drama & Fantasy & Film-Noir & Horror & Musical & Mystery & Romance & Sci-Fi & Thriller & War & Western\\\\\n","  & <int> & <chr> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int> & <int>\\\\\n","\\hline\n","\t1 & 1 & Toy Story (1995)                   & 0 & 1 & 1 & 1 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n","\t2 & 2 & Jumanji (1995)                     & 0 & 1 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n","\t3 & 3 & Grumpier Old Men (1995)            & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0\\\\\n","\t4 & 4 & Waiting to Exhale (1995)           & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0\\\\\n","\t5 & 5 & Father of the Bride Part II (1995) & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0\\\\\n","\t6 & 6 & Heat (1995)                        & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 1 & 0 & 0\\\\\n","\\end{tabular}\n"],"text/markdown":["\n","A data.frame: 6 × 20\n","\n","| <!--/--> | movieId &lt;int&gt; | title &lt;chr&gt; | Action &lt;int&gt; | Adventure &lt;int&gt; | Animation &lt;int&gt; | Children &lt;int&gt; | Comedy &lt;int&gt; | Crime &lt;int&gt; | Documentary &lt;int&gt; | Drama &lt;int&gt; | Fantasy &lt;int&gt; | Film-Noir &lt;int&gt; | Horror &lt;int&gt; | Musical &lt;int&gt; | Mystery &lt;int&gt; | Romance &lt;int&gt; | Sci-Fi &lt;int&gt; | Thriller &lt;int&gt; | War &lt;int&gt; | Western &lt;int&gt; |\n","|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n","| 1 | 1 | Toy Story (1995)                   | 0 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n","| 2 | 2 | Jumanji (1995)                     | 0 | 1 | 0 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n","| 3 | 3 | Grumpier Old Men (1995)            | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |\n","| 4 | 4 | Waiting to Exhale (1995)           | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |\n","| 5 | 5 | Father of the Bride Part II (1995) | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |\n","| 6 | 6 | Heat (1995)                        | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 |\n","\n"],"text/plain":["  movieId title                              Action Adventure Animation\n","1 1       Toy Story (1995)                   0      1         1        \n","2 2       Jumanji (1995)                     0      1         0        \n","3 3       Grumpier Old Men (1995)            0      0         0        \n","4 4       Waiting to Exhale (1995)           0      0         0        \n","5 5       Father of the Bride Part II (1995) 0      0         0        \n","6 6       Heat (1995)                        1      0         0        \n","  Children Comedy Crime Documentary Drama Fantasy Film-Noir Horror Musical\n","1 1        1      0     0           0     1       0         0      0      \n","2 1        0      0     0           0     1       0         0      0      \n","3 0        1      0     0           0     0       0         0      0      \n","4 0        1      0     0           1     0       0         0      0      \n","5 0        1      0     0           0     0       0         0      0      \n","6 0        0      1     0           0     0       0         0      0      \n","  Mystery Romance Sci-Fi Thriller War Western\n","1 0       0       0      0        0   0      \n","2 0       0       0      0        0   0      \n","3 0       1       0      0        0   0      \n","4 0       1       0      0        0   0      \n","5 0       0       0      0        0   0      \n","6 0       0       0      1        0   0      "]},"metadata":{},"output_type":"display_data"}],"source":["# Create a ‘search matrix’ that will allow us to perform an easy search of the films by specifying the genre present in our list.\n","SearchMatrix <- cbind(movie_data[,1:2], genre_mat2[])\n","head(SearchMatrix)"]},{"cell_type":"markdown","id":"4adce69c","metadata":{"papermill":{"duration":0.004641,"end_time":"2023-01-26T12:40:29.18455","exception":false,"start_time":"2023-01-26T12:40:29.179909","status":"completed"},"tags":[]},"source":["### For the movie recommendation system to make sense of our ratings through recommended labs, we have to convert our matrix into a sparse matrix. This new matrix is of the class ‘realRatingMatrix’:"]},{"cell_type":"code","execution_count":9,"id":"bf14c421","metadata":{"execution":{"iopub.execute_input":"2023-01-26T12:40:29.196971Z","iopub.status.busy":"2023-01-26T12:40:29.195674Z","iopub.status.idle":"2023-01-26T12:40:31.218209Z","shell.execute_reply":"2023-01-26T12:40:31.21685Z"},"papermill":{"duration":2.030983,"end_time":"2023-01-26T12:40:31.220195","exception":false,"start_time":"2023-01-26T12:40:29.189212","status":"completed"},"tags":[]},"outputs":[{"data":{"text/plain":["668 x 10325 rating matrix of class ‘realRatingMatrix’ with 105339 ratings."]},"metadata":{},"output_type":"display_data"}],"source":["ratingMatrix <- dcast(rating_data, userId~movieId, value.var = \"rating\", na.rm=FALSE)\n","ratingMatrix <- as.matrix(ratingMatrix[,-1]) #remove userIds\n","#Convert rating matrix into a recommenderlab sparse matrix\n","ratingMatrix <- as(ratingMatrix, \"realRatingMatrix\")\n","ratingMatrix"]},{"cell_type":"markdown","id":"c27a5458","metadata":{"papermill":{"duration":0.004773,"end_time":"2023-01-26T12:40:31.229926","exception":false,"start_time":"2023-01-26T12:40:31.225153","status":"completed"},"tags":[]},"source":["### Overview some of the important parameters that provide us various options for building recommendation systems for movies:"]},{"cell_type":"code","execution_count":10,"id":"6b84e165","metadata":{"execution":{"iopub.execute_input":"2023-01-26T12:40:31.243427Z","iopub.status.busy":"2023-01-26T12:40:31.24211Z","iopub.status.idle":"2023-01-26T12:40:31.26362Z","shell.execute_reply":"2023-01-26T12:40:31.262331Z"},"papermill":{"duration":0.030227,"end_time":"2023-01-26T12:40:31.26571","exception":false,"start_time":"2023-01-26T12:40:31.235483","status":"completed"},"tags":[]},"outputs":[{"data":{"text/html":["<style>\n",".list-inline {list-style: none; margin:0; padding: 0}\n",".list-inline>li {display: inline-block}\n",".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n","</style>\n","<ol class=list-inline><li>'HYBRID_realRatingMatrix'</li><li>'ALS_realRatingMatrix'</li><li>'ALS_implicit_realRatingMatrix'</li><li>'IBCF_realRatingMatrix'</li><li>'LIBMF_realRatingMatrix'</li><li>'POPULAR_realRatingMatrix'</li><li>'RANDOM_realRatingMatrix'</li><li>'RERECOMMEND_realRatingMatrix'</li><li>'SVD_realRatingMatrix'</li><li>'SVDF_realRatingMatrix'</li><li>'UBCF_realRatingMatrix'</li></ol>\n"],"text/latex":["\\begin{enumerate*}\n","\\item 'HYBRID\\_realRatingMatrix'\n","\\item 'ALS\\_realRatingMatrix'\n","\\item 'ALS\\_implicit\\_realRatingMatrix'\n","\\item 'IBCF\\_realRatingMatrix'\n","\\item 'LIBMF\\_realRatingMatrix'\n","\\item 'POPULAR\\_realRatingMatrix'\n","\\item 'RANDOM\\_realRatingMatrix'\n","\\item 'RERECOMMEND\\_realRatingMatrix'\n","\\item 'SVD\\_realRatingMatrix'\n","\\item 'SVDF\\_realRatingMatrix'\n","\\item 'UBCF\\_realRatingMatrix'\n","\\end{enumerate*}\n"],"text/markdown":["1. 'HYBRID_realRatingMatrix'\n","2. 'ALS_realRatingMatrix'\n","3. 'ALS_implicit_realRatingMatrix'\n","4. 'IBCF_realRatingMatrix'\n","5. 'LIBMF_realRatingMatrix'\n","6. 'POPULAR_realRatingMatrix'\n","7. 'RANDOM_realRatingMatrix'\n","8. 'RERECOMMEND_realRatingMatrix'\n","9. 'SVD_realRatingMatrix'\n","10. 'SVDF_realRatingMatrix'\n","11. 'UBCF_realRatingMatrix'\n","\n","\n"],"text/plain":[" [1] \"HYBRID_realRatingMatrix\"       \"ALS_realRatingMatrix\"         \n"," [3] \"ALS_implicit_realRatingMatrix\" \"IBCF_realRatingMatrix\"        \n"," [5] \"LIBMF_realRatingMatrix\"        \"POPULAR_realRatingMatrix\"     \n"," [7] \"RANDOM_realRatingMatrix\"       \"RERECOMMEND_realRatingMatrix\" \n"," [9] \"SVD_realRatingMatrix\"          \"SVDF_realRatingMatrix\"        \n","[11] \"UBCF_realRatingMatrix\"        "]},"metadata":{},"output_type":"display_data"}],"source":["recommendation_model <- recommenderRegistry$get_entries(dataType = \"realRatingMatrix\")\n","names(recommendation_model)"]}],"metadata":{"kernelspec":{"display_name":"R","language":"R","name":"ir"},"language_info":{"codemirror_mode":"r","file_extension":".r","mimetype":"text/x-r-source","name":"R","pygments_lexer":"r","version":"4.0.5"},"papermill":{"default_parameters":{},"duration":10.581065,"end_time":"2023-01-26T12:40:31.39158","environment_variables":{},"exception":null,"input_path":"__notebook__.ipynb","output_path":"__notebook__.ipynb","parameters":{},"start_time":"2023-01-26T12:40:20.810515","version":"2.4.0"}},"nbformat":4,"nbformat_minor":5}