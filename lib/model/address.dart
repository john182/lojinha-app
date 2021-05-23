class Address {
  String street;
  String number;
  String complement;
  String district;
  String zipCode;
  String city;
  String state;

  double lat;
  double long;

  Address(
      {required this.street,
      required this.number,
      required this.complement,
      required this.district,
      required this.zipCode,
      required this.city,
      required this.state,
      required this.lat,
      required this.long});

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'] as String,
      number: map['number'] as String,
      complement: map['complement'] as String,
      district: map['district'] as String,
      zipCode: map['zipCode'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      lat: map['lat'] as double,
      long: map['long'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'street': street,
      'number': number,
      'complement': complement,
      'district': district,
      'zipCode': zipCode,
      'city': city,
      'state': state,
      'lat': lat,
      'long': long,
    } as Map<String, dynamic>;
  }
}
