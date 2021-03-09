class MedicineDetailModel {
  String medicineName, medicineType, medicineMethod;
  int morningQuantity,
      noonQuantity,
      afternoonQuantity,
      totalQuantity,
      medicineId;

  MedicineDetailModel(
      {this.afternoonQuantity,
      this.medicineId,
      this.medicineMethod,
      this.medicineType,
      this.morningQuantity,
      this.noonQuantity,
      this.totalQuantity,
      this.medicineName});

  Map<String, dynamic> toJson() => {
        "medicineId": medicineId,
        "morningQuantity": morningQuantity,
        "method": medicineMethod,
        "noonQuantity": noonQuantity,
        "totalQuantity": totalQuantity,
        "afternoonQuantity": afternoonQuantity,
        "type": medicineType,
      };
}
