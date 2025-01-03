# -*- coding: utf-8 -*-
"""Crawl Flickr.ipynb

Automatically generated by Colab.

Original file is located at
    https://colab.research.google.com/drive/1n2NAvop-7CnCBLfDmpQnV1s0HRSru-cg
"""

pip install requests

pip install flickrapi

import flickrapi
import pandas as pd
import time

api_key = 'b0e44e2fbec56ccb68d8893ddf14b335'
api_secret = '3604c8ebe2d493e9'

flickr = flickrapi.FlickrAPI(api_key, api_secret, format='parsed-json')

lat_min, lat_max = 15.975, 16.25
lon_min, lon_max = 107.975, 108.275

def get_user_country(user_id):
    try:
        user_info = flickr.people.getInfo(user_id=user_id)
        return user_info['person']['location']['_content'] if 'location' in user_info['person'] else 'Unknown'
    except Exception as e:
        print(f"Error fetching country for user {user_id}: {e}")
        return 'Unknown'

max_photos = 5000
per_page = 500
page = 1
total_photos = 0

data = []

while total_photos < max_photos:
    photos = flickr.photos.search(
        lat=16.0544, lon=108.2022, radius=5, per_page=per_page, page=page,
        extras='geo,tags,date_taken,url_o,description', sort='date-posted-desc'
    )

    if len(photos['photos']['photo']) == 0:
        break

    for photo in photos['photos']['photo']:
        photo_id = photo['id']
        owner_id = photo['owner']
        title = photo['title']
        date_taken = photo['datetaken']

        latitude = photo.get('latitude', 'Unknown')
        longitude = photo.get('longitude', 'Unknown')

        photo_url = photo.get('url_o', 'No URL')

        description = photo.get('description', {}).get('_content', 'No Description')

        country = get_user_country(owner_id)

        data.append({
            'User ID': owner_id,
            'Country': country,
            'Photo Title': title,
            'Date Taken': date_taken,
            'Latitude': latitude,
            'Longitude': longitude,
            'Photo URL': photo_url,
            'Description': description
        })

    total_photos += len(photos['photos']['photo'])
    page += 1

    time.sleep(1)

df = pd.DataFrame(data)
df.to_csv('flickr_da_nang_photos.csv', index=False)

print(f"Data saved to 'flickr_da_nang_photos.csv'. Total photos collected: {total_photos}")