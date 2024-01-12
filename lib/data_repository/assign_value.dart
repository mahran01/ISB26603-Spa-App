import 'package:spa_app/models/treatment.dart';

class AssignValue {
  static final List<Treatment> treatment = [
    Treatment(
      name: "Acne treatment",
      imageUrl: "images/acne.jpg",
      price: "RM 100",
      description:
          "Clinic-based acne treatment employs a personalized approach, combining topical and oral medications, as well as procedural interventions, to effectively address and manage acne.",
    ),
    Treatment(
      name: "Pigmentation & uneven skin tone treatment",
      imageUrl: "images/pigmentation.jpg",
      price: "RM 250",
      description:
          "Clinic-based treatment for pigmentation and uneven skin tone utilizes advanced procedures, such as chemical peels or laser therapy, alongside targeted skincare regimens, to achieve a smoother and more even complexion.",
    ),
    Treatment(
      name: "Dark circle & eye bag",
      imageUrl: "images/eyebag.webp",
      price: "RM 60",
      description:
          "Clinic-based treatment for dark circles and eye bags involves a range of approaches, including dermal fillers, laser therapy, and specialized skincare, tailored to rejuvenate the under-eye area and diminish signs of fatigue.",
    ),
    Treatment(
      name: "Birthmark & moles",
      imageUrl: "images/moles.jpg",
      price: "RM 80",
      description:
          "Clinic-based treatment for birthmarks and moles incorporates techniques such as laser therapy or surgical removal, aiming to enhance aesthetics and address any potential health concerns under the guidance of a dermatologist or plastic surgeon.",
    ),
  ];
}
