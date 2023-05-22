class FavoriteLocations {
  double? lat;
  double? lon;

  FavoriteLocations({
    this.lat,
    this.lon,
  });

  FavoriteLocations.fromJson(Map<String, dynamic> json) {
    lat = (json['lat'] as num).toDouble();
    lon = (json['lon'] as num).toDouble();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;

    return data;
  }
}