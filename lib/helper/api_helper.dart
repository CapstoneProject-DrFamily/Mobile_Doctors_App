class APIHelper {
  //API Prefix
  static const String URI_PREFIX_API = "capstoneapi-dev.azurewebsites.net";
  static const String Prefix_API = "https://capstoneapi-dev.azurewebsites.net";

  //API Authen + Login
  static const String LOGIN_API = '$Prefix_API/api/v1/Auth/OTP';
  static const String DOCTOR_SIMPLEINFO_API = '$Prefix_API/api/v1/Auth/OTP';

  //API Profile
  static const String CREATE_PROFILE_API = '$Prefix_API/api/v1/Profiles';
  static const String UPDATE_USER_API = '$Prefix_API/api/v1/Users';

  //API Doctor
  static const String DOCTOR_API = '$Prefix_API/api/v1/Doctors';

  //API Patient
  static const String PATIENT_API = '$Prefix_API/api/v1/Patients';

  //API Specialty
  static const String SPECIALTY_API = '$Prefix_API/api/v1/Specialties';

  //API Transaction
  static const String TRANSACTION_API = '$Prefix_API/api/v1/Transactions';
  static const String TRANSACTION_DOCTOR_API =
      '$Prefix_API/api/v1/Transactions/doctors/';
  static const String TRANSACTION_PATIENT_API =
      '$Prefix_API/api/v1/Transactions/patients/';

  //API Medicine
  static const String MEDICINE_API = '$Prefix_API/api/v1/Medicines';

  //API Feedback
  static const String FEEDBACK_API = '$Prefix_API/api/v1/Feedbacks';

  //API Schedule
  static const String SCHEDULE_API = '$Prefix_API/api/v1/Schedules';

  //API HealthRecord
  static const String GET_HEALTHRECORD_BY_ID_API =
      '$Prefix_API/api/v1/HealthRecords';

  //API AppConfig
  static const String APP_CONFIG = '$Prefix_API/api/v1/AppConfigs/2';

  //API Disease
  static const String DISEASE_API = "$Prefix_API/api/v1/Diseases";

  //API Prescription
  static const String PRESCRIPTION_API = '$Prefix_API/api/v1/Presciptions';

  //API Examination History
  static const String EXAMINATIONHISTORY_API =
      '$Prefix_API/api/v1/ExaminationHistory';
}
