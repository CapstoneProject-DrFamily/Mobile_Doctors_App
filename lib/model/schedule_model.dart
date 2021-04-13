class ScheduleModel {
  String appointmentTime,
      updDatetime,
      updBy,
      transactionId,
      dateStart,
      location,
      note,
      patientName,
      relationship,
      serviceName,
      scheduleId;
  bool scheduleStatus, isOldPatient;
  int patientId, transactionStatus;
  double servicePrice;

  ScheduleModel(
      {this.appointmentTime,
      this.scheduleId,
      this.scheduleStatus,
      this.updDatetime,
      this.updBy,
      this.dateStart,
      this.location,
      this.note,
      this.patientId,
      this.patientName,
      this.relationship,
      this.serviceName,
      this.servicePrice,
      this.transactionId,
      this.transactionStatus,
      this.isOldPatient});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      scheduleId: json['scheduleId'] as String,
      appointmentTime: json['appointmentTime'] as String,
      scheduleStatus: json['status'] as bool,
      updDatetime: json['updDatetime'] as String,
      updBy: json['updBy'] as String,
      transactionId: json['scheduleNavigation']['transactionId'] as String,
      patientId: json['scheduleNavigation']['patientId'] as int,
      dateStart: json['scheduleNavigation']['dateStart'] as String,
      transactionStatus: json['scheduleNavigation']['status'] as int,
      location: json['scheduleNavigation']['location'] as String,
      note: json['scheduleNavigation']['note'] as String,
      patientName: json['scheduleNavigation']['patientName'] as String,
      relationship: json['scheduleNavigation']['relationship'] as String,
      serviceName: json['scheduleNavigation']['serviceName'] as String,
      servicePrice: json['scheduleNavigation']['servicePrice'] as double,
      isOldPatient: json['scheduleNavigation']['isOldPatient'] as bool,
    );
  }
}
