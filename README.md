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
   Import the following necessary libraries: 
```python
   from selenium import webdriver
   from selenium.webdriver.chrome.service import Service
   from webdriver_manager.chrome import ChromeDriverManager
   from selenium.webdriver.common.by import By
   import time
   import csv
   from bs4 import BeautifulSoup 
``` 
        
  Utilizing some functions like: `driver.find_element `, `driver.switch_to.window`, `soup.find_all`, .... 
  
  See more in file: main/scripts/Crawl_Data/Crawl_flickr.py
  
  We collect these data:  `hotel_url`,`score`,`reviews_num`,`reviews`,`categories['Service']`,`categories['Location']`,`categories['Facilities']`,
  ` categories['Cleanliness']`,`categories['Value for money']`.

  Finally we have this dataset:
  
  <p align="center">
   <img src="https://github.com/user-attachments/assets/8a01b373-4886-47cb-bbda-9bd10be71cc3" alt="image" width="450">
  </p>



### 🖼️ Flickr Photo
   Dictionary: Requests, Flickrapi, API key.

   #### Detailed

   To collect data from Flickr through the API, you need to request a Key and Secret by visiting the App Garden and 
   requesting an API key like this.
   
  <p align="center">
   <img src="https://github.com/user-attachments/assets/2645e11a-c37e-474a-8e62-10896786cf0e" alt="image" width="350">
  </p>

   Once you have the Key and Secret, you can start collecting data through the API. 
   
   Use Python and install the following pip packages:  `pip install requests`, `pip install flickrapi`, `import pandas as pd`
   
   Because Location is Da Nang so we sent Latitude and Longitude: `lat_min, lat_max = 15.975, 16.25`, `lon_min, lon_max = 107.975, 108.275`. 
   Then sending number of photo. 
   
   We collect these data:  
   ` 'User ID': owner_id,
            'Country': country,
            'Photo Title': title,
            'Date Taken': date_taken,
            'Latitude': latitude,
            'Longitude': longitude,
            'Photo URL': photo_url,
            'Description': description`
            
  ## Cleaning Data
  Because the data is real-world, there will be many issues. Before performing location conversion, it is necessary to clean the data first, especially Flickr.
  The important columns are UserID, Country, DateTaken, Latitude, and Longitude, so the null values in these columns will be checked.
  
``` python
     column_to_check=['UserID','Country','DateTaken','Latitude','Longitude']
     null_values=data[column_to_check].isnull().sum()
```
   <p align="center">
        <img src="https://github.com/user-attachments/assets/0cea2d8f-1468-48b1-9fce-a46ef843ffe9" alt="image" width="350">
     </p>
   
   It can be seen that the Country column has many null values, but since the number of observations collected is large, it can be handled by removing them.
  Check and handle null or invalid values using Python.

  Convert to Uniform Format: 
  Since the name of a country can be written in different forms, for example, the United States can be written as USA or United States as shown below, the team will perform   the conversion to a single format. This will be done using Excel.
  
  <p align="center">
        <img src="https://github.com/user-attachments/assets/9fa1b696-2d12-435c-9ded-db23c672c197" alt="image" width="350">
     </p>
   

  ## Transforming Location Data by OpenCage GeoCoding

  ### Agoda and Booking
  
  Firstly you must get the key in web of OpenCage GeoCoding.
  
  <p align="center">
    <img src="https://github.com/user-attachments/assets/05757821-fc66-4470-9222-6c6d2ce0acb7" alt="image" width="350">
  </p>
  
  Download bakages: `from opencage.geocoder`, `import OpenCageGeocode`, `import time`.
  
  Get the API key and start transferring by using `get_address_components` and `geocoder.geocode`.
```python
def get_address_components(address_1):
    result = geocoder.geocode(address_1)
    if result and len(result):
        components = result[0]['components']

        # Split
        address_parts = address_1.split(',')
        street_info = address_parts[0].strip().split(" ", 1)
        house_number = street_info[0]
        street_name = "Đường " + street_info[1] if len(street_info) > 1 else 'N/A'

        # Getting Ward and District
        ward = components.get('quarter', 'N/A').strip()
        district = components.get('suburb', 'N/A').strip()

        return house_number, street_name, ward, district
    else:
        return 'N/A', 'N/A', 'N/A', 'N/A'
```
 Result:
  
  <p align="center">
    <img src="https://github.com/user-attachments/assets/0239b461-21cf-48b6-8e39-96456e7ce630" alt="image" width="350">
  </p>
  
  ### With FLickr data, we tranferring location from Latitude and Longitude. 

  **Use Python and install the following pip:**

```python
!pip install opencage
```

 **Import the pandas library:**

```python
import pandas as pd
```
**Notes on data types during conversion:**  To convert from Latitude and Longitude to the corresponding location, these two columns must be in Float format. After converting to Float, recheck the data types

Perform the conversion with the output being the Street Name, District Name, Commune Name, and City Name.
``` python
 def get_address_components(lat, lon):
    result = geocoder.geocode(f"{lat}, {lon}")
    if result and len(result):
        components = result[0]['components']
        street = components.get('road', 'N/A')
        ward = components.get('quarter', 'N/A')
        district = components.get('suburb', 'N/A')
        city = components.get('city', 'N/A')
        country = components.get('country', 'N/A')
        return street, ward, district, city, country
    else:
        return 'N/A', 'N/A', 'N/A', 'N/A', 'N/A'
```

Result:
  
  <p align="center">
    <img src="https://github.com/user-attachments/assets/21613a2a-cb17-4002-911d-5eaacc01b21f" alt="image" width="350">
  </p>



## Designing ERD
  The data from the three sources, Flickr, Booking.com, and Agoda, are different. Therefore, to link the data, the team 
  will design an ERD from the initial three tables as follows:
  
  <p align="center">
    <img src="https://github.com/user-attachments/assets/445aaa1a-efe5-4e29-8850-3ee5249e4f48" alt="image" width="350">
  </p>

## Buid ETL Pipeline 
### Storage Data in SSMS 

After creating the database named "Cap2," the team proceeds to import the data tables. Then, select the source as Excel and the destination, and follow the steps sequentially for all the tables. 

Click Next → Finish to successfully load the data.

<p align="center">
    <img src="https://github.com/user-attachments/assets/952232b9-c641-476a-b1f0-e8fb3737c344" alt="image" width="350">
 </p>
<p align="center">
    <img src="https://github.com/user-attachments/assets/b5c939ed-0d4c-48b9-a366-49fd19dfcbc7" alt="image" width="350">
 </p>


  ### Build ETL pipeline in SSIS.
**Data Flow Customer**

Use the Script Component to perform the transformation. In the original table – Flickr, data is collected for each photo, and one person can take multiple photos. Therefore, there will be many duplicate UserIDs. In the Customer table, UserID is used as the Primary Key, so it will be filtered to keep only unique UserIDs along with the corresponding Country.

Create a new output with two columns: UserID1 and Country1. Afterward, check the Input and Output in the "Inputs and Outputs" tab.

Note: The data type must be converted to Unicode String because the data will contain Vietnamese characters. Set the Input Column to "ReadWrite".
<p align="center">
    <img src="https://github.com/user-attachments/assets/7bbc5eb7-3324-4fd4-8372-c6590dae0f37" alt="image" width="300">
 </p>
Note: Before clicking OK, check for any errors by opening the Error List. Make sure to save your work before exiting. Use OLE DB Destination to load the transformed data to the destination. 

However, before that, you must create a table at the destination with a structure similar to the Output created in the Script.

```sql
 CREATE TABLE Customer (
    UserID NVARCHAR(500) not null,
    Country NVARCHAR(500),
    UserID1 NVARCHAR(500),
    Country1 NVARCHAR(500)
);
```
Click Start to run the Customer Flow you just created.

<p align="center">
    <img src="https://github.com/user-attachments/assets/d013fafe-9345-4cd9-9a99-94c2dfcb49ed" alt="image" width="300">
 </p>

Similarly, for the other tables, here are the flows for each table:
**Data Flow Data**
<p align="center">
    <img src="https://github.com/user-attachments/assets/af7944b0-17dc-46f2-97e8-0aa9ba4cd295" alt="image" width="300">
 </p>
 
**Data Flow Location**
<p align="center">
    <img src="https://github.com/user-attachments/assets/096d51de-571e-4014-bcf8-9276b1322462" alt="image" width="300">
 </p>

**Data Flow Hotel**
<p align="center">
    <img src="https://github.com/user-attachments/assets/a5548d47-f23a-45f4-8122-fb1249dfde30" alt="image" width="300">
 </p>

## Transform by SQL
**Encode the User_ID column.**
```sql
  WITH CTE AS (
     SELECT *,
            ROW_NUMBER() OVER (PARTITION BY UserID ORDER BY (SELECT NULL)) AS RowNum
     FROM dbo.Customer
 )
 DELETE FROM CTE WHERE RowNum > 1;
 WITH NumberedUsers AS (
     SELECT 
         UserID,
         ROW_NUMBER() OVER (ORDER BY UserID) AS RowNum
     FROM 
         Customer
 )
 UPDATE Customer
 SET EncodedUserID = 'KDL_' + CAST(RowNum AS NVARCHAR(10))
 FROM NumberedUsers
 WHERE Customer.UserID = NumberedUsers.UserID;
```
**Check Duplicate Data**

```sql
 SELECT LocationID, COUNT(*)
 FROM dbo.Location
 GROUP BY LocationID
 HAVING COUNT(*) > 1;
 ;WITH CTE AS (
     SELECT *,
            ROW_NUMBER() OVER (PARTITION BY LocationID ORDER BY (SELECT NULL)) AS RowNum
     FROM dbo.Location
 )
 DELETE FROM CTE WHERE RowNum > 1;
 ALTER TABLE dbo.Location

 ADD CONSTRAINT PK_Location PRIMARY KEY (LocationID);
```
See more in file name: ETL Pipeline.sln and Cleaning_Data.sql
  
# Insight and Visualization
<p align="center">
  <img src="https://github.com/user-attachments/assets/35853ecf-24d6-498c-917f-75d602e5c627" alt="image" width="300">
</p>

  The number of tourists coming to Da Nang has been steadily increasing over the years, indicating that tourism in Vietnam    is growing rapidly.
  In 2021, the tourism industry was almost frozen. The cause of this situation was the ongoing Covid-19 pandemic, where 
  both other countries and Vietnam had to close their borders to fight the pandemic, which significantly impacted tourism 
  nationwide, including in Da Nang.

 <p align="center">
  <img src="https://github.com/user-attachments/assets/b1797fb0-54d0-4426-9967-35bf50306eee" alt="image" width="300">
</p>

The number of tourists visiting Da Nang fluctuates over time, specifically, the number of tourists increases significantly at the beginning of the year in January and February, and peaks during the summer months of June, July, and August.
The number of tourists to Da Nang tends to increase during these months due to various factors such as the climate, public holidays, and tourism events and activities taking place during this period.

<p align="center">
  <img src="https://github.com/user-attachments/assets/133238b9-19b9-4eab-9125-9c15185db477" alt="image" width="300">
</p>

After more than 2 years of being almost 'frozen' due to the pandemic, in 2022, Vietnam's tourism made a strong comeback with the milestone of fully reopening. Vietnam became the first country in Southeast Asia to fully open its tourism. After reopening, Vietnam's tourism recovered strongly with the number of visitors reaching 3,000 tourists. However, this figure is still far below the 18,000 international visitors in 2019. The reason for this situation is that the full reopening happened in March, which was not yet the peak tourist season. Additionally, this was the period when the Russia-Ukraine war was unfolding, leading to the closure of related flight routes, and some countries still had not lifted lockdowns due to the pandemic.

<p align="center">
  <img src="https://github.com/user-attachments/assets/c6c3de08-ceee-4c2c-a55a-643501857d5f" alt="image" width="300">
</p>

However, compared to 2021, there was a significant growth in 2022, but the number of visitors from different countries showed considerable disparity, as seen in Chart 4.

Especially with China, although it is a country that brings a large number of tourists to Da Nang, in 2022 it still had closed its borders due to the pandemic, so the number of tourists was very low compared to other countries, with only 201 visitors, the lowest in the rankings.

Notably, South Korea led with 853 tourists, having the highest number of visitors. It could be due to the cold weather in South Korea, so after the pandemic, people were more likely to travel, especially to tropical countries with long coastlines and warm climates like Vietnam to enjoy the weather. Tourists from this country accounted for 28.32% of the total international visitors to Da Nang in 2022.

The tourism market in 2022 experienced growth with an increase in the number of visitors from countries like the United States with 644 tourists, ranking second and accounting for 21.38% of the total international visitors to Da Nang in 2022. Following that were Thailand with 501 tourists and Singapore with 330 tourists
  
<p align="center">
  <img src="https://github.com/user-attachments/assets/4418cba3-885b-4d2b-9fc2-8bfa495977ea" alt="image" width="300">
</p>

In 2022, because Vietnam started reopening after the pandemic in March, the number of international visitors in the early months of the year was not significant. However, from June onwards, the number of international visitors steadily increased, with a 13% rise in August, continuing to grow until the end of the year, reaching 575 visitors.

The increase in international visitors from August to the end of the year can be attributed to several factors: From mid-2022, Vietnam intensified its tourism promotion in international markets through events, travel fairs (such as ITB Asia in Singapore), and digital media campaigns. This helped raise international tourists' awareness of Vietnam's safety and readiness. Additionally, the period from August to the end of the year is typically the peak tourist season for international visitors due to summer vacations and the holiday season. Vietnam hosted many events to attract tourists, such as the Hue Festival, as well as festivals in Da Nang and Phu Quoc

<p align="center">
  <img src="https://github.com/user-attachments/assets/97e78b55-7504-46ce-a3a8-710dff6a4651" alt="image" width="300">
</p>

2023 has been an extremely dynamic year for Vietnam's tourism in general and Da Nang in particular. International visitors increased by 65%, with more than 10,000 visitors arriving.
 
<p align="center">
  <img src="https://github.com/user-attachments/assets/503178cf-5c84-46f2-b405-f6681c9c4a4e" alt="image" width="300">
</p>
In 2023, China announced the reopening of its borders and tourism, which holds significant meaning for Vietnam's tourism industry, as it considers China a major market. The easing of these restrictions is seen as a positive signal, helping to boost efforts to attract Chinese tourists, stabilize the flow of international visitors to Vietnam, and increase revenue from this potential market. 

The number of visitors surged to 2,252 in 2023, accounting for a large proportion of the total visitors in the year.
