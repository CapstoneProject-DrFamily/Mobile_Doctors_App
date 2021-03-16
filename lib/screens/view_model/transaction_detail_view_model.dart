import 'package:mobile_doctors_apps/model/profile/profile_model.dart';
import 'package:mobile_doctors_apps/model/service/service_model.dart';
import 'package:mobile_doctors_apps/model/symptom/symptom_model.dart';
import 'package:mobile_doctors_apps/model/transaction.dart';
import 'package:mobile_doctors_apps/repository/transaction_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class TransactionDetailViewModel extends BaseModel {
  final ITransactionRepo _transactionRepo = TransactionRepo();
  bool init = true;
  Transaction transaction;
  ProfileModel profileUser;
  ServiceModel service;
  List<SymptomModel> listSymp;

  Future<void> fetchData(String transactionId) async {
    if (this.init) {
      print(transactionId);
      List<dynamic> result =
          await _transactionRepo.getTransactionHistory(transactionId);
      if (result != null) {
        transaction = result[0];
        profileUser = result[1];
        service = result[2];
        listSymp = result[3];
      }
      this.init = false;
      notifyListeners();
    }
  }
}
