class ScheduleAddModel {
  int doctorId;
  bool status;
  String insBy, appointmentTime;

  ScheduleAddModel(
      {this.appointmentTime, this.doctorId, this.insBy, this.status});

  Map<String, dynamic> toJson() => {
        "doctorId": doctorId,
        "appointmentTime": appointmentTime,
        "status": status,
        "insBy": insBy,
      };
}
