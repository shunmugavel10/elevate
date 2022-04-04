// To parse this JSON data, do
//
//     final vendorsModel = vendorsModelFromJson(jsonString);

import 'dart:convert';

VendorsModel vendorsModelFromJson(String str) => VendorsModel.fromJson(json.decode(str));

String vendorsModelToJson(VendorsModel data) => json.encode(data.toJson());

class VendorsModel {
    VendorsModel({
        this.count,
        this.value,
        this.error,
        this.info,
    });

    int count;
    Value value;
    dynamic error;
    dynamic info;

    factory VendorsModel.fromJson(Map<String, dynamic> json) => VendorsModel(
        count: json["count"],
        value: Value.fromJson(json["value"]),
        error: json["error"],
        info: json["info"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "value": value.toJson(),
        "error": error,
        "info": info,
    };
}

class Value {
    Value({
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

    List<VendorContent> content;
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

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        content: List<VendorContent>.from(json["content"].map((x) => VendorContent.fromJson(x))),
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

class VendorContent {
    VendorContent({
        this.id,
        this.adminData,
        this.name,
        this.description,
        this.category,
        this.contacts,
        this.workingHour,
        this.thumbnail,
        this.billingAddress,
        this.shippingAddress,
        this.addresses,
        this.notes,
        this.deliveryInstructions,
        this.kycStatus,
        this.onlineStatus,
        this.bankAccount,
        this.location,
        this.media,
    });

    String id;
    AdminData adminData;
    Category name;
    Category description;
    Category category;
    dynamic contacts;
    WorkingHour workingHour;
    Thumbnail thumbnail;
    dynamic billingAddress;
    dynamic shippingAddress;
    List<Address> addresses;
    dynamic notes;
    dynamic deliveryInstructions;
    dynamic kycStatus;
    dynamic onlineStatus;
    dynamic bankAccount;
    dynamic location;
    dynamic media;

    factory VendorContent.fromJson(Map<String, dynamic> json) => VendorContent(
        id: json["id"],
        adminData: AdminData.fromJson(json["adminData"]),
        name: Category.fromJson(json["name"]),
        description: Category.fromJson(json["description"]),
        category: Category.fromJson(json["category"]),
        contacts: json["contacts"],
        workingHour: WorkingHour.fromJson(json["workingHour"]),
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        billingAddress: json["billingAddress"],
        shippingAddress: json["shippingAddress"],
        addresses: List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
        notes: json["notes"],
        deliveryInstructions: json["deliveryInstructions"],
        kycStatus: json["kycStatus"],
        onlineStatus: json["onlineStatus"],
        bankAccount: json["bankAccount"],
        location: json["location"],
        media: json["media"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "adminData": adminData.toJson(),
        "name": name.toJson(),
        "description": description.toJson(),
        "category": category.toJson(),
        "contacts": contacts,
        "workingHour": workingHour.toJson(),
        "thumbnail": thumbnail.toJson(),
        "billingAddress": billingAddress,
        "shippingAddress": shippingAddress,
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
        "notes": notes,
        "deliveryInstructions": deliveryInstructions,
        "kycStatus": kycStatus,
        "onlineStatus": onlineStatus,
        "bankAccount": bankAccount,
        "location": location,
        "media": media,
    };
}

class Address {
    Address({
        this.name,
        this.street,
        this.city,
        this.state,
        this.country,
        this.pincode,
        this.notes,
        this.village,
        this.mandal,
        this.district,
        this.latitude,
        this.longitude,
        this.type,
        this.title,
        this.location,
    });

    String name;
    Category street;
    Category city;
    Category state;
    Category country;
    String pincode;
    Notes notes;
    Category village;
    Category mandal;
    Category district;
    double latitude;
    double longitude;
    Category type;
    dynamic title;
    dynamic location;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        name: json["name"],
        street: Category.fromJson(json["street"]),
        city: Category.fromJson(json["city"]),
        state: Category.fromJson(json["state"]),
        country: Category.fromJson(json["country"]),
        pincode: json["pincode"],
        notes: json["notes"] == null ? null : Notes.fromJson(json["notes"]),
        village: json["village"] == null ? null : Category.fromJson(json["village"]),
        mandal: json["mandal"] == null ? null : Category.fromJson(json["mandal"]),
        district: json["district"] == null ? null : Category.fromJson(json["district"]),
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        type: Category.fromJson(json["type"]),
        title: json["title"],
        location: json["location"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "street": street.toJson(),
        "city": city.toJson(),
        "state": state.toJson(),
        "country": country.toJson(),
        "pincode": pincode,
        "notes": notes == null ? null : notes.toJson(),
        "village": village == null ? null : village.toJson(),
        "mandal": mandal == null ? null : mandal.toJson(),
        "district": district == null ? null : district.toJson(),
        "latitude": latitude,
        "longitude": longitude,
        "type": type.toJson(),
        "title": title,
        "location": location,
    };
}

class Category {
    Category({
        this.english,
    });

    String english;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        english: json["english"] == null ? null : json["english"],
    );

    Map<String, dynamic> toJson() => {
        "english": english == null ? null : english,
    };
}

class Notes {
    Notes();

    factory Notes.fromJson(Map<String, dynamic> json) => Notes(
    );

    Map<String, dynamic> toJson() => {
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

class WorkingHour {
    WorkingHour({
        this.enUs,
        this.te,
        this.ta,
        this.hi,
        this.ma,
        this.ka,
    });

    List<EnUs> enUs;
    dynamic te;
    dynamic ta;
    dynamic hi;
    dynamic ma;
    dynamic ka;

    factory WorkingHour.fromJson(Map<String, dynamic> json) => WorkingHour(
        enUs: List<EnUs>.from(json["en_US"].map((x) => EnUs.fromJson(x))),
        te: json["te"],
        ta: json["ta"],
        hi: json["hi"],
        ma: json["ma"],
        ka: json["ka"],
    );

    Map<String, dynamic> toJson() => {
        "en_US": List<dynamic>.from(enUs.map((x) => x.toJson())),
        "te": te,
        "ta": ta,
        "hi": hi,
        "ma": ma,
        "ka": ka,
    };
}

class EnUs {
    EnUs({
        this.day,
        this.hours,
    });

    String day;
    Hours hours;

    factory EnUs.fromJson(Map<String, dynamic> json) => EnUs(
        day: json["day"],
        hours: hoursValues.map[json["hours"]],
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "hours": hoursValues.reverse[hours],
    };
}

enum Hours { THE_9_AM_TO_5_PM, THE_138_AM_TO_138_PM }

final hoursValues = EnumValues({
    "1:38 AM to 1:38 PM": Hours.THE_138_AM_TO_138_PM,
    "9 AM to 5 PM": Hours.THE_9_AM_TO_5_PM
});

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

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
