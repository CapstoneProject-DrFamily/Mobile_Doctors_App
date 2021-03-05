class MedicineModel {
  int medicineId;
  String medicineForm, medicineStrength, medicineName, activeIngredient;

  MedicineModel(
      {this.activeIngredient,
      this.medicineForm,
      this.medicineId,
      this.medicineName,
      this.medicineStrength});

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      medicineId: json['medicineId'] as int,
      medicineForm: json['form'] as String,
      medicineStrength: json['pulseRate'] as String,
      medicineName: json['temperature'] as String,
      activeIngredient: json['bloodPressure'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "medicineId": medicineId,
        "form": medicineForm,
        "strength": medicineStrength,
        "name": medicineName,
        "activeIngredient": activeIngredient,
      };
}
