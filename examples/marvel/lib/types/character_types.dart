// To parse this JSON data, do
//
//     final marvelRequest = marvelRequestFromJson(jsonString);

import 'dart:convert';

MarvelRequest marvelRequestFromJson(String str) =>
    MarvelRequest.fromJson(json.decode(str));

String marvelRequestToJson(MarvelRequest data) => json.encode(data.toJson());

class MarvelRequest {
  int code;
  String status;
  String copyright;
  String attributionText;
  String attributionHtml;
  String etag;
  Data data;

  MarvelRequest({
    required this.code,
    required this.status,
    required this.copyright,
    required this.attributionText,
    required this.attributionHtml,
    required this.etag,
    required this.data,
  });

  MarvelRequest copyWith({
    int? code,
    String? status,
    String? copyright,
    String? attributionText,
    String? attributionHtml,
    String? etag,
    Data? data,
  }) =>
      MarvelRequest(
        code: code ?? this.code,
        status: status ?? this.status,
        copyright: copyright ?? this.copyright,
        attributionText: attributionText ?? this.attributionText,
        attributionHtml: attributionHtml ?? this.attributionHtml,
        etag: etag ?? this.etag,
        data: data ?? this.data,
      );

  factory MarvelRequest.fromJson(Map<String, dynamic> json) => MarvelRequest(
        code: json["code"],
        status: json["status"],
        copyright: json["copyright"],
        attributionText: json["attributionText"],
        attributionHtml: json["attributionHTML"],
        etag: json["etag"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "copyright": copyright,
        "attributionText": attributionText,
        "attributionHTML": attributionHtml,
        "etag": etag,
        "data": data.toJson(),
      };
}

class Data {
  int offset;
  int limit;
  int total;
  int count;
  List<Character> results;

  Data({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });

  Data copyWith({
    int? offset,
    int? limit,
    int? total,
    int? count,
    List<Character>? results,
  }) =>
      Data(
        offset: offset ?? this.offset,
        limit: limit ?? this.limit,
        total: total ?? this.total,
        count: count ?? this.count,
        results: results ?? this.results,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        offset: json["offset"],
        limit: json["limit"],
        total: json["total"],
        count: json["count"],
        results: List<Character>.from(
            json["results"].map((x) => Character.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "total": total,
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Character {
  int? id;
  String? name;
  String? description;
  String? modified;
  Thumbnail? thumbnail;
  String? resourceUri;
  Comics? comics;
  Comics? series;
  Stories? stories;
  Comics? events;
  List<Url>? urls;

  Character({
    required this.id,
    required this.name,
    this.description,
    required this.modified,
    this.thumbnail,
    required this.resourceUri,
    this.comics,
    this.series,
    this.stories,
    this.events,
    this.urls,
  });

  Character copyWith({
    int? id,
    String? name,
    String? description,
    String? modified,
    Thumbnail? thumbnail,
    String? resourceUri,
    Comics? comics,
    Comics? series,
    Stories? stories,
    Comics? events,
    List<Url>? urls,
  }) =>
      Character(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        modified: modified ?? this.modified,
        thumbnail: thumbnail ?? this.thumbnail,
        resourceUri: resourceUri ?? this.resourceUri,
        comics: comics ?? this.comics,
        series: series ?? this.series,
        stories: stories ?? this.stories,
        events: events ?? this.events,
        urls: urls ?? this.urls,
      );

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        modified: json["modified"] ?? DateTime.now(),
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        resourceUri: json["resourceURI"] ?? "",
        comics: Comics.fromJson(json["comics"]),
        series: Comics.fromJson(json["series"]),
        stories: Stories.fromJson(json["stories"]),
        events: Comics.fromJson(json["events"]),
        urls: List<Url>.from(json["urls"].map((x) => Url.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "modified": modified,
        "thumbnail": thumbnail?.toJson(),
        "resourceURI": resourceUri,
        "comics": comics?.toJson(),
        "series": series?.toJson(),
        "stories": stories?.toJson(),
        "events": events?.toJson(),
        "urls": List<dynamic>.from((urls ?? []).map((x) => x.toJson())),
      };
}

class Comics {
  int available;
  String collectionUri;
  List<ComicsItem> items;
  int returned;

  Comics({
    required this.available,
    required this.collectionUri,
    required this.items,
    required this.returned,
  });

  Comics copyWith({
    int? available,
    String? collectionUri,
    List<ComicsItem>? items,
    int? returned,
  }) =>
      Comics(
        available: available ?? this.available,
        collectionUri: collectionUri ?? this.collectionUri,
        items: items ?? this.items,
        returned: returned ?? this.returned,
      );

  factory Comics.fromJson(Map<String, dynamic> json) => Comics(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<ComicsItem>.from(
            json["items"].map((x) => ComicsItem.fromJson(x))),
        returned: json["returned"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "returned": returned,
      };
}

class ComicsItem {
  String resourceUri;
  String name;

  ComicsItem({
    required this.resourceUri,
    required this.name,
  });

  ComicsItem copyWith({
    String? resourceUri,
    String? name,
  }) =>
      ComicsItem(
        resourceUri: resourceUri ?? this.resourceUri,
        name: name ?? this.name,
      );

  factory ComicsItem.fromJson(Map<String, dynamic> json) => ComicsItem(
        resourceUri: json["resourceURI"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
      };
}

class Stories {
  int? available;
  String? collectionUri;
  List<StoriesItem>? items;
  int? returned;

  Stories({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  Stories copyWith({
    int? available,
    String? collectionUri,
    List<StoriesItem>? items,
    int? returned,
  }) =>
      Stories(
        available: available ?? this.available,
        collectionUri: collectionUri ?? this.collectionUri,
        items: items ?? this.items,
        returned: returned ?? this.returned,
      );

  factory Stories.fromJson(Map<String, dynamic> json) => Stories(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<StoriesItem>.from(
            json["items"].map((x) => StoriesItem.fromJson(x))),
        returned: json["returned"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from((items ?? []).map((x) => x.toJson())),
        "returned": returned,
      };
}

class StoriesItem {
  String? resourceUri;
  String? name;
  String? type;

  StoriesItem({
    this.resourceUri,
    this.name,
    this.type,
  });

  StoriesItem copyWith({
    String? resourceUri,
    String? name,
    String? type,
  }) =>
      StoriesItem(
        resourceUri: resourceUri ?? this.resourceUri,
        name: name ?? this.name,
        type: type ?? this.type,
      );

  factory StoriesItem.fromJson(Map<String, dynamic> json) => StoriesItem(
        resourceUri: json["resourceURI"],
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
        "type": type,
      };
}

// enum Type { COVER, INTERIOR_STORY }

// final typeValues =
//     EnumValues({"cover": Type.COVER, "interiorStory": Type.INTERIOR_STORY});

class Thumbnail {
  String path;
  String extension;

  Thumbnail({
    required this.path,
    required this.extension,
  });

  Thumbnail copyWith({
    String? path,
    String? extension,
  }) =>
      Thumbnail(
        path: path ?? this.path,
        extension: extension ?? this.extension,
      );

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        path: json["path"],
        extension: json["extension"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "extension": extension,
      };
}

class Url {
  String type;
  String url;

  Url({
    required this.type,
    required this.url,
  });

  Url copyWith({
    String? type,
    String? url,
  }) =>
      Url(
        type: type ?? this.type,
        url: url ?? this.url,
      );

  factory Url.fromJson(Map<String, dynamic> json) => Url(
        type: json["type"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "url": url,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
