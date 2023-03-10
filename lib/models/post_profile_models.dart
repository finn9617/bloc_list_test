// To parse this JSON data, do
//
//     final PostProfileModels = PostProfileModelsFromJson(jsonString);

import 'dart:convert';

PostProfileModels PostProfileModelsFromJson(String str) => PostProfileModels.fromJson(json.decode(str));

String PostProfileModelsToJson(PostProfileModels data) => json.encode(data.toJson());

class PostProfileModels {
    PostProfileModels({
        this.page,
        this.perPage,
        this.total,
        this.totalPages,
        this.data,
        this.support,
    });

    int? page;
    int? perPage;
    int? total;
    int? totalPages;
    List<DatumUser>? data;
    Support? support;

    factory PostProfileModels.fromJson(Map<String, dynamic> json) => PostProfileModels(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: json["data"] == null ? [] : List<DatumUser>.from(json["data"]!.map((x) => DatumUser.fromJson(x))),
        support: json["support"] == null ? null : Support.fromJson(json["support"]),
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "support": support?.toJson(),
    };
}

class DatumUser {
    DatumUser({
        this.id,
        this.email,
        this.firstName,
        this.lastName,
        this.avatar,
    });

    int? id;
    String? email;
    String? firstName;
    String? lastName;
    String? avatar;

    factory DatumUser.fromJson(Map<String, dynamic> json) => DatumUser(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
    };
}

class Support {
    Support({
        this.url,
        this.text,
    });

    String? url;
    String? text;

    factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
    };
}
 