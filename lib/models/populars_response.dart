import 'dart:convert';
import 'models.dart';

class PopularsResponse {
  PopularsResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Popular> results;
  int totalPages;
  int totalResults;

  factory PopularsResponse.fromJson(String str) =>
      PopularsResponse.fromMap(json.decode(str));

//  String toJson() => json.encode(toMap());

  factory PopularsResponse.fromMap(Map<String, dynamic> json) =>
      PopularsResponse(
        page: json["page"],
        results:
            List<Popular>.from(json["results"].map((x) => Popular.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  // Map<String, dynamic> toMap() => {
  //       "page": page,
  //       "results": List<dynamic>.from(results.map((x) => x.toMap())),
  //       "total_pages": totalPages,
  //       "total_results": totalResults,
  //     };
}

enum OriginalLanguage { EN, KO, NO, ES }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "es": OriginalLanguage.ES,
  "ko": OriginalLanguage.KO,
  "no": OriginalLanguage.NO
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
