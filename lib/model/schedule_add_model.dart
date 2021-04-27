class ScheduleAddModel {
  int doctorId, scheduleId;
  bool status, disable;
  String insBy, appointmentTime;

  ScheduleAddModel(
      {this.appointmentTime,
      this.doctorId,
      this.insBy,
      this.status,
      this.scheduleId,
      this.disable});

  Map<String, dynamic> toJson() => {
        "scheduleId": scheduleId,
        "doctorId": doctorId,
        "appointmentTime": appointmentTime,
        "status": status,
        "disabled": disable,
        "insBy": insBy,
      };

  factory ScheduleAddModel.fromJson(Map<String, dynamic> json) {
    return ScheduleAddModel(
      scheduleId: json['scheduleId'] as int,
      doctorId: json['doctorId'] as int,
      appointmentTime: json['appointmentTime'] as String,
      status: json['status'] as bool,
      disable: json['disabled'] as bool,
      insBy: json['insBy'] as String,
    );
  }
}
