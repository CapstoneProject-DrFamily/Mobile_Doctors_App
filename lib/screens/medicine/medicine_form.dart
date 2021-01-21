import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/medicine_form_view_model.dart';

class MedicineForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseView<MedicineFormViewModel>(
      builder: (context, child, model) {
        return Scaffold(
            backgroundColor: Colors.lightBlue[100],
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    child: Image.asset('assets/medicine.png', fit: BoxFit.fill),
                  ),
                ),
                Expanded(
                  child: MedicineFormDetail(),
                ),
              ],
            ));
      },
    );
  }
}

class MedicineFormDetail extends StatelessWidget {
  const MedicineFormDetail({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          )),
      child: Column(
        children: [
          Text('Name'),
          Text('Paracetamol'),
          RaisedButton(
            child: SvgPicture.asset(
              'assets/icons/pills.svg',
              height: 30,
              width: 30,
            ),
            color: Colors.lightBlue[100],
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ()));
            },
          ),
        ],
      ),
    );
  }
}
