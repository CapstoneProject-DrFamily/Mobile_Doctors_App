class ScheduleModel {
  DateTime dateSchedule;
  bool status;
  String transactionId, location, note;
  int patientId;

  ScheduleModel({
    this.dateSchedule,
    this.status,
    this.transactionId,
    this.patientId,
    this.location,
    this.note,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      dateSchedule: json['dateSchedule'] as DateTime,
      status: json['status'] as bool,
      transactionId: json['transactionId'] as String,
      patientId: json['patientId'] as int,
      location: json['location'] as String,
      note: json['note'] as String,
    );
  }
}
