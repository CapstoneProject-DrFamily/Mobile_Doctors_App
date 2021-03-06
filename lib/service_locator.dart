import 'package:get_it/get_it.dart';
import 'package:mobile_doctors_apps/screens/view_model/add_time_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/health_record_page_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/list_old_health_record_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/medical_care_history_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/medical_care_patient_history_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/old_health_record_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/patient_base_transaction_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/patient_transaction_detail_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/patient_transaction_form_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/patient_transaction_prescription_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/policy_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/popup_info_patient_page.dart';
import 'package:mobile_doctors_apps/screens/view_model/schedule_page_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/timeline_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/analyze_page_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/diagnose_page_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/home_page_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/landing_page_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/medicine_detail_form_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/medicine_form_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/medicine_list_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/medicine_search_page_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/patient_detail_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/profile_page_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/sample_page_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/sample_pop_up_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/setting_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/sign_in_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/sign_up_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/transaction_detail_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/verify_otp_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/waiting_sample_view_model.dart';

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
  locator.registerFactory<SamplePopUpViewModel>(() => SamplePopUpViewModel());
  locator.registerFactory<DiagnosePageViewModel>(() => DiagnosePageViewModel());
  locator.registerFactory<ProfilePageViewModel>(() => ProfilePageViewModel());
  locator.registerFactory<SettingViewModel>(() => SettingViewModel());
  locator.registerFactory<SignUpViewModel>(() => SignUpViewModel());
  locator.registerFactory<TimeLineViewModel>(() => TimeLineViewModel());
  // locator.registerFactory<MapPageViewModel>(() => MapPageViewModel());
  locator.registerFactory<MedicineSearchPageViewModel>(
      () => MedicineSearchPageViewModel());
  locator.registerFactory<MedicineDetailFormViewModel>(
      () => MedicineDetailFormViewModel());
  locator.registerFactory<TransactionDetailViewModel>(
      () => TransactionDetailViewModel());
  locator.registerFactory<MedicalCareHistoryViewModel>(
      () => MedicalCareHistoryViewModel());
  locator.registerFactory<SchedulePageViewModel>(() => SchedulePageViewModel());
  locator.registerFactory<PopupInfoPatientPage>(() => PopupInfoPatientPage());
  locator.registerFactory<HealthRecordViewModel>(() => HealthRecordViewModel());
  locator.registerFactory<TransactionBaseViewModel>(
      () => TransactionBaseViewModel());
  locator.registerFactory<TransactionPrescriptionViewModel>(
      () => TransactionPrescriptionViewModel());
  locator.registerFactory<PatientTransactionDetailViewModel>(
      () => PatientTransactionDetailViewModel());
  locator.registerFactory<PatientTransactionFormViewModel>(
      () => PatientTransactionFormViewModel());
  locator.registerFactory<AddTimeViewModel>(() => AddTimeViewModel());
  locator.registerFactory<MedicalCarePatientHistoryViewModel>(
      () => MedicalCarePatientHistoryViewModel());
  locator.registerFactory<PolicyViewModel>(() => PolicyViewModel());
  locator
      .registerFactory<WaitingSampleViewModel>(() => WaitingSampleViewModel());
  locator.registerFactory<OldHealthRecordViewModel>(
      () => OldHealthRecordViewModel());
  locator.registerFactory<ListOldHealthRecordViewModel>(
      () => ListOldHealthRecordViewModel());
}
