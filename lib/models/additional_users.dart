class AdditionalUserDetails {
  int age;
  double height;
  double weight;
  String gender;
  String weightGoal;

  AdditionalUserDetails({
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
    required this.weightGoal,
  });

  // Factory method to create an instance of AdditionalUserDetails from a map
  factory AdditionalUserDetails.fromMap(Map<String, dynamic> map) {
    return AdditionalUserDetails(
      age: map['age'] ?? 0,
      height: map['height'] ?? 0.0,
      weight: map['weight'] ?? 0.0,
      gender: map['gender'] ?? '',
      weightGoal: map['weightGoal'] ?? '',
    );
  }

  // Convert AdditionalUserDetails instance to a map
  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'height': height,
      'weight': weight,
      'gender': gender,
      'weightGoal': weightGoal,
    };
  }
}
