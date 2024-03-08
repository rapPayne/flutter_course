// To parse this JSON data, do
//
//     final comicsRequest = comicsRequestFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

ComicsRequest comicsRequestFromJson(String str) =>
    ComicsRequest.fromJson(json.decode(str));

String comicsRequestToJson(ComicsRequest data) => json.encode(data.toJson());

class ComicsRequest {
  int? code;
  String? status;
  String? copyright;
  String? attributionText;
  String? attributionHtml;
  String? etag;
  Data? data;

  ComicsRequest({
    this.code,
    this.status,
    this.copyright,
    this.attributionText,
    this.attributionHtml,
    this.etag,
    this.data,
  });

  ComicsRequest copyWith({
    int? code,
    String? status,
    String? copyright,
    String? attributionText,
    String? attributionHtml,
    String? etag,
    Data? data,
  }) =>
      ComicsRequest(
        code: code ?? this.code,
        status: status ?? this.status,
        copyright: copyright ?? this.copyright,
        attributionText: attributionText ?? this.attributionText,
        attributionHtml: attributionHtml ?? this.attributionHtml,
        etag: etag ?? this.etag,
        data: data ?? this.data,
      );

  factory ComicsRequest.fromJson(Map<String, dynamic> json) => ComicsRequest(
        code: json["code"],
        status: json["status"],
        copyright: json["copyright"],
        attributionText: json["attributionText"],
        attributionHtml: json["attributionHTML"],
        etag: json["etag"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "copyright": copyright,
        "attributionText": attributionText,
        "attributionHTML": attributionHtml,
        "etag": etag,
        "data": data?.toJson(),
      };
}

class Data {
  int? offset;
  int? limit;
  int? total;
  int? count;
  List<Comic>? results;

  Data({
    this.offset,
    this.limit,
    this.total,
    this.count,
    this.results,
  });

  Data copyWith({
    int? offset,
    int? limit,
    int? total,
    int? count,
    List<Comic>? results,
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
        results: json["results"] == null
            ? []
            : List<Comic>.from(json["results"]!.map((x) => Comic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "total": total,
        "count": count,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Comic {
  int? id;
  int? digitalId;
  String? title;
  int? issueNumber;
  String? variantDescription;
  String? description;
  String? modified;
  String? isbn;
  String? upc;
  String? diamondCode;
  String? ean;
  String? issn;
  Format? format;
  int? pageCount;
  List<TextObject>? textObjects;
  String? resourceUri;
  List<Url>? urls;
  Series? series;
  List<Series>? variants;
  List<dynamic>? collections;
  List<dynamic>? collectedIssues;
  List<Date>? dates;
  List<Price>? prices;
  Thumbnail? thumbnail;
  List<Thumbnail>? images;
  Creators? creators;
  Characters? characters;
  Stories? stories;
  Characters? events;

  Comic({
    this.id,
    this.digitalId,
    this.title,
    this.issueNumber,
    this.variantDescription,
    this.description,
    this.modified,
    this.isbn,
    this.upc,
    this.diamondCode,
    this.ean,
    this.issn,
    this.format,
    this.pageCount,
    this.textObjects,
    this.resourceUri,
    this.urls,
    this.series,
    this.variants,
    this.collections,
    this.collectedIssues,
    this.dates,
    this.prices,
    this.thumbnail,
    this.images,
    this.creators,
    this.characters,
    this.stories,
    this.events,
  });

  Comic copyWith({
    int? id,
    int? digitalId,
    String? title,
    int? issueNumber,
    String? variantDescription,
    String? description,
    String? modified,
    String? isbn,
    String? upc,
    String? diamondCode,
    String? ean,
    String? issn,
    Format? format,
    int? pageCount,
    List<TextObject>? textObjects,
    String? resourceUri,
    List<Url>? urls,
    Series? series,
    List<Series>? variants,
    List<dynamic>? collections,
    List<dynamic>? collectedIssues,
    List<Date>? dates,
    List<Price>? prices,
    Thumbnail? thumbnail,
    List<Thumbnail>? images,
    Creators? creators,
    Characters? characters,
    Stories? stories,
    Characters? events,
  }) =>
      Comic(
        id: id ?? this.id,
        digitalId: digitalId ?? this.digitalId,
        title: title ?? this.title,
        issueNumber: issueNumber ?? this.issueNumber,
        variantDescription: variantDescription ?? this.variantDescription,
        description: description ?? this.description,
        modified: modified ?? this.modified,
        isbn: isbn ?? this.isbn,
        upc: upc ?? this.upc,
        diamondCode: diamondCode ?? this.diamondCode,
        ean: ean ?? this.ean,
        issn: issn ?? this.issn,
        format: format ?? this.format,
        pageCount: pageCount ?? this.pageCount,
        textObjects: textObjects ?? this.textObjects,
        resourceUri: resourceUri ?? this.resourceUri,
        urls: urls ?? this.urls,
        series: series ?? this.series,
        variants: variants ?? this.variants,
        collections: collections ?? this.collections,
        collectedIssues: collectedIssues ?? this.collectedIssues,
        dates: dates ?? this.dates,
        prices: prices ?? this.prices,
        thumbnail: thumbnail ?? this.thumbnail,
        images: images ?? this.images,
        creators: creators ?? this.creators,
        characters: characters ?? this.characters,
        stories: stories ?? this.stories,
        events: events ?? this.events,
      );

  factory Comic.fromJson(Map<String, dynamic> json) => Comic(
        id: json["id"],
        digitalId: json["digitalId"],
        title: json["title"],
        issueNumber: json["issueNumber"],
        variantDescription: json["variantDescription"],
        description: json["description"],
        modified: json["modified"],
        isbn: json["isbn"],
        upc: json["upc"],
        diamondCode: json["diamondCode"],
        ean: json["ean"],
        issn: json["issn"],
        format: formatValues.map[json["format"]]!,
        pageCount: json["pageCount"],
        textObjects: json["textObjects"] == null
            ? []
            : List<TextObject>.from(
                json["textObjects"]!.map((x) => TextObject.fromJson(x))),
        resourceUri: json["resourceURI"],
        urls: json["urls"] == null
            ? []
            : List<Url>.from(json["urls"]!.map((x) => Url.fromJson(x))),
        series: json["series"] == null ? null : Series.fromJson(json["series"]),
        variants: json["variants"] == null
            ? []
            : List<Series>.from(
                json["variants"]!.map((x) => Series.fromJson(x))),
        collections: json["collections"] == null
            ? []
            : List<dynamic>.from(json["collections"]!.map((x) => x)),
        collectedIssues: json["collectedIssues"] == null
            ? []
            : List<dynamic>.from(json["collectedIssues"]!.map((x) => x)),
        dates: json["dates"] == null
            ? []
            : List<Date>.from(json["dates"]!.map((x) => Date.fromJson(x))),
        prices: json["prices"] == null
            ? []
            : List<Price>.from(json["prices"]!.map((x) => Price.fromJson(x))),
        thumbnail: json["thumbnail"] == null
            ? null
            : Thumbnail.fromJson(json["thumbnail"]),
        images: json["images"] == null
            ? []
            : List<Thumbnail>.from(
                json["images"]!.map((x) => Thumbnail.fromJson(x))),
        creators: json["creators"] == null
            ? null
            : Creators.fromJson(json["creators"]),
        characters: json["characters"] == null
            ? null
            : Characters.fromJson(json["characters"]),
        stories:
            json["stories"] == null ? null : Stories.fromJson(json["stories"]),
        events:
            json["events"] == null ? null : Characters.fromJson(json["events"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "digitalId": digitalId,
        "title": title,
        "issueNumber": issueNumber,
        "variantDescription": variantDescription,
        "description": description,
        "modified": modified,
        "isbn": isbn,
        "upc": upc,
        "diamondCode": diamondCode,
        "ean": ean,
        "issn": issn,
        "format": formatValues.reverse[format],
        "pageCount": pageCount,
        "textObjects": textObjects == null
            ? []
            : List<dynamic>.from(textObjects!.map((x) => x.toJson())),
        "resourceURI": resourceUri,
        "urls": urls == null
            ? []
            : List<dynamic>.from(urls!.map((x) => x.toJson())),
        "series": series?.toJson(),
        "variants": variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "collections": collections == null
            ? []
            : List<dynamic>.from(collections!.map((x) => x)),
        "collectedIssues": collectedIssues == null
            ? []
            : List<dynamic>.from(collectedIssues!.map((x) => x)),
        "dates": dates == null
            ? []
            : List<dynamic>.from(dates!.map((x) => x.toJson())),
        "prices": prices == null
            ? []
            : List<dynamic>.from(prices!.map((x) => x.toJson())),
        "thumbnail": thumbnail?.toJson(),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "creators": creators?.toJson(),
        "characters": characters?.toJson(),
        "stories": stories?.toJson(),
        "events": events?.toJson(),
      };
}

class Characters {
  int? available;
  String? collectionUri;
  List<Series>? items;
  int? returned;

  Characters({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  Characters copyWith({
    int? available,
    String? collectionUri,
    List<Series>? items,
    int? returned,
  }) =>
      Characters(
        available: available ?? this.available,
        collectionUri: collectionUri ?? this.collectionUri,
        items: items ?? this.items,
        returned: returned ?? this.returned,
      );

  factory Characters.fromJson(Map<String, dynamic> json) => Characters(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: json["items"] == null
            ? []
            : List<Series>.from(json["items"]!.map((x) => Series.fromJson(x))),
        returned: json["returned"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "returned": returned,
      };
}

class Series {
  String? resourceUri;
  String? name;

  Series({
    this.resourceUri,
    this.name,
  });

  Series copyWith({
    String? resourceUri,
    String? name,
  }) =>
      Series(
        resourceUri: resourceUri ?? this.resourceUri,
        name: name ?? this.name,
      );

  factory Series.fromJson(Map<String, dynamic> json) => Series(
        resourceUri: json["resourceURI"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
      };
}

class Creators {
  int? available;
  String? collectionUri;
  List<CreatorsItem>? items;
  int? returned;

  Creators({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  Creators copyWith({
    int? available,
    String? collectionUri,
    List<CreatorsItem>? items,
    int? returned,
  }) =>
      Creators(
        available: available ?? this.available,
        collectionUri: collectionUri ?? this.collectionUri,
        items: items ?? this.items,
        returned: returned ?? this.returned,
      );

  factory Creators.fromJson(Map<String, dynamic> json) => Creators(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: json["items"] == null
            ? []
            : List<CreatorsItem>.from(
                json["items"]!.map((x) => CreatorsItem.fromJson(x))),
        returned: json["returned"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "returned": returned,
      };
}

class CreatorsItem {
  String? resourceUri;
  String? name;
  Role? role;

  CreatorsItem({
    this.resourceUri,
    this.name,
    this.role,
  });

  CreatorsItem copyWith({
    String? resourceUri,
    String? name,
    Role? role,
  }) =>
      CreatorsItem(
        resourceUri: resourceUri ?? this.resourceUri,
        name: name ?? this.name,
        role: role ?? this.role,
      );

  factory CreatorsItem.fromJson(Map<String, dynamic> json) => CreatorsItem(
        resourceUri: json["resourceURI"],
        name: json["name"],
        role: roleValues.map[json["role"]]!,
      );

  Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
        "role": roleValues.reverse[role],
      };
}

enum Role {
  COLORIST,
  COLORIST_COVER,
  EDITOR,
  INKER,
  LETTERER,
  PAINTER_COVER,
  PENCILER,
  PENCILER_COVER,
  PENCILLER_COVER,
  WRITER
}

final roleValues = EnumValues({
  "colorist": Role.COLORIST,
  "colorist (cover)": Role.COLORIST_COVER,
  "editor": Role.EDITOR,
  "inker": Role.INKER,
  "letterer": Role.LETTERER,
  "painter (cover)": Role.PAINTER_COVER,
  "penciler": Role.PENCILER,
  "penciler (cover)": Role.PENCILER_COVER,
  "penciller (cover)": Role.PENCILLER_COVER,
  "writer": Role.WRITER
});

class Date {
  DateType? type;
  String? date;

  Date({
    this.type,
    this.date,
  });

  Date copyWith({
    DateType? type,
    String? date,
  }) =>
      Date(
        type: type ?? this.type,
        date: date ?? this.date,
      );

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        type: dateTypeValues.map[json["type"]]!,
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "type": dateTypeValues.reverse[type],
        "date": date,
      };
}

enum DateType { DIGITAL_PURCHASE_DATE, FOC_DATE, ONSALE_DATE, UNLIMITED_DATE }

final dateTypeValues = EnumValues({
  "digitalPurchaseDate": DateType.DIGITAL_PURCHASE_DATE,
  "focDate": DateType.FOC_DATE,
  "onsaleDate": DateType.ONSALE_DATE,
  "unlimitedDate": DateType.UNLIMITED_DATE
});

enum Format { COMIC, DIGITAL_VERTICAL_COMIC }

final formatValues = EnumValues({
  "Comic": Format.COMIC,
  "Digital Vertical Comic": Format.DIGITAL_VERTICAL_COMIC
});

class Thumbnail {
  String? path;
  Extension? extension;

  Thumbnail({
    this.path,
    this.extension,
  });

  Thumbnail copyWith({
    String? path,
    Extension? extension,
  }) =>
      Thumbnail(
        path: path ?? this.path,
        extension: extension ?? this.extension,
      );

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        path: json["path"],
        extension: extensionValues.map[json["extension"]]!,
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "extension": extensionValues.reverse[extension],
      };
}

enum Extension { JPG }

final extensionValues = EnumValues({"jpg": Extension.JPG});

class Price {
  PriceType? type;
  double? price;

  Price({
    this.type,
    this.price,
  });

  Price copyWith({
    PriceType? type,
    double? price,
  }) =>
      Price(
        type: type ?? this.type,
        price: price ?? this.price,
      );

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        type: priceTypeValues.map[json["type"]]!,
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "type": priceTypeValues.reverse[type],
        "price": price,
      };
}

enum PriceType { PRINT_PRICE }

final priceTypeValues = EnumValues({"printPrice": PriceType.PRINT_PRICE});

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
        items: json["items"] == null
            ? []
            : List<StoriesItem>.from(
                json["items"]!.map((x) => StoriesItem.fromJson(x))),
        returned: json["returned"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "returned": returned,
      };
}

class StoriesItem {
  String? resourceUri;
  String? name;
  ItemType? type;

  StoriesItem({
    this.resourceUri,
    this.name,
    this.type,
  });

  StoriesItem copyWith({
    String? resourceUri,
    String? name,
    ItemType? type,
  }) =>
      StoriesItem(
        resourceUri: resourceUri ?? this.resourceUri,
        name: name ?? this.name,
        type: type ?? this.type,
      );

  factory StoriesItem.fromJson(Map<String, dynamic> json) => StoriesItem(
        resourceUri: json["resourceURI"],
        name: json["name"],
        type: itemTypeValues.map[json["type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
        "type": itemTypeValues.reverse[type],
      };
}

enum ItemType { COVER, INTERIOR_STORY }

final itemTypeValues = EnumValues(
    {"cover": ItemType.COVER, "interiorStory": ItemType.INTERIOR_STORY});

class TextObject {
  TextObjectType? type;
  Language? language;
  String? text;

  TextObject({
    this.type,
    this.language,
    this.text,
  });

  TextObject copyWith({
    TextObjectType? type,
    Language? language,
    String? text,
  }) =>
      TextObject(
        type: type ?? this.type,
        language: language ?? this.language,
        text: text ?? this.text,
      );

  factory TextObject.fromJson(Map<String, dynamic> json) => TextObject(
        type: textObjectTypeValues.map[json["type"]]!,
        language: languageValues.map[json["language"]]!,
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "type": textObjectTypeValues.reverse[type],
        "language": languageValues.reverse[language],
        "text": text,
      };
}

enum Language { EN_US }

final languageValues = EnumValues({"en-us": Language.EN_US});

enum TextObjectType { ISSUE_SOLICIT_TEXT }

final textObjectTypeValues =
    EnumValues({"issue_solicit_text": TextObjectType.ISSUE_SOLICIT_TEXT});

class Url {
  UrlType? type;
  String? url;

  Url({
    this.type,
    this.url,
  });

  Url copyWith({
    UrlType? type,
    String? url,
  }) =>
      Url(
        type: type ?? this.type,
        url: url ?? this.url,
      );

  factory Url.fromJson(Map<String, dynamic> json) => Url(
        type: urlTypeValues.map[json["type"]]!,
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "type": urlTypeValues.reverse[type],
        "url": url,
      };
}

enum UrlType { DETAIL, PURCHASE, READER }

final urlTypeValues = EnumValues({
  "detail": UrlType.DETAIL,
  "purchase": UrlType.PURCHASE,
  "reader": UrlType.READER
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
