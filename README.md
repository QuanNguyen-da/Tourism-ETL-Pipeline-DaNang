# **Tourism-ETL-Pipeline-DaNang and Analyzing Behaviers Tourisms**
## Why choosing this topic?


Big data from social media platforms and service websites has provided valuable insights for analysis and high-level decision-making. Nowadays, sharing experiences and information online has become increasingly common, contributing to the creation of massive amounts of data. As a result, big data is drawing significant attention from researchers and decision-makers across various fields, especially in the tourism industry. 

Analyzing tourist behavior in Da Nang has become an urgent requirement as the city is increasingly recognized as an attractive destination for both domestic and international visitors. Understanding tourists' behavior, such as their sightseeing preferences, not only helps local businesses optimize their services but also supports authorities in developing effective promotional strategies and improving the quality of the destination.

That why I choose this topic. 

###
 ## **Overview of the Development Process**
![image](https://github.com/user-attachments/assets/815f1614-d3af-47d8-af72-75de0d9e2216)

 ## 🛠️ **Tools and Technologies**
- **Python**: Selenium, Requests, Pandas to crawling data from web and API
- **SQL Server**: for data storage and transform 
- **SSIS**: for ETL pipeline
- **Power BI**: for visualization

## 📌 Project Steps
1. Scraping data from Hotel websites and Flickr API
2. Cleaning and transforming data by Using Geocage 
3. Building an ETL pipeline using SSIS
4. Storing and Cleaning data in SQL Server
5. Visualizing data with Power BI
## 🌐 Introduction to the Websites
In this project, several online platforms are utilized to gather valuable data for analysis. Below is an overview of the key websites involved:
1. Flickr - A popular photo-sharing website that allows users to upload and share images. It provides valuable geographical and user data.
2. Booking.com - A leading online travel agency specializing in lodging reservations, providing user reviews and ratings of hotels, which are key for analyzing tourist behavior.
3. Agoda - Another significant online travel service platform offering hotel booking services and user-generated content, including reviews and ratings, for a comprehensive analysis of accommodation preferences.

## Data Crawling
  ### 🏨 Hotel Data
  Each hotel will collect information such as: the access link to the hotel, the hotel’s rating score, the total number of 
  reviews, the hotel address, the ward, district of the hotel, and ratings for various criteria such as: service, location, 
  facilities, cleanliness, and price.
  
  ## 🖼️ Flickr Photo Information
  Each photo uploaded by tourists to the Flickr platform includes information such as: the photo, caption, time, and may 
  also include details about the tourist's country. Specifically, the following information will be collected:
   **UserID** : Each tourist will have a unique UserID to identify them.
   **Country**: The country or location where the tourist resides.
   **Photo**  : The link to the photo uploaded by the tourist on Flickr.
   **Title**  : The title of the post.
   **Description**: The content of the post.
   **DateTaken**: The time when the photo was taken.
   **Location**: The location where the photo was taken.

