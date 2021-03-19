import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/schedule_page_view_model.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<SchedulePageViewModel>(
      builder: (context, child, model) {
        return FutureBuilder(
          future: model.initScheduleToday(),
          builder: (context, snapshot) {
            if (!model.isFirst) {
              if (model.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    elevation: 0,
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    title: Text(
                      "Your Schedule",
                      style: GoogleFonts.varelaRound(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Color(0xff0d47a1),
                      ),
                    ),
                  ),
                  body: Column(
                    children: [
                      TableCalendar(
                        calendarController: model.calendarController,
                        initialCalendarFormat: CalendarFormat.week,
                        // startingDayOfWeek: StartingDayOfWeek.monday,
                        // formatAnimation: FormatAnimation.slide,
                        // headerStyle: HeaderStyle(
                        //   centerHeaderTitle: true,
                        //   formatButtonVisible: false,
                        //   titleTextStyle:
                        //       TextStyle(color: Colors.white, fontSize: 16),
                        // ),
                      )
                    ],
                  ),
                );
              }
            } else {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        );
      },
    );
  }
}
