class FavoriteLocations {
  double? lat;
  double? lon;
  int? id;

  FavoriteLocations({
    this.lat,
    this.lon,
    this.id,
  });

  FavoriteLocations.fromJson(Map<String, dynamic> json) {
    lat = (json['lat'] as num).toDouble();
    lon = (json['lon'] as num).toDouble();
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    data['id'] = id;

    return data;
  }
}
