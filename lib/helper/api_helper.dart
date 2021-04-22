class APIHelper {
  static const String URI_PREFIX_API = "capstoneapi-dev.azurewebsites.net";
  static const String Prefix_API = "https://capstoneapi-dev.azurewebsites.net";
  static const String LOGIN_API = '$Prefix_API/api/v1/Auth/OTP';
  static const String DOCTOR_SIMPLEINFO_API = '$Prefix_API/api/v1/Auth/OTP';
  static const String SPECIALTY_API = '$Prefix_API/api/v1/Specialties';
  static const String CREATE_PROFILE_API = '$Prefix_API/api/v1/Profiles';
  static const String UPDATE_USER_API = '$Prefix_API/api/v1/Users';
  static const String CREATE_DOCTOR_API = '$Prefix_API/api/v1/Doctors';
  static const String TRANSACTION_API = '$Prefix_API/api/v1/Transactions';
  static const String MEDICINE_API = '$Prefix_API/api/v1/Medicines';
  static const String EXAMINATIONHISTORY_API =
      '$Prefix_API/api/v1/ExaminationHistory';
  static const String PRESCRIPTION_API = '$Prefix_API/api/v1/Presciptions';
  static const String TRANSACTION_DOCTOR_API =
      '$Prefix_API/api/v1/Transactions/doctors/';
  static const String SCHEDULE_API = '$Prefix_API/api/v1/Schedules';
  static const String PATIENT_API = '$Prefix_API/api/v1/Patients';
  static const String FEEDBACK_API = '$Prefix_API/api/v1/Feedbacks';
  static const String GET_HEALTHRECORD_BY_ID_API =
      '$Prefix_API/api/v1/HealthRecords';
  static const String TRANSACTION_PATIENT_API =
      '$Prefix_API/api/v1/Transactions/patients/';
  static const String APP_CONFIG = '$Prefix_API/api/v1/AppConfigs/2';
  static const String DISEASE_API = "$Prefix_API/api/v1/Diseases";
}
