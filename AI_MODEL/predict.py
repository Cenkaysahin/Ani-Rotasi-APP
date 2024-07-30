import pandas as pd
from sklearn.neighbors import NearestNeighbors
import joblib

def get_location_from_address(city, district, df):
    city = city.strip().lower()
    district = district.strip().lower()
    df['city_lower'] = df['city'].str.strip().str.lower()
    df['address_lower'] = df['address'].str.strip().str.lower()
    city_district = df[(df['city_lower'] == city) & (df['address_lower'].str.contains(district))]
    if not city_district.empty:
        return city_district.iloc[0]['latitude'], city_district.iloc[0]['longitude']
    else:
        return None

def main():
    city = input("Lütfen il giriniz: ")
    district = input("Lütfen ilçe giriniz: ")

    df = pd.read_csv('tourist_attractions.csv', encoding='utf-8')
    neigh = joblib.load('knn_model.joblib')

    location = get_location_from_address(city, district, df)
    if location is None:
        print(f"Koordinatlar bulunamadı: {city}, {district}")
        return

    latitude, longitude = location

    distances, indices = neigh.kneighbors([[latitude, longitude]], n_neighbors=5)
    nearest_places = df.iloc[indices[0]]

    for _, place in nearest_places.iterrows():
        print(f"{place['name']} - {place['address']} - Rating: {place['rating']} - User Ratings: {place['user_ratings_total']}")

if __name__ == '__main__':
    main()
