

// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    CategoryModel({
        this.content,
        this.pageable,
        this.totalPages,
        this.totalElements,
        this.last,
        this.number,
        this.sort,
        this.size,
        this.numberOfElements,
        this.first,
        this.empty,
    });

    List<CategoryContent> content;
    Pageable pageable;
    int totalPages;
    int totalElements;
    bool last;
    int number;
    Sort sort;
    int size;
    int numberOfElements;
    bool first;
    bool empty;

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        content: List<CategoryContent>.from(json["content"].map((x) => CategoryContent.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"]),
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        last: json["last"],
        number: json["number"],
        sort: Sort.fromJson(json["sort"]),
        size: json["size"],
        numberOfElements: json["numberOfElements"],
        first: json["first"],
        empty: json["empty"],
    );

    Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pageable": pageable.toJson(),
        "totalPages": totalPages,
        "totalElements": totalElements,
        "last": last,
        "number": number,
        "sort": sort.toJson(),
        "size": size,
        "numberOfElements": numberOfElements,
        "first": first,
        "empty": empty,
    };
}

class CategoryContent {
   CategoryContent({
        this.id,
        this.adminData,
        this.name,
        this.description,
        this.thumbnail,
        this.imageUrl,
        this.categorySeo,
        this.media,
    });

    String id;
    AdminData adminData;
    Description name;
    Description description;
    Thumbnail thumbnail;
    String imageUrl;
    dynamic categorySeo;
    dynamic media;

    factory CategoryContent.fromJson(Map<String, dynamic> json) => CategoryContent(
        id: json["id"],
        adminData: AdminData.fromJson(json["adminData"]),
        name: Description.fromJson(json["name"]),
        description: Description.fromJson(json["description"]),
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        imageUrl: json["imageUrl"],
        categorySeo: json["categorySEO"],
        media: json["media"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "adminData": adminData.toJson(),
        "name": name.toJson(),
        "description": description.toJson(),
        "thumbnail": thumbnail.toJson(),
        "imageUrl": imageUrl,
        "categorySEO": categorySeo,
        "media": media,
    };
}

class AdminData {
    AdminData({
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
    });

    String createdBy;
    DateTime createdOn;
    String updatedBy;
    DateTime updatedOn;

    factory AdminData.fromJson(Map<String, dynamic> json) => AdminData(
        createdBy: json["createdBy"],
        createdOn: DateTime.parse(json["createdOn"]),
        updatedBy: json["updatedBy"],
        updatedOn: DateTime.parse(json["updatedOn"]),
    );

    Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdOn": createdOn.toIso8601String(),
        "updatedBy": updatedBy,
        "updatedOn": updatedOn.toIso8601String(),
    };
}

class Description {
    Description({
        this.english,
    });

    String english;

    factory Description.fromJson(Map<String, dynamic> json) => Description(
        english: json["english"],
    );

    Map<String, dynamic> toJson() => {
        "english": english,
    };
}

class Thumbnail {
    Thumbnail({
        this.name,
        this.url,
        this.contentType,
        this.images,
        this.videos,
    });

    String name;
    String url;
    dynamic contentType;
    List<String> images;
    List<dynamic> videos;

    factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        name: json["name"],
        url: json["url"],
        contentType: json["contentType"],
        images: List<String>.from(json["images"].map((x) => x)),
        videos: List<dynamic>.from(json["videos"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "contentType": contentType,
        "images": List<dynamic>.from(images.map((x) => x)),
        "videos": List<dynamic>.from(videos.map((x) => x)),
    };
}

class Pageable {
    Pageable({
        this.sort,
        this.offset,
        this.pageNumber,
        this.pageSize,
        this.paged,
        this.unpaged,
    });

    Sort sort;
    int offset;
    int pageNumber;
    int pageSize;
    bool paged;
    bool unpaged;

    factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: Sort.fromJson(json["sort"]),
        offset: json["offset"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        paged: json["paged"],
        unpaged: json["unpaged"],
    );

    Map<String, dynamic> toJson() => {
        "sort": sort.toJson(),
        "offset": offset,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "paged": paged,
        "unpaged": unpaged,
    };
}

class Sort {
    Sort({
        this.sorted,
        this.unsorted,
        this.empty,
    });

    bool sorted;
    bool unsorted;
    bool empty;

    factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        sorted: json["sorted"],
        unsorted: json["unsorted"],
        empty: json["empty"],
    );

    Map<String, dynamic> toJson() => {
        "sorted": sorted,
        "unsorted": unsorted,
        "empty": empty,
    };
}
