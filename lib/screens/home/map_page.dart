import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_doctors_apps/screens/view_model/map_page_view_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapPage extends StatelessWidget {
  final MapPageViewModel model;

  MapPage({@required this.model});
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MapPageViewModel>(
      model: model,
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
              model.btnArrived();
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
                  color: Colors.blue,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
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
              Padding(
                padding: EdgeInsets.only(right: 30),
                child: Icon(Icons.call),
              ),
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
                    color: Colors.blueAccent,
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
                  color: Colors.blue,
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
          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Symptoms",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: model.symptomsDisplay.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            model.symptomsDisplay[index].symptomtype,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text(
                            model.symptomsDisplay[index].symptomName,
                            softWrap: true,
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                      ],
                    );
                  },
                ),
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
                    )),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  child: Text(
                    model.basicTransaction.patientNote,
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
          backgroundImage: NetworkImage(model.basicTransaction.patientImage),
        ),
      ),
    );
  }
}
