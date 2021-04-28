import 'package:commons/commons.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_doctors_apps/helper/helper_method.dart';
import 'package:mobile_doctors_apps/model/transaction_history_model.dart';
import 'package:mobile_doctors_apps/repository/map_repo.dart';
import 'package:mobile_doctors_apps/repository/transaction_repo.dart';
import 'package:mobile_doctors_apps/screens/history/transaction_detail_page.dart';
import 'package:mobile_doctors_apps/screens/home/map_page.dart';
import 'package:mobile_doctors_apps/screens/share/base_timeline.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/map_page_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicalCareHistoryViewModel extends BaseModel {
  final IMapRepo _mapRepo = MapRepo();
  final ITransactionRepo transactionRepo = TransactionRepo();

  int _doctorId;

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

  List _historyTime = [
    'All',
    'On Going',
    'Checking',
    "Awaiting Payment",
    'Done',
    'Cancel'
  ];
  List get historyTime => _historyTime;

  Future<void> initHistory() async {
    if (_isFirst) {
      _isNotHave = false;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      _doctorId = prefs.getInt("doctorId");
      print("oke" + _doctorId.toString());

      _listTransaction = await transactionRepo.getListTransactionHistory(
          _doctorId.toString(), -1);

      if (_listTransaction == null) {
        _isNotHave = true;
      }

      _isLoading = false;
      _isFirst = false;
      notifyListeners();
    }
  }

  void loadBack() {
    _isFirst = true;
    notifyListeners();
  }

  void changeStatus(int status) async {
    switch (status) {
      case 0:
        {
          _isNotHave = false;

          _loadingList = true;
          _status = status;
          notifyListeners();
          _listTransaction = await transactionRepo.getListTransactionHistory(
              _doctorId.toString(), -1);

          _loadingList = false;
          if (_listTransaction == null) {
            _isNotHave = true;
          }

          notifyListeners();
        }

        break;
      case 1:
        {
          _isNotHave = false;

          _loadingList = true;
          _status = status;
          notifyListeners();
          _listTransaction = await transactionRepo.getListTransactionHistory(
              _doctorId.toString(), 1);
          _loadingList = false;
          if (_listTransaction == null) {
            _isNotHave = true;
          }
          notifyListeners();
        }

        break;
      case 2:
        {
          _isNotHave = false;

          _loadingList = true;
          _status = status;
          notifyListeners();
          _listTransaction = await transactionRepo.getListTransactionHistory(
              _doctorId.toString(), 2);
          _loadingList = false;
          if (_listTransaction == null) {
            _isNotHave = true;
          }

          notifyListeners();
        }

        break;
      case 3:
        {
          _isNotHave = false;

          _loadingList = true;
          _status = status;
          notifyListeners();
          _listTransaction = await transactionRepo.getListTransactionHistory(
              _doctorId.toString(), 5);
          _loadingList = false;

          if (_listTransaction == null) {
            _isNotHave = true;
          }

          notifyListeners();
        }

        break;
      case 4:
        {
          _isNotHave = false;

          _loadingList = true;
          _status = status;
          notifyListeners();
          _listTransaction = await transactionRepo.getListTransactionHistory(
              _doctorId.toString(), 3);
          _loadingList = false;
          if (_listTransaction == null) {
            _isNotHave = true;
          }

          notifyListeners();
        }
        break;
      case 5:
        {
          _isNotHave = false;

          _loadingList = true;
          _status = status;
          notifyListeners();
          _listTransaction = await transactionRepo.getListTransactionHistory(
              _doctorId.toString(), 4);
          _loadingList = false;
          if (_listTransaction == null) {
            _isNotHave = true;
          }

          notifyListeners();
        }
        break;
      default:
    }
  }

  void chooseTransaction(
      BuildContext context, String transactionId, int transactionStatus) async {
    switch (transactionStatus) {
      case 1:
        {
          waitDialog(context, message: "Getting record please wait...");
          print("id Transaction $transactionId");
          var transaction =
              await transactionRepo.getTransactionDetailMap(transactionId);
          if (transaction == null) {
            Navigator.pop(context);
            CoolAlert.show(
                context: context,
                type: CoolAlertType.error,
                text: "Something error!",
                backgroundColor: Colors.lightBlue[200]);
          } else {
            LatLng destinationLocation =
                LatLng(transaction.latitude, transaction.longitude);

            var position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);

            LatLng positionLatLng =
                LatLng(position.latitude, position.longitude);

            var directionDetails = await _mapRepo.getDirectionDetails(
                positionLatLng, destinationLocation);

            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapPage(
                    model: MapPageViewModel(transaction, directionDetails)),
              ),
            ).then((value) async {
              HelperMethod.disableLiveLocationUpdates();
              _status = 0;
              _isFirst = true;
              print('init2 $_isFirst');

              await initHistory();
            });
          }
        }
        break;
      case 2:
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BaseTimeLine(transactionId: transactionId),
            ),
          ).then((value) async {
            _status = 0;
            _isFirst = true;
            print('init3 $_isFirst');
            await initHistory();
          });
        }
        break;
      case 3:
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TransactionDetailPage(transactionId: transactionId),
            ),
          ).then((value) async {
            _status = 0;
            _isFirst = true;
            print('init4 $_isFirst');
            await initHistory();
          });
        }
        break;
      case 4:
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TransactionDetailPage(transactionId: transactionId),
            ),
          ).then((value) async {
            _status = 0;
            _isFirst = true;
            print('init5 $_isFirst');
            await initHistory();
          });
        }
        break;
      case 5:
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TransactionDetailPage(transactionId: transactionId),
            ),
          ).then((value) async {
            _status = 0;
            _isFirst = true;
            print('init5 $_isFirst');
            await initHistory();
          });
        }
        break;
      default:
    }
  }
}
