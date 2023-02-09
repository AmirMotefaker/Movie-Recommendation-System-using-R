{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "6909a96c",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "papermill": {
     "duration": 0.002215,
     "end_time": "2023-02-09T08:28:14.396373",
     "exception": false,
     "start_time": "2023-02-09T08:28:14.394158",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# What is Movie Recommendation?\n",
    "- A movie recommendation system, or a movie recommender system, is an ML-based approach to filtering or predicting the users’ film preferences based on their past choices and behavior. It’s an advanced filtration mechanism that predicts the possible movie choices of the concerned user and their preferences towards a domain-specific item, aka movie.\n",
    "\n",
    "# Filtration Strategies for Movie Recommendation Systems\n",
    "- The most popular categories of the ML algorithms used for movie recommendations include content-based filtering and collaborative filtering systems.\n",
    "    - Content-Based Filtering\n",
    "    - Collaborative Filtering\n",
    "        - Collaborative filtering algorithms are divided into two categories:\n",
    "\n",
    "            - User-based collaborative filtering. The idea is to look for similar patterns in movie preferences in the target user and other users in the database.\n",
    "            - Item-based collaborative filtering. The basic concept here is to look for similar items (movies) that target users rate or interact with.\n",
    "\n",
    "\n",
    "# How to Build a Movie Recommendation System?\n",
    "- The basics of film recommendation engines are in machine learning, we could on to building an actual movie recommendation system.\n",
    "    1. Data. \n",
    "        - ML systems need data, so find and import the essential libraries with movie datasets that already have global ratings.\n",
    "    2. Analysis. \n",
    "        - Create generic recommendations of top-rated movies from the existing dataset.\n",
    "    3. Personalization. \n",
    "        - Get personalized ratings by providing your own movie scores.\n",
    "    4. Strategy. \n",
    "        - Implement a content-based or collaborative filtering strategy.\n",
    "    5. Combination. \n",
    "        - Combine recommendation lists to get a reasonable estimate across the ratings. The combined dataset of movie ratings can now be used for either filtering model.\n",
    "        \n",
    "# Best Movie Datasets for Recommendation Systems in ML\n",
    "- [MovieLens 25M data set](https://grouplens.org/datasets/movielens/)\n",
    "- [IMDB Datasets](https://www.imdb.com/interfaces/)\n",
    "- [Linguistic Data of 32k Film Subtitles with IMBDb Meta-Data](https://data.world/robertjoellewis/film-subtitles)\n",
    "- [Film data set from UCI](https://archive.ics.uci.edu/ml/datasets/Movie)\n",
    "- [Full MovieLens dataset on Kaggle](https://www.kaggle.com/rounakbanik/the-movies-dataset)\n",
    "- [Cornell Film Review Data](http://www.cs.cornell.edu/people/pabo/movie-review-data/)\n",
    "- [French National Cinema Center datasets](https://www.data.gouv.fr/fr/organizations/centre-national-du-cinema-et-de-l-image-animee/)\n",
    "- [Movie Industry on Kaggle](https://www.kaggle.com/danielgrijalvas/movies)\n",
    "- [Movie Body Counts](http://moviebodycounts.com/)\n",
    "- [Movie datasets on data.world](https://data.world/datasets/movies)\n",
    "\n",
    "# Top Movie Recommendation System Use Cases\n",
    "- Netflix\n",
    "- Amazon\n",
    "- YouTube\n",
    "\n",
    "Reference: [LabelYourData](https://labelyourdata.com/articles/movie-recommendation-with-machine-learning#introduction_to_the_movie_recommendation_system_architecture)\n",
    "\n",
    "# Important points of movie recommendation\n",
    "\n",
    "- Recommendation systems play an important role in e-commerce and online streaming services, such as Netflix, YouTube, and Amazon. Making the right recommendation for the next product, music or movie increases user retention and satisfaction, leading to sales and profit growth. Companies competing for customer loyalty invest in systems that capture and analyze the user’s preferences and offer products or services with a higher likelihood of purchase.\n",
    "\n",
    "- The economic impact of such a company-customer relationship is clear: Amazon is the largest online retail company by sales and part of its success comes from the recommendation system and marketing based on user preferences. In 2006 Netflix offered a one million dollar prize2 for the person or group that could improve their recommendation system by at least 10%.\n",
    "\n",
    "- Usually, recommendation systems are based on a rating scale from 1 to 5 grades or stars, with 1 indicating the lowest satisfaction and 5 being the highest satisfaction. Other indicators can also be used, such as comments posted on previously used items; video, music, or link shared with friends; percentage of movies watched or music listened; web pages visited and time spent on each page; product category; and any other interaction with the company’s web site or application can be used as a predictor.\n",
    "\n",
    "- The primary goal of recommendation systems is to help users find what they want based on their preferences and previous interactions and predict the rating for a new item. In this document, we create a movie recommendation system using the MovieLens dataset and apply the lessons learned during Harvard’s Data Science Professional Certificate3 program.\n",
    "\n",
    "- This document is structured as follows. Chapter 1 describes the dataset and summarizes the goal of the project and the key steps that were performed. In chapter 2 we explain the process and techniques used, such as data cleaning, data exploration, and visualization, any insights gained, and the modeling approach. In chapter 3 we present the modeling results and discuss the model performance. We conclude in chapter 4 with a brief summary of the report, its limitations, and future work."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 4.069866,
   "end_time": "2023-02-09T08:28:14.518390",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2023-02-09T08:28:10.448524",
   "version": "2.4.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
