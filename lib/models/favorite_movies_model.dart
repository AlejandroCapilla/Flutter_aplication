class FavoriteMoviesModel {
  int? id;

  FavoriteMoviesModel({
    this.id,
  });

  factory FavoriteMoviesModel.fromMap(Map<String, dynamic> map) {
    return FavoriteMoviesModel(id: map['id']);
  }
}
