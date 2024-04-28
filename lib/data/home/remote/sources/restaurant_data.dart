import '../DTOs/restaurant.dart';

class ResturantData {
  Stream getData() {
    return Future(() => [
          ResturantModel(
              email_address: 'email2@thibos.com',
              name: 'Joseph',
              sub_name: "Best Bevs",
              phone_number: '+266 69356845',
              location: "Maseru"),
          ResturantModel(
              location: "Qoaling",
              email_address: 'emaile@thibos.com',
              name: 'Thibos',
              sub_name: "Best food",
              phone_number: '+266 69356845'),
          ResturantModel(
              location: "Quthing",
              email_address: 'email5@bevs.com',
              name: 'Lake Side',
              sub_name: "Best Bevs",
              phone_number: '+266 69356845'),
          ResturantModel(
              location: "Ha Thamae",
              email_address: 'email1@thibos.com',
              name: 'Thibos',
              sub_name: "Best food",
              phone_number: '+266 69356845'),
          ResturantModel(
              location: "T'senola",
              email_address: 'email1@thibos.com',
              name: 'Thibos',
              sub_name: "Best food",
              phone_number: '+266 69356845'),
          ResturantModel(
              location: "Leribe",
              email_address: 'email1@thibos.com',
              name: 'Thibos',
              sub_name: "Best food",
              phone_number: '+266 69356845'),
          ResturantModel(
              location: "Berea",
              email_address: 'email1@thibos.com',
              name: 'Thibos',
              sub_name: "Best food",
              phone_number: '+266 69356845')
        ]).asStream();
  }
}
