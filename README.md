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
   Use BeautifulSoup to parse HTML. Extract the HTML content of the page after it has fully loaded, and use BeautifulSoup 
   to analyze and retrieve the necessary information about the hotel details.

   #### Detailed
   Download the following necessary libraries: 
   
         from selenium import webdriver
         from selenium.webdriver.chrome.service import Service
         from webdriver_manager.chrome import ChromeDriverManager
         from selenium.webdriver.common.by import By
         import time
         import csv
         from bs4 import BeautifulSoup  
         
  Utilizing some functions like: `driver.find_element `, `driver.switch_to.window`, `soup.find_all`, 

### 🖼️ Flickr Photo
   Dictionary: Requests, Flickrapi, API key.
   To collect data from Flickr through the API, you need to request a Key and Secret by visiting the App Garden and 
   requesting an API key. Once you have the Key and Secret, you can start collecting data through the API. Use Python and 
   install the following pip packages: pip install requests, pip install flickrapi.

  ## Transforming Data
  Check and handle null or invalid values using Python, then perform reverse geocoding using OpenCage.
  Download bakages: opencage, pandas. 
  Get the API key and start transferring, after that we have somethings like: 
  
  <p align="center">
    <img src="https://github.com/user-attachments/assets/0239b461-21cf-48b6-8e39-96456e7ce630" alt="image" width="350">
  </p>
  With FLickr data, we tranferring location from Latitude and Longitude. 

  ## Designing ERD
  The data from the three sources, Flickr, Booking.com, and Agoda, are different. Therefore, to link the data, the team 
  will design an ERD from the initial three tables as follows:
  
  <p align="center">
    <img src="https://github.com/user-attachments/assets/445aaa1a-efe5-4e29-8850-3ee5249e4f48" alt="image" width="350">
  </p>

  ## Buid ETL Pipeline in SSIS
  Using SSMS to store and SSIS to build ETL pipeline. Then we make some transform by SQL.
  Example: 
  
  <p align="center">
    <img src="https://github.com/user-attachments/assets/13a0a6a6-54e8-4997-ad69-885e57b5e42a" alt="image" width="350">
  </p>
  See more in file name: ETL Pipeline.sln and Cleaning_Data.sql
  
# Insight and Visualization
<p align="center">
  <img src="https://github.com/user-attachments/assets/35853ecf-24d6-498c-917f-75d602e5c627" alt="image" width="350">
</p>

  The number of tourists coming to Da Nang has been steadily increasing over the years, indicating that tourism in Vietnam    is growing rapidly.
  In 2021, the tourism industry was almost frozen. The cause of this situation was the ongoing Covid-19 pandemic, where 
  both other countries and Vietnam had to close their borders to fight the pandemic, which significantly impacted tourism 
  nationwide, including in Da Nang.

 <p align="center">
  <img src="https://github.com/user-attachments/assets/b1797fb0-54d0-4426-9967-35bf50306eee" alt="image" width="350">
</p>

The number of tourists visiting Da Nang fluctuates over time, specifically, the number of tourists increases significantly at the beginning of the year in January and February, and peaks during the summer months of June, July, and August.
The number of tourists to Da Nang tends to increase during these months due to various factors such as the climate, public holidays, and tourism events and activities taking place during this period.

<p align="center">
  <img src="https://github.com/user-attachments/assets/133238b9-19b9-4eab-9125-9c15185db477" alt="image" width="350">
</p>

After more than 2 years of being almost 'frozen' due to the pandemic, in 2022, Vietnam's tourism made a strong comeback with the milestone of fully reopening. Vietnam became the first country in Southeast Asia to fully open its tourism. After reopening, Vietnam's tourism recovered strongly with the number of visitors reaching 3,000 tourists. However, this figure is still far below the 18,000 international visitors in 2019. The reason for this situation is that the full reopening happened in March, which was not yet the peak tourist season. Additionally, this was the period when the Russia-Ukraine war was unfolding, leading to the closure of related flight routes, and some countries still had not lifted lockdowns due to the pandemic.

<p align="center">
  <img src="https://github.com/user-attachments/assets/c6c3de08-ceee-4c2c-a55a-643501857d5f" alt="image" width="350">
</p>

However, compared to 2021, there was a significant growth in 2022, but the number of visitors from different countries showed considerable disparity, as seen in Chart 4.

Especially with China, although it is a country that brings a large number of tourists to Da Nang, in 2022 it still had closed its borders due to the pandemic, so the number of tourists was very low compared to other countries, with only 201 visitors, the lowest in the rankings.

Notably, South Korea led with 853 tourists, having the highest number of visitors. It could be due to the cold weather in South Korea, so after the pandemic, people were more likely to travel, especially to tropical countries with long coastlines and warm climates like Vietnam to enjoy the weather. Tourists from this country accounted for 28.32% of the total international visitors to Da Nang in 2022.

The tourism market in 2022 experienced growth with an increase in the number of visitors from countries like the United States with 644 tourists, ranking second and accounting for 21.38% of the total international visitors to Da Nang in 2022. Following that were Thailand with 501 tourists and Singapore with 330 tourists
  
<p align="center">
  <img src="https://github.com/user-attachments/assets/4418cba3-885b-4d2b-9fc2-8bfa495977ea" alt="image" width="350">
</p>

In 2022, because Vietnam started reopening after the pandemic in March, the number of international visitors in the early months of the year was not significant. However, from June onwards, the number of international visitors steadily increased, with a 13% rise in August, continuing to grow until the end of the year, reaching 575 visitors.

The increase in international visitors from August to the end of the year can be attributed to several factors: From mid-2022, Vietnam intensified its tourism promotion in international markets through events, travel fairs (such as ITB Asia in Singapore), and digital media campaigns. This helped raise international tourists' awareness of Vietnam's safety and readiness. Additionally, the period from August to the end of the year is typically the peak tourist season for international visitors due to summer vacations and the holiday season. Vietnam hosted many events to attract tourists, such as the Hue Festival, as well as festivals in Da Nang and Phu Quoc

<p align="center">
  <img src="https://github.com/user-attachments/assets/97e78b55-7504-46ce-a3a8-710dff6a4651" alt="image" width="350">
</p>

2023 has been an extremely dynamic year for Vietnam's tourism in general and Da Nang in particular. International visitors increased by 65%, with more than 10,000 visitors arriving.
 
<p align="center">
  <img src="https://github.com/user-attachments/assets/503178cf-5c84-46f2-b405-f6681c9c4a4e" alt="image" width="350">
</p>
In 2023, China announced the reopening of its borders and tourism, which holds significant meaning for Vietnam's tourism industry, as it considers China a major market. The easing of these restrictions is seen as a positive signal, helping to boost efforts to attract Chinese tourists, stabilize the flow of international visitors to Vietnam, and increase revenue from this potential market. 

The number of visitors surged to 2,252 in 2023, accounting for a large proportion of the total visitors in the year.
