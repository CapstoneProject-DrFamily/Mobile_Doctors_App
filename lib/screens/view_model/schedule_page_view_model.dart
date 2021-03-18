import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePageViewModel extends BaseModel {
  bool isLoading = true;
  bool isFirst = true;
  bool isNotHave = false;

  CalendarController _calendarController;
  CalendarController get calendarController => _calendarController;
  Future<void> initScheduleToday() async {
    if (isFirst) {
      _calendarController = CalendarController();
      isNotHave = false;

      //init

      isLoading = false;
      isFirst = false;
      notifyListeners();
    }
  }
}
