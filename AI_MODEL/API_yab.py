import pandas as pd
from geopy.distance import geodesic

# CSV dosyasını yükle
df = pd.read_csv('tourist_attractions.csv')

# Belirli bir konuma yakın 5 turistik yeri bul
def find_nearest_places(city, district, df, num_places=5):
    df['city_lower'] = df['city'].str.lower().str.strip()
    df['address_lower'] = df['address'].str.lower().str.strip()
    
    city_district = df[(df['city_lower'] == city.lower().strip()) & (df['address_lower'].str.contains(district.lower().strip()))]
    
    if city_district.empty:
        return pd.DataFrame()  # Boş DataFrame döndür
    
    city_lat, city_lng = city_district.iloc[0]['latitude'], city_district.iloc[0]['longitude']
    
    # Tüm turistik yerler için mesafeleri hesaplayın
    df['distance'] = df.apply(lambda row: geodesic((city_lat, city_lng), (row['latitude'], row['longitude'])).kilometers, axis=1)
    
    # En yakın 5 yeri bulun
    nearest_places = df.nsmallest(num_places, 'distance')
    
    return nearest_places

# İl ve ilçe girin
city = 'adana'
district = 'seyhan'

# En yakın 5 turistik yeri bulun
nearest_places = find_nearest_places(city, district, df)

# Sonuçları yazdırın
if nearest_places.empty:
    print(f"Koordinatlar bulunamadı: {city}, {district}")
else:
    for index, place in nearest_places.iterrows():
        print(f"{place['name']} - {place['address']} - Rating: {place['rating']} - User Ratings: {place['user_ratings_total']}")
