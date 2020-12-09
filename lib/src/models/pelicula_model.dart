class Peliculas {

  List<Pelicula> items = new List();

  Peliculas();

  Peliculas.fromJson(List<dynamic> data) {

    data.forEach((item) {
      items.add(
        Pelicula.fromJsonMap(item)
      );
    });
  }
}

class Pelicula {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> jsonMap) {
    popularity = jsonMap['popularity'] / 1;
    voteCount = jsonMap['voute_count'];
    video = jsonMap['video'];
    posterPath = jsonMap['poster_path'];
    id = jsonMap['id'];
    adult = jsonMap['adult'];
    backdropPath = jsonMap['backdrop_path'];
    originalLanguage = jsonMap['original_language'];
    originalTitle = jsonMap['original_title'];
    genreIds = jsonMap['genre_ids'].cast<int>();
    title = jsonMap['title'];
    voteAverage = jsonMap['vote_average'] / 1;
    overview = jsonMap['overview'];
    releaseDate = jsonMap['release_date'];
  }

  getPosterImg() {

    if (posterPath == null) {
      return 'https://cdn11.bigcommerce.com/s-hcp6qon/stencil/e7115e30-d125-0138-2c47-0242ac110007/icons/icon-no-image.svg';
    }

    return 'https://image.tmdb.org/t/p/w500/$posterPath';
  }

  getBackgroundImage() {

    if (posterPath == null) {
      return 'https://cdn11.bigcommerce.com/s-hcp6qon/stencil/e7115e30-d125-0138-2c47-0242ac110007/icons/icon-no-image.svg';
    }

    return 'https://image.tmdb.org/t/p/w500/$backdropPath';
  }
}