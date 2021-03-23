class ScheduleModel {
  String appointmentTime, updDatetime;
  bool status;
  int scheduleId;

  ScheduleModel(
      {this.appointmentTime, this.scheduleId, this.status, this.updDatetime});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      scheduleId: json['scheduleId'] as int,
      appointmentTime: json['appointmentTime'] as String,
      status: json['status'] as bool,
      updDatetime: json['updDatetime'] as String,
    );
  }
}
