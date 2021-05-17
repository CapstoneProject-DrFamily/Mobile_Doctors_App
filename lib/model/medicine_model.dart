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
      medicineId: json['id'] as int,
      medicineForm: json['form'] as String,
      medicineStrength: json['strength'] as String,
      medicineName: json['name'] as String,
      activeIngredient: json['activeIngredient'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": medicineId,
        "form": medicineForm,
        "strength": medicineStrength,
        "name": medicineName,
        "activeIngredient": activeIngredient,
      };
}

class PagingMedicineModel {
  List<MedicineModel> listMedicine;
  bool hasNextPage;

  PagingMedicineModel({this.hasNextPage, this.listMedicine});
}
