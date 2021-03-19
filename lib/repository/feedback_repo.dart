import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/feedback/feedback_model.dart';

abstract class IFeedbackRepo {
  Future<FeedbackModel> getFeedback(String transactionId);
}

class FeedbackRepo extends IFeedbackRepo {
  @override
  Future<FeedbackModel> getFeedback(String transactionId) async {
    FeedbackModel feedback;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    String urlAPI = APIHelper.URI_PREFIX_API;

    var query = {'SearchValue': '$transactionId'};

    var uri = Uri.http(urlAPI, "/api/v1/Feedbacks/paging", query);

    var response = await http.get(uri, headers: header);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print('data ${data['feedbacks']}');
      var feedback = data['feedbacks'];
      print(feedback.toString());
      if (feedback.toString() == "[]") {
        print("null");
      } else {
        print("else");

        feedback = FeedbackModel.fromJson(data['feedbacks'][0]);
      }
    }

    return feedback;
  }
}
