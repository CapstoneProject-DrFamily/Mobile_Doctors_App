import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/home_page_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/landing_page_view_model.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<LandingPageViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          extendBody: true,
          // resizeToAvoidBottomInset: false,
          // resizeToAvoidBottomPadding: false,
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: model.pageController,
            children: [
              model.page[0],
              model.page[1],
              model.page[2],
              model.page[3],
            ],
          ),

          bottomNavigationBar: BottomNavyBar(
            selectedIndex: model.currentIndex,
            showElevation: true,
            onItemSelected: (index) {
              if (HomePageViewModel.checkStatus) {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.error,
                  text: "You have to Disconnect first!",
                  backgroundColor: Colors.lightBlue[200],
                );
              } else {
                model.changeTab(index);
                model.pageController.jumpToPage(index);
              }
            },
            items: [
              model.listItem[0],
              model.listItem[1],
              model.listItem[2],
              model.listItem[3],
            ],
          ),
        );
      },
    );
  }
}
