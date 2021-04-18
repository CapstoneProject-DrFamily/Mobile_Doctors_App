import 'package:mobile_doctors_apps/model/transaction_schedule_model.dart';

class ScheduleModel {
  String appointmentTime, updDatetime, updBy;
  bool scheduleStatus;
  int scheduleId;
  TransactionScheduleModel transactionScheduleModel;

  ScheduleModel({
    this.appointmentTime,
    this.scheduleId,
    this.scheduleStatus,
    this.updDatetime,
    this.updBy,
    this.transactionScheduleModel,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      scheduleId: json['scheduleId'] as int,
      appointmentTime: json['appointmentTime'] as String,
      scheduleStatus: json['status'] as bool,
      updDatetime: json['updDatetime'] as String,
      updBy: json['updBy'] as String,
    );
  }
}
