import 'dart:convert';

class Person {
  String firstName;
  String lastName;
  String userName;
  String pictureUrl;
  String streetName;
  int streetNumber;
  int postCode;
  String city;
  Person({
    this.firstName,
    this.lastName,
    this.userName,
    this.pictureUrl,
    this.streetName,
    this.streetNumber,
    this.postCode,
    this.city,
  });

  Person copyWith({
    String firstName,
    String lastName,
    String userName,
    String pictureUrl,
    String streetName,
    int streetNumber,
    int postCode,
    String city,
  }) {
    return Person(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      streetName: streetName ?? this.streetName,
      streetNumber: streetNumber ?? this.streetNumber,
      postCode: postCode ?? this.postCode,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'pictureUrl': pictureUrl,
      'streetName': streetName,
      'streetNumber': streetNumber,
      'postCode': postCode,
      'city': city,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      firstName: map['name']['first'],
      lastName: map['name']['last'],
      userName: map['login']['username'],
      pictureUrl: map['picture']['large'],
      streetName: map['location']['street']['name'],
      streetNumber: map['location']['street']['number'],
      postCode: map['location']['postcode'],
      city: map['location']['city'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Person(firstName: $firstName, lastName: $lastName, userName: $userName, pictureUrl: $pictureUrl, streetName: $streetName, streetNumber: $streetNumber, postCode: $postCode, city: $city)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Person &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.userName == userName &&
        other.pictureUrl == pictureUrl &&
        other.streetName == streetName &&
        other.streetNumber == streetNumber &&
        other.postCode == postCode &&
        other.city == city;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        userName.hashCode ^
        pictureUrl.hashCode ^
        streetName.hashCode ^
        streetNumber.hashCode ^
        postCode.hashCode ^
        city.hashCode;
  }
}
