// Generated by https://quicktype.io
class Cast {

  List<Actor> actores = new List();

  Cast();

  Cast.fromJson(List<dynamic> json) {
    json.forEach((actor) {
      this.actores.add(new Actor.fromJson(actor));
    });
  }
}


class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJson(Map<String, dynamic> actorJson) {
    castId =  actorJson['cast_id'];
    character = actorJson['character'];
    creditId = actorJson['credit_id'];
    gender = actorJson['gender'];
    id = actorJson['id'];
    name = actorJson['name'];
    order = actorJson['order'];
    profilePath = actorJson['profile_path'];
  }


  getFoto() {

    if (profilePath == null) {
      return 'https://cdn11.bigcommerce.com/s-hcp6qon/stencil/e7115e30-d125-0138-2c47-0242ac110007/icons/icon-no-image.svg';
    }

    return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }
}
