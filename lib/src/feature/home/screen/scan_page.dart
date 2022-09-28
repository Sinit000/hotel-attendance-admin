// import 'package:e_learning/src/feature/account/bloc/index.dart';
// import 'package:e_learning/src/shared/widget/error_snackbar.dart';
// import 'package:e_learning/src/shared/widget/loadin_dialog.dart';
// import 'package:flutter/material.dart';
// import 'dart:developer';
// import 'dart:io';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:intl/intl.dart';

// import 'package:flutter/foundation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QRViewExample extends StatefulWidget {
//   final String locationId;
 
//   const QRViewExample({required this.locationId,});

//   @override
//   State<StatefulWidget> createState() => _QRViewExampleState();
// }

// class _QRViewExampleState extends State<QRViewExample> {
//   Barcode? result;
//   QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

//   String location = 'Null, Press Button';
//   String Address = 'search';
//   DateTime? date;
//   DateTime dateNow = DateTime.now();
//   String? checkin;
//   String? data;
//   String? checkinTime;
//   @override
//   void initState() {
//     DateTime now = DateTime.now();
//     String formattedDate = DateFormat('MM/dd/yyyy kk:mm:ss').format(now);
//     // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
//     checkin = formattedDate.toString();
//     super.initState();
//   }

//   Future<Position> _getGeoLocationPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }

//   Future<void> GetAddressFromLatLong(Position position) async {
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     print(placemarks);
//     Placemark place = placemarks[0];
//     Address =
//         '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
//     setState(() {});
//   }

//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     }
//     controller!.resumeCamera();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Checkin"),
//         backgroundColor: Colors.green[700],
//       ),
//       body: BlocListener<AccountBloc, AccountState>(
//         listener: (context, state) {
//           print(state);
//           if (state is AddingCheckin) {
//             // Navigator.pop(context);
//             loadingDialogs(context);
//           }
//           if (state is AddedCheckin) {
//             Navigator.pop(context);
//             Navigator.pop(context);
//             Navigator.pop(context);
//             BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
//             print("success");
//           }
//           if (state is ErrorAddingCheckInOut) {
//             // Navigator.pop(context);
//             Navigator.pop(context);
//             errorSnackBar(text: state.error.toString(), context: context);
//           }
//         },
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Expanded(
//               flex: 4,
//               child: QRView(
//                 key: qrKey,
//                 onQRViewCreated: (QRViewController controller) {
//                   // setState(() {
//                   //   this.controller = controller;
//                   // });
//                   // Retrieve the list of expected values

//                   controller.scannedDataStream.listen((scanData) {
//                     // Navigator.pop(context);
//                     // Navigator.pop(context);

//                     setState(() async {
//                       print("hiiii");
//                       result = scanData;
//                       if (result != null) {
//                         Position position = await _getGeoLocationPosition();
//                         location =
//                             'Lat: ${position.latitude} , Long: ${position.longitude}';
//                         print(" lat ${position.latitude}");
//                         print(" lat ${position.longitude}");

//                         print(checkin);
//                         data = checkin!.substring(0, 10);
//                         checkinTime = checkin!.substring(11, 19);
//                         print(checkinTime);
//                         print(data);
//                         print('location ${widget.locationId}');
                        

//                         BlocProvider.of<AccountBloc>(context)
//                             .add(AddCheckinStarted(
//                                 checkinTime: checkinTime!,
//                                 lat: position.latitude,
//                                 // lat: "11.5567837",
//                                 lon: position.longitude,
//                                 // lon: "104.9088561",
//                                 locationId: widget.locationId,
//                                 // date: data!,
//                                ));
//                       }
//                       print(result);
//                     });
//                   });
//                 },
//                 overlay: QrScannerOverlayShape(
//                     borderColor: Colors.red,
//                     borderRadius: 10,
//                     borderLength: 30,
//                     borderWidth: 10,
//                     cutOutSize: 150.0),
//                 onPermissionSet: (ctrl, p) =>
//                     _onPermissionSet(context, ctrl, p),
//               ),
//             ),
//             // result != null
//             //     ? Container(
//             //         child: Text(result.toString()),
//             //       )
//             //     : Expanded(flex: 4, child: _buildQrView(context)),
//             // result != null
//             //     ? Column(
//             //         children: [
//             //           Padding(
//             //             padding: EdgeInsets.all(8),
//             //             child: Text(
//             //               "Check in Today $checkin ",
//             //               textScaleFactor: 1.4,
//             //               style: TextStyle(
//             //                   color: Colors.green, fontWeight: FontWeight.bold),
//             //             ),
//             //           ),
//             //           Image.asset("assets/icon/qr-code.png"),
//             //           Container(
//             //             // padding: EdgeInsets.all(10),
//             //             margin: EdgeInsets.only(
//             //                 left: 20, right: 20, bottom: 10, top: 10),
//             //             height: 50,
//             //             width: 250,
//             //             child: FlatButton(
//             //                 shape: RoundedRectangleBorder(
//             //                   borderRadius: BorderRadius.circular(20),
//             //                   // side: BorderSide(color: Colors.red)
//             //                 ),
//             //                 color: Colors.green[700],
//             //                 onPressed: () async {
//             //                   // Text(
//             //                   // 'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
//             //                   if (result != null) {
//             //                     print(result!.code);
//             //                   }
//             //                   Position position =
//             //                       await _getGeoLocationPosition();
//             //                   location =
//             //                       'Lat: ${position.latitude} , Long: ${position.longitude}';
//             //                   print(" lat ${position.latitude}");
//             //                   print(" lat ${position.longitude}");

//             //                   print(checkin);
//             //                   data = checkin!.substring(0, 10);
//             //                   checkinTime = checkin!.substring(11, 19);
//             //                   print(checkinTime);
//             //                   print(data);
//             //                   print('location ${widget.locationId}');
//             //                   print(widget.timetableId);

//             //                   BlocProvider.of<AccountBloc>(context)
//             //                       .add(AddCheckinStarted(
//             //                           checkinTime: checkinTime!,
//             //                           lat: position.latitude,
//             //                           // lat: "11.5567837",
//             //                           lon: position.longitude,
//             //                           // lon: "104.9088561",
//             //                           locationId: widget.locationId,
//             //                           date: data!,
//             //                           timetableId: widget.timetableId));
//             //                 },
//             //                 padding: EdgeInsets.symmetric(vertical: 10),
//             //                 child: Text(
//             //                   "Submit",
//             //                   // AppLocalizations.of(context)!.translate("submit")!,
//             //                   textScaleFactor: 1.2,
//             //                   style: TextStyle(color: Colors.white),
//             //                 )),
//             //           )
//             //         ],
//             //       )
//             //     : Text("Scanning"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildQrView(BuildContext context) {
//     // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 150.0
//         : 300.0;
//     // To ensure the Scanner view is properly sizes after rotation
//     // we need to listen for Flutter SizeChanged notification and update controller
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: (QRViewController controller) {
//         setState(() {
//           this.controller = controller;
//         });
//         // Retrieve the list of expected values

//         controller.scannedDataStream.listen((scanData) {
//           // Navigator.pop(context);
//           // Navigator.pop(context);

//           setState(() async {
//             print("hiiii");
//             result = scanData;
//             if (result != null) {
//               Position position = await _getGeoLocationPosition();
//               location =
//                   'Lat: ${position.latitude} , Long: ${position.longitude}';
//               print(" lat ${position.latitude}");
//               print(" lat ${position.longitude}");

//               print(checkin);
//               data = checkin!.substring(0, 10);
//               checkinTime = checkin!.substring(11, 19);
//               print(checkinTime);
//               print(data);
//               print('location ${widget.locationId}');
//               // print(widget.timetableId);

//               BlocProvider.of<AccountBloc>(context).add(AddCheckinStarted(
//                   checkinTime: checkinTime!,
//                   lat: position.latitude,
//                   // lat: "11.5567837",
//                   lon: position.longitude,
//                   // lon: "104.9088561",
//                   locationId: widget.locationId,
//                   // date: data!,
//                   // timetableId: widget.timetableId
//                   ));
//             }
//             print(result);
//           });
//         });
//       },
//       overlay: QrScannerOverlayShape(
//           borderColor: Colors.red,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: 150.0),
//       onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     // Retrieve the list of expected values

//     controller.scannedDataStream.listen((scanData) {
//       // Navigator.pop(context);
//       // Navigator.pop(context);

//       setState(() async {
//         print("hiiii");
//         result = scanData;
//         if (result != null) {
//           Position position = await _getGeoLocationPosition();
//           location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
//           print(" lat ${position.latitude}");
//           print(" lat ${position.longitude}");

//           print(checkin);
//           data = checkin!.substring(0, 10);
//           checkinTime = checkin!.substring(11, 19);
//           print(checkinTime);
//           print(data);
//           print('location ${widget.locationId}');
//           // print(widget.timetableId);

//           BlocProvider.of<AccountBloc>(context).add(AddCheckinStarted(
//               checkinTime: checkinTime!,
//               lat: position.latitude,
//               // lat: "11.5567837",
//               lon: position.longitude,
//               // lon: "104.9088561",
//               locationId: widget.locationId,
//               // date: data!,
//               // timetableId: widget.timetableId
//               ));
//         }
//         print(result);
//       });
//     });
//   }

//   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//     log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//     if (!p) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('no Permission')),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
