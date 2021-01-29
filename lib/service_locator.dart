import 'package:get_it/get_it.dart';
import 'package:mobile_doctors_apps/screens/view_model/analyze_page_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/home_page_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/landing_page_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/medicine_form_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/medicine_list_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/patient_detail_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/sample_page_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/sign_in_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/verify_otp_view_model.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  //Register models
  locator.registerFactory<SignInViewModel>(() => SignInViewModel());
  locator.registerFactory<VerifyOTPViewModel>(() => VerifyOTPViewModel());
  locator.registerFactory<LandingPageViewModel>(() => LandingPageViewModel());
  locator.registerFactory<HomePageViewModel>(() => HomePageViewModel());
  locator.registerFactory<PatientDetailPageViewModel>(
      () => PatientDetailPageViewModel());
  locator.registerFactory<MedicineListViewModel>(() => MedicineListViewModel());
  locator.registerFactory<MedicineFormViewModel>(() => MedicineFormViewModel());
  locator.registerFactory<AnalyzePageViewModel>(() => AnalyzePageViewModel());
  locator.registerFactory<SamplePageViewModel>(() => SamplePageViewModel());
}
