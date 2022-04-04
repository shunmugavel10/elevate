// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

CustomerModel customerModelFromJson(String str) => CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel {
    CustomerModel({
        this.count,
        this.value,
        this.error,
        this.info,
    });

    int count;
    Value value;
    dynamic error;
    dynamic info;

    factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        count: json["count"],
        value: json["value"] == null ? null : Value.fromJson(json["value"]),
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

    List<CustomerContent> content;
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
        content: List<CustomerContent>.from(json["content"].map((x) => CustomerContent.fromJson(x))),
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

class CustomerContent {
    CustomerContent({
        this.id,
        this.adminData,
        this.name,
        this.contacts,
        this.thumbnail,
        this.billingAddress,
        this.shippingAddress,
        this.bankDetails,
        this.notes,
        this.deliveryInstructions,
        this.addresses,
        this.type,
        this.kycStatus,
        this.onlineStatus,
        this.bankAccount,
        this.media,
    });

    String id;
    AdminData adminData;
    Name name;
    dynamic contacts;
    Thumbnail thumbnail;
    IngAddress billingAddress;
    IngAddress shippingAddress;
    BankDetails bankDetails;
    DeliveryInstructions notes;
    DeliveryInstructions deliveryInstructions;
    dynamic addresses;
    String type;
    dynamic kycStatus;
    dynamic onlineStatus;
    dynamic bankAccount;
    dynamic media;

    factory CustomerContent.fromJson(Map<String, dynamic> json) => CustomerContent(
        id: json["id"],
        adminData: AdminData.fromJson(json["adminData"]  == null ? null : json["adminData"]),
        name: Name.fromJson(json["name"]),
        contacts: json["contacts"],
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        billingAddress: IngAddress.fromJson(json["billingAddress"]),
        shippingAddress: IngAddress.fromJson(json["shippingAddress"]),
        bankDetails: BankDetails.fromJson(json["bankDetails"]),
        notes: DeliveryInstructions.fromJson(json["notes"]),
        deliveryInstructions: DeliveryInstructions.fromJson(json["deliveryInstructions"]),
        addresses: json["addresses"],
        type: json["type"],
        kycStatus: json["kycStatus"],
        onlineStatus: json["onlineStatus"],
        bankAccount: json["bankAccount"],
        media: json["media"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "adminData": adminData.toJson(),
        "name": name.toJson(),
        "contacts": contacts,
        "thumbnail": thumbnail.toJson(),
        "billingAddress": billingAddress.toJson(),
        "shippingAddress": shippingAddress.toJson(),
        "bankDetails": bankDetails.toJson(),
        "notes": notes.toJson(),
        "deliveryInstructions": deliveryInstructions.toJson(),
        "addresses": addresses,
        "type": type,
        "kycStatus": kycStatus,
        "onlineStatus": onlineStatus,
        "bankAccount": bankAccount,
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

class BankDetails {
    BankDetails({
        this.routingNumber,
        this.accountNumber,
        this.type,
        this.directDeposit,
    });

    String routingNumber;
    String accountNumber;
    String type;
    bool directDeposit;

    factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
        routingNumber: json["routingNumber"],
        accountNumber: json["accountNumber"],
        type: json["type"],
        directDeposit: json["directDeposit"],
    );

    Map<String, dynamic> toJson() => {
        "routingNumber": routingNumber,
        "accountNumber": accountNumber,
        "type": type,
        "directDeposit": directDeposit,
    };
}

class IngAddress {
    IngAddress({
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

    dynamic name;
    Name street;
    Name city;
    Name state;
    DeliveryInstructions country;
    String pincode;
    dynamic notes;
    dynamic village;
    dynamic mandal;
    dynamic district;
    double latitude;
    double longitude;
    Name type;
    dynamic title;
    dynamic location;

    factory IngAddress.fromJson(Map<String, dynamic> json) => IngAddress(
        name: json["name"],
        street: Name.fromJson(json["street"]),
        city: Name.fromJson(json["city"]),
        state: Name.fromJson(json["state"]),
        country: DeliveryInstructions.fromJson(json["country"]),
        pincode: json["pincode"],
        notes: json["notes"],
        village: json["village"],
        mandal: json["mandal"],
        district: json["district"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        type: Name.fromJson(json["type"]),
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
        "notes": notes,
        "village": village,
        "mandal": mandal,
        "district": district,
        "latitude": latitude,
        "longitude": longitude,
        "type": type.toJson(),
        "title": title,
        "location": location,
    };
}

class Name {
    Name({
        this.english,
    });

    String english;

    factory Name.fromJson(Map<String, dynamic> json) => Name(
        english: json["english"],
    );

    Map<String, dynamic> toJson() => {
        "english": english,
    };
}

class DeliveryInstructions {
    DeliveryInstructions();

    factory DeliveryInstructions.fromJson(Map<String, dynamic> json) => DeliveryInstructions(
    );

    Map<String, dynamic> toJson() => {
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
