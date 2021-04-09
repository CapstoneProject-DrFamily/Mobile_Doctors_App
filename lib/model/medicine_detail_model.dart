class MedicineDetailModel {
  String medicineName, medicineType, medicineMethod;
  int morningQuantity,
      noonQuantity,
      afternoonQuantity,
      totalQuantity,
      medicineId,
      totalDays;

  MedicineDetailModel(
      {this.afternoonQuantity,
      this.medicineId,
      this.medicineMethod,
      this.medicineType,
      this.morningQuantity,
      this.noonQuantity,
      this.totalQuantity,
      this.medicineName,
      this.totalDays});

  Map<String, dynamic> toJson() => {
        "medicineId": medicineId,
        "morningQuantity": morningQuantity,
        "method": medicineMethod,
        "noonQuantity": noonQuantity,
        "totalQuantity": totalQuantity,
        "afternoonQuantity": afternoonQuantity,
        "type": medicineType,
        "totalDays": totalDays,
      };

  factory MedicineDetailModel.fromJson(Map<String, dynamic> json) {
    return MedicineDetailModel(
        medicineId: json['medicine']['medicineId'] as int,
        morningQuantity: json['morningQuantity'] as int,
        medicineMethod: json['method'] as String,
        noonQuantity: json['noonQuantity'] as int,
        totalQuantity: json['totalQuantity'] as int,
        afternoonQuantity: json['afternoonQuantity'] as int,
        medicineType: json['type'] as String,
        totalDays: json['totalDays'] as int,
        medicineName: json['medicine']['name'] as String);
  }
}
