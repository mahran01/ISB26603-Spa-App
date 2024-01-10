import 'package:spa_app/models/treatment.dart';

class AssignValue {
  static final List<Treatment> treatment = [
    Treatment(
      name: "Acne treatment",
      imageUrl: "images/acne.jpg",
      price: "RM 100",
      description:
          "We understand that Acne can be sensitive, so we offer a variety of treatments to suit your individual needs and skin type.",
    ),
    Treatment(
      name: "Pigmentation & uneven skin tone treatment",
      imageUrl: "images/pigmentation.jpg",
      price: "RM 250",
      description:
          "We understand that Pigmentation & uneven skin tone treatment can be sensitive, so we offer a variety of treatments to suit your individual needs and skin type.",
    ),
    Treatment(
      name: "Dark circle & eye bag",
      imageUrl: "images/eyebag.webp",
      price: "RM 100",
      description:
          "We understand that Dark circle & eye bag can be sensitive, so we offer a variety of treatments to suit your individual needs and skin type.",
    ),
    Treatment(
      name: "Birthmark & moles",
      imageUrl: "images/moles.jpg",
      price: "RM 100",
      description:
          "We understand that Birthmark & moles can be sensitive, so we offer a variety of treatments to suit your individual needs and skin type.",
    ),
  ];
}
