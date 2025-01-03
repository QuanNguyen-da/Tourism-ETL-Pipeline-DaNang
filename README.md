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

## Introduce 
  ### 🏨 Hotel Data
  Each hotel will collect information such as: the access link to the hotel, the hotel’s rating score, the total number of 
  reviews, the hotel address, the ward, district of the hotel, and ratings for various criteria such as: service, location, 
  facilities, cleanliness, and price.
  
  ### 🖼️ Flickr Photo Information
  Each photo uploaded by tourists to the Flickr platform includes information such as: the photo, caption, time, and may 
  also include details about the tourist's country. Specifically, the following information will be collected:
   - **UserID** : Each tourist will have a unique UserID to identify them.
   - **Country**: The country or location where the tourist resides.
   - **Photo**  : The link to the photo uploaded by the tourist on Flickr.
   - **Title**  : The title of the post.
   - **Description**: The content of the post.
   - **DateTaken**: The time when the photo was taken.
   - **Location**: The location where the photo was taken.

 ## Crawling Data
   ### 🏨 Hotel
   Dictionary: Selenium, Webdriver Manager and Beautifulsoup4. 
   Use BeautifulSoup to parse HTML. Extract the HTML content of the page after it has fully loaded, and use BeautifulSoup to 
   analyze and retrieve the necessary information about the hotel details.
   ### 🖼️ Flickr Photo
   Dictionary: Requests, Flickrapi, API key.
   To collect data from Flickr through the API, you need to request a Key and Secret by visiting the App Garden and 
   requesting an API key. Once you have the Key and Secret, you can start collecting data through the API. Use Python and 
   install the following pip packages: pip install requests, pip install flickrapi.

  ## Transforming Data
  Check and handle null or invalid values using Python, then perform reverse geocoding using OpenCage.
  Download bakages: opencage, pandas. 
  Get the API key and start transferring, after that we have somethings like: 
  
  ![image](https://github.com/user-attachments/assets/0239b461-21cf-48b6-8e39-96456e7ce630)

  With FLickr data, we tranferring location from Latitude and Longitude. 

  ## Designing ERD
  The data from the three sources, Flickr, Booking.com, and Agoda, are different. Therefore, to link the data, the team will 
  design an ERD from the initial three tables as follows:
  
  ![image](https://github.com/user-attachments/assets/445aaa1a-efe5-4e29-8850-3ee5249e4f48)

  ## Buid ETL Pipeline in SSIS
  Using SSMS to store and SSIS to build ETL pipeline. Then we make some transform by SQL.
  Example: 
  
  ![image](https://github.com/user-attachments/assets/13a0a6a6-54e8-4997-ad69-885e57b5e42a)

  See more in file name: ETL Pipeline.sln and Cleaning_Data.sql
  
# Insight and Visualization
<img src="https://github.com/user-attachments/assets/35853ecf-24d6-498c-917f-75d602e5c627" alt="image" width="300">

  The number of tourists coming to Da Nang has been steadily increasing over the years, indicating that tourism in Vietnam     is growing rapidly.

  In 2021, the tourism industry was almost frozen. The cause of this situation was the ongoing Covid-19 pandemic, where   
  both   other countries and Vietnam had to close their borders to fight the pandemic, which significantly impacted tourism 
  nationwide, including in Da Nang.

  



 
     

