import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/model/transaction_history_model.dart';
import 'package:mobile_doctors_apps/repository/transaction_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/share/patient_transaction/patient_base_transaction.dart';

class MedicalCarePatientHistoryViewModel extends BaseModel {
  final ITransactionRepo transactionRepo = TransactionRepo();

  int _status = 0;
  int get status => _status;

  bool _isFirst = true;
  bool get isFirst => _isFirst;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _loadingList = false;
  bool get loadingList => _loadingList;

  bool _isNotHave = false;
  bool get isNotHave => _isNotHave;

  List<TransactionHistoryModel> _listTransaction = [];
  List<TransactionHistoryModel> get listTransaction => _listTransaction;

  Future<void> initHistory(int patientId) async {
    if (_isFirst) {
      _isNotHave = false;

      _listTransaction =
          await transactionRepo.getListPatientRecord(patientId, 3);

      if (_listTransaction == null) {
        _isNotHave = true;
      }

      _isLoading = false;
      _isFirst = false;
      notifyListeners();
    }
  }

  void chooseTransaction(BuildContext context, String transactionId,
      int transactionStatus, int patientId) async {
    switch (transactionStatus) {
      case 3:
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PatientBaseTransaction(transactionId: transactionId),
            ),
          ).then((value) async {
            _status = 0;
            _isFirst = true;
            print('init4 $_isFirst');
            await initHistory(patientId);
          });
        }
        break;
      default:
    }
  }
}
