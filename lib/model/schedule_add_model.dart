class ScheduleAddModel {
  int doctorId;
  bool status, disable;
  String insBy, appointmentTime, scheduleId;

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
}
