class ScheduleModel {
  String appointmentTime, updDatetime, updBy;
  bool status;
  int scheduleId;

  ScheduleModel(
      {this.appointmentTime,
      this.scheduleId,
      this.status,
      this.updDatetime,
      this.updBy});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      scheduleId: json['scheduleId'] as int,
      appointmentTime: json['appointmentTime'] as String,
      status: json['status'] as bool,
      updDatetime: json['updDatetime'] as String,
      updBy: json['updBy'] as String,
    );
  }
}
