import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:location/location.dart';

class LatLong extends StatefulWidget {
  const LatLong({Key? key}) : super(key: key);

  @override
  State<LatLong> createState() => _LatLongState();
}

class _LatLongState extends State<LatLong> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _latCtrl = TextEditingController();
  final TextEditingController _lonCtrl = TextEditingController();
  final TextEditingController _desCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  double? lat;
  double? lot;
  PermissionStatus? _permissionGranted;
  LocationData? _location;
  final Location location = Location();
  static StreamSubscription<LocationData>? locationSubscription;
  String? _error;
  String? userName;

  GoogleMapController? mapController;
  LatLng? _initialcameraposition;
  Future<void> _myLocation() async {
    _location = await location.getLocation();

    setState(() {
      lat = _location!.latitude;
      lot = _location!.longitude;
    });
    print(lat);
    print(lot);
    // _initialcameraposition = LatLng(_location.latitude, _location.longitude);
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   _location = currentLocation;
    //   _initialcameraposition = LatLng(_location.latitude, _location.longitude);
    // });
  }

  Future<void> _checkPermissions() async {
    final PermissionStatus permissionGrantedResult =
        await location.hasPermission();
    setState(() {
      _permissionGranted = permissionGrantedResult;
      // print("here is my permission " + permissionGrantedResult.toString());
    });
  }

  Future<void> _requestPermission() async {
    if (_permissionGranted == PermissionStatus.granted ||
        _permissionGranted == PermissionStatus.grantedLimited) {
      final PermissionStatus permissionRequestedResult =
          await location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
      if (permissionRequestedResult == PermissionStatus.granted) {
        _myLocation();
      } else {
        // locationDialog();
      }
    } else {
      _initialcameraposition = LatLng(11.566151053634218, 104.88413827054434);
      final PermissionStatus permissionRequestedResult =
          await location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
      if (permissionRequestedResult == PermissionStatus.granted) {
        _myLocation();
      } else {
        // locationDialog();
      }
    }
  }

  @override
  void initState() {
    _checkPermissions();
    _requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 10, right: 20),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Enter this latitude and longtitude"),
          SizedBox(
            height: 5,
          ),
          lat == null
              ? Container()
              : Row(
                  children: [
                    Text(
                      "Latitude : ",
                      textScaleFactor: 1.3,
                    ),
                    SelectableText("$lat",
                        textScaleFactor: 1.3,
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
          SizedBox(
            height: 5,
          ),
          lot == null
              ? Container()
              : Row(
                  children: [
                    Text("Longtitude : "),
                    SelectableText("$lot",
                        textScaleFactor: 1.3,
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
        ],
      ),
    );
    return Container(
      child: Form(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            SizedBox(height: 15),
            TextFormField(
              controller: _latCtrl,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                    borderSide: new BorderSide(
                      width: 1,
                    ),
                  ),
                  isDense: true,
                  labelText: "Latitute "),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Latitute  is required';
                }
                return null;
              },
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: _lonCtrl,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                    borderSide: new BorderSide(
                      width: 1,
                    ),
                  ),
                  isDense: true,
                  labelText: "Longtitute is required"),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Longtitute is required';
                }
                return null;
              },
            ),
            SizedBox(height: 15),
            // SizedBox(height: MediaQuery.of(context).size.height / 5),
            Container(
              margin: EdgeInsets.only(left: 40, right: 40),
              child: standardBtn(
                  title: "Get Location",
                  onTap: () {
                    _latCtrl.text = "lat";
                    _lonCtrl.text = "long";
                    // if (_formKey!.currentState!.validate()) {

                    // }
                  }),
            )
          ],
        ),
      )),
    );
  }
}
