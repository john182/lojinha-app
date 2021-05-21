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
}
