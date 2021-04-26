import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_doctors_apps/helper/app_image.dart';
import 'package:mobile_doctors_apps/helper/common.dart';
import 'package:mobile_doctors_apps/screens/history/medical_record_patient_page.dart';
import 'package:mobile_doctors_apps/screens/share/health_record_page.dart';
import 'package:mobile_doctors_apps/screens/share/popup_info_patient_page.dart';
import 'package:mobile_doctors_apps/screens/view_model/map_page_view_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key, this.model}) : super(key: key);
  final MapPageViewModel model;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MapPageViewModel>(
      model: widget.model,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: ScopedModelDescendant<MapPageViewModel>(
          builder: (context, child, model) {
            if (model.isLoading == true) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            } else
              return Stack(
                children: [
                  SlidingUpPanel(
                    maxHeight: MediaQuery.of(context).size.height * .80,
                    minHeight: model.panelHeightClosed,
                    parallaxEnabled: true,
                    parallaxOffset: .5,
                    body: _buildGoogleMap(model),
                    panelBuilder: (sc) => _panel(sc, context, model),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.0),
                        topRight: Radius.circular(18.0)),
                    onPanelSlide: (double pos) {
                      model.slidePanel(pos, context);
                    },
                  ),
                  // the fab
                  _buildMyLocation(model, context),
                  _buildArrivedButtom(context, model),
                ],
              );
          },
        ),
      ),
    );
  }

  Positioned _buildMyLocation(MapPageViewModel model, BuildContext context) {
    return Positioned(
      right: 20.0,
      bottom: model.fabHeight,
      child: FloatingActionButton(
        child: Icon(
          Icons.gps_fixed,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          model.getCurrentPosition();
        },
        backgroundColor: Colors.white,
      ),
    );
  }

  Positioned _buildArrivedButtom(BuildContext context, MapPageViewModel model) {
    return Positioned(
      left: 0,
      bottom: 0,
      right: 0,
      child: Container(
        height: 75,
        decoration: BoxDecoration(color: Colors.white),
        child: Container(
          margin: EdgeInsets.all(15),
          child: RaisedButton(
            onPressed: () {
              model.btnArrived(context);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "ARRIVED",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  GoogleMap _buildGoogleMap(MapPageViewModel model) {
    return GoogleMap(
      padding: EdgeInsets.only(bottom: model.bottomPadding),
      initialCameraPosition: model.initPosition,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: model.onMapCreated,
      circles: model.circles,
      markers: model.markers,
      polylines: model.polylines,
      // onTap: model.handleTap,
    );
  }

  Widget _panel(
      ScrollController sc, BuildContext context, MapPageViewModel model) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: sc,
        children: <Widget>[
          SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
              ),
            ],
          ),
          SizedBox(
            height: 18.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Booking Infomation",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff374ABE),
                  fontSize: 24.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    model.basicTransaction.patientName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  model.callPhone(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Icon(Icons.call),
                ),
              ),
              InkWell(
                onTap: () {
                  _confirmCancelBookingDialog(context, model);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Icon(
                    EvaIcons.closeCircleOutline,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  model.durationString,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Color(0xff374ABE),
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 18),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Color(0xff374ABE),
                  size: 30,
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      model.basicTransaction.locationName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 36.0,
          ),
          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Patient Image",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xff374ABE),
                    )),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  child: _imageField(context, model),
                )
              ],
            ),
          ),
          SizedBox(
            height: 36.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    PatientDialog().showCustomDialog(
                        context, model.basicTransaction.patientId);
                  },
                  child: _button("Info", EvaIcons.person, Colors.blue)),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HealthRecordScreen(
                          patientId: model.basicTransaction.patientId,
                        ),
                      ),
                    );
                  },
                  child:
                      _button("Health Record", EvaIcons.activity, Colors.red)),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MedicalCarePatientHistory(
                          patientId: model.basicTransaction.patientId,
                        ),
                      ),
                    );
                  },
                  child: _button("History", EvaIcons.clock, Colors.amber)),
            ],
          ),
          SizedBox(
            height: 36,
          ),
          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Service",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xff374ABE),
                    )),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  child: Text(
                    '${model.basicTransaction.serviceName} - ${Common.convertPrice(model.basicTransaction.servicePrice)}',
                    softWrap: true,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 36,
          ),
          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Note",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xff374ABE),
                    )),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  child: Text(
                    (model.basicTransaction.patientNote == null)
                        ? "Nothing"
                        : model.basicTransaction.patientNote,
                    softWrap: true,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 120,
          ),
        ],
      ),
    );
  }

  Future _confirmCancelBookingDialog(
      BuildContext context, MapPageViewModel model) {
    return showDialog(
      context: context,
      builder: (bookingContext) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Icon(
                        Icons.info,
                        color: Colors.red,
                        size: 90,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Confirmation?",
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'avenir',
                          color: Color(0xff0d47a1),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Are you sure want to Cancel this?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'avenir',
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            maxLines: 5,
                            maxLength: 255,
                            onChanged: (value) {
                              model.reasonCancel = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your reason';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter your reason here',
                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                Navigator.pop(bookingContext);
                                model.cancelTransaction();
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: MediaQuery.of(bookingContext).size.width *
                                  0.3,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.blueAccent),
                              ),
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'avenir',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            onTap: () {
                              Navigator.pop(bookingContext);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: MediaQuery.of(bookingContext).size.width *
                                  0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.blueAccent),
                              ),
                              child: Text(
                                "No",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'avenir',
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _button(String label, IconData icon, Color color) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          decoration:
              BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 8.0,
            )
          ]),
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(label),
      ],
    );
  }

  Widget _imageField(BuildContext context, MapPageViewModel model) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: CircleAvatar(
          radius: 50.0,
          backgroundImage: (model.basicTransaction.patientImage == null)
              ? NetworkImage(DEFAULT_IMG)
              : NetworkImage(model.basicTransaction.patientImage),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("change life");
    print("state $state");
    if (state == AppLifecycleState.resumed) {
      widget.model.controller.setMapStyle("[]");
    }
  }
}
