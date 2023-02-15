//Falta crear la clase y rellenarla con el código de quicktype
//A ese código, que va dentro del método Cast, hay que añadirle el método getter de más abajo
//Ese método se debe usar en casting_cards.dart o details_screen.dart para recuperar la info desde ahi
import 'models.dart';

// class Cast {
//   Cast({
//     required this.profilePath,
//   });

//   get fullProfilePath {
//     if (this.profilePath != null) {
//       return 'https://image.tmdb.org/t/p/w500${profilePath}';
//     }
//     return 'https://i.stack.imgur.com/GNhxO.png';
//   }
// }

class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int? castId;
  String? character;
  String creditId;
  int? order;
  String? department;
  String? job;

  get fullProfilePath {
    if (this.profilePath != null) {
      return 'https://image.tmdb.org/t/p/w500${profilePath}';
    }
    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

  factory Cast.fromMap(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: json["department"],
        job: json["job"],
      );
}
