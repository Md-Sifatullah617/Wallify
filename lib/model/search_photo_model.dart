// To parse this JSON data, do
//
//     final searchImageDetailsModel = searchImageDetailsModelFromJson(jsonString);

import 'dart:convert';

SearchImageDetailsModel searchImageDetailsModelFromJson(String str) =>
    SearchImageDetailsModel.fromJson(json.decode(str));

String searchImageDetailsModelToJson(SearchImageDetailsModel data) =>
    json.encode(data.toJson());

class SearchImageDetailsModel {
  final String? kind;
  final Url? url;
  final Queries? queries;
  final Context? context;
  final SearchInformation? searchInformation;
  final List<Item>? items;

  SearchImageDetailsModel({
    this.kind,
    this.url,
    this.queries,
    this.context,
    this.searchInformation,
    this.items,
  });

  factory SearchImageDetailsModel.fromJson(Map<String, dynamic> json) =>
      SearchImageDetailsModel(
        kind: json["kind"],
        url: json["url"] == null ? null : Url.fromJson(json["url"]),
        queries:
            json["queries"] == null ? null : Queries.fromJson(json["queries"]),
        context:
            json["context"] == null ? null : Context.fromJson(json["context"]),
        searchInformation: json["searchInformation"] == null
            ? null
            : SearchInformation.fromJson(json["searchInformation"]),
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "url": url?.toJson(),
        "queries": queries?.toJson(),
        "context": context?.toJson(),
        "searchInformation": searchInformation?.toJson(),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Context {
  final String? title;

  Context({
    this.title,
  });

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
      };
}

class Item {
  final Kind? kind;
  final String? title;
  final String? htmlTitle;
  final String? link;
  final String? displayLink;
  final String? snippet;
  final String? htmlSnippet;
  final FileFormat? mime;
  final FileFormat? fileFormat;
  final Image? image;

  Item({
    this.kind,
    this.title,
    this.htmlTitle,
    this.link,
    this.displayLink,
    this.snippet,
    this.htmlSnippet,
    this.mime,
    this.fileFormat,
    this.image,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        kind: kindValues.map[json["kind"]]!,
        title: json["title"],
        htmlTitle: json["htmlTitle"],
        link: json["link"],
        displayLink: json["displayLink"],
        snippet: json["snippet"],
        htmlSnippet: json["htmlSnippet"],
        mime: fileFormatValues.map[json["mime"]]!,
        fileFormat: fileFormatValues.map[json["fileFormat"]]!,
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "kind": kindValues.reverse[kind],
        "title": title,
        "htmlTitle": htmlTitle,
        "link": link,
        "displayLink": displayLink,
        "snippet": snippet,
        "htmlSnippet": htmlSnippet,
        "mime": fileFormatValues.reverse[mime],
        "fileFormat": fileFormatValues.reverse[fileFormat],
        "image": image?.toJson(),
      };
}

enum FileFormat { IMAGE, IMAGE_JPEG }

final fileFormatValues = EnumValues(
    {"image/": FileFormat.IMAGE, "image/jpeg": FileFormat.IMAGE_JPEG});

class Image {
  final String? contextLink;
  final int? height;
  final int? width;
  final int? byteSize;
  final String? thumbnailLink;
  final int? thumbnailHeight;
  final int? thumbnailWidth;

  Image({
    this.contextLink,
    this.height,
    this.width,
    this.byteSize,
    this.thumbnailLink,
    this.thumbnailHeight,
    this.thumbnailWidth,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        contextLink: json["contextLink"],
        height: json["height"],
        width: json["width"],
        byteSize: json["byteSize"],
        thumbnailLink: json["thumbnailLink"],
        thumbnailHeight: json["thumbnailHeight"],
        thumbnailWidth: json["thumbnailWidth"],
      );

  Map<String, dynamic> toJson() => {
        "contextLink": contextLink,
        "height": height,
        "width": width,
        "byteSize": byteSize,
        "thumbnailLink": thumbnailLink,
        "thumbnailHeight": thumbnailHeight,
        "thumbnailWidth": thumbnailWidth,
      };
}

enum Kind { CUSTOMSEARCH_RESULT }

final kindValues =
    EnumValues({"customsearch#result": Kind.CUSTOMSEARCH_RESULT});

class Queries {
  final List<NextPage>? request;
  final List<NextPage>? nextPage;

  Queries({
    this.request,
    this.nextPage,
  });

  factory Queries.fromJson(Map<String, dynamic> json) => Queries(
        request: json["request"] == null
            ? []
            : List<NextPage>.from(
                json["request"]!.map((x) => NextPage.fromJson(x))),
        nextPage: json["nextPage"] == null
            ? []
            : List<NextPage>.from(
                json["nextPage"]!.map((x) => NextPage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "request": request == null
            ? []
            : List<dynamic>.from(request!.map((x) => x.toJson())),
        "nextPage": nextPage == null
            ? []
            : List<dynamic>.from(nextPage!.map((x) => x.toJson())),
      };
}

class NextPage {
  final String? title;
  final String? totalResults;
  final String? searchTerms;
  final int? count;
  final int? startIndex;
  final String? inputEncoding;
  final String? outputEncoding;
  final String? safe;
  final String? cx;
  final String? searchType;

  NextPage({
    this.title,
    this.totalResults,
    this.searchTerms,
    this.count,
    this.startIndex,
    this.inputEncoding,
    this.outputEncoding,
    this.safe,
    this.cx,
    this.searchType,
  });

  factory NextPage.fromJson(Map<String, dynamic> json) => NextPage(
        title: json["title"],
        totalResults: json["totalResults"],
        searchTerms: json["searchTerms"],
        count: json["count"],
        startIndex: json["startIndex"],
        inputEncoding: json["inputEncoding"],
        outputEncoding: json["outputEncoding"],
        safe: json["safe"],
        cx: json["cx"],
        searchType: json["searchType"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "totalResults": totalResults,
        "searchTerms": searchTerms,
        "count": count,
        "startIndex": startIndex,
        "inputEncoding": inputEncoding,
        "outputEncoding": outputEncoding,
        "safe": safe,
        "cx": cx,
        "searchType": searchType,
      };
}

class SearchInformation {
  final double? searchTime;
  final String? formattedSearchTime;
  final String? totalResults;
  final String? formattedTotalResults;

  SearchInformation({
    this.searchTime,
    this.formattedSearchTime,
    this.totalResults,
    this.formattedTotalResults,
  });

  factory SearchInformation.fromJson(Map<String, dynamic> json) =>
      SearchInformation(
        searchTime: json["searchTime"]?.toDouble(),
        formattedSearchTime: json["formattedSearchTime"],
        totalResults: json["totalResults"],
        formattedTotalResults: json["formattedTotalResults"],
      );

  Map<String, dynamic> toJson() => {
        "searchTime": searchTime,
        "formattedSearchTime": formattedSearchTime,
        "totalResults": totalResults,
        "formattedTotalResults": formattedTotalResults,
      };
}

class Url {
  final String? type;
  final String? template;

  Url({
    this.type,
    this.template,
  });

  factory Url.fromJson(Map<String, dynamic> json) => Url(
        type: json["type"],
        template: json["template"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "template": template,
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
