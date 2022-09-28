// import 'package:hotle_attendnce_admin/src/feature/account/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:intl/intl.dart';

// class CheckinOutPage extends StatefulWidget {
//   final String locationId;
//   final String timetableId;
//   CheckinOutPage({required this.locationId, required this.timetableId});

//   @override
//   _CheckinOutPageState createState() => _CheckinOutPageState();
// }

// class _CheckinOutPageState extends State<CheckinOutPage> {
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

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AccountBloc, AccountState>(
//       listener: (context, state) {
//         if (state is AddingCheckout) {
//           loadingDialogs(context);
//         }
//         if (state is AddedCheckin) {
//           Navigator.pop(context);
//           // Navigator.pop(context);
//           BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
//           print("success");
//         }
//         if (state is ErrorAddingCheckInOut) {
//           Navigator.pop(context);
//           errorSnackBar(text: state.error.toString(), context: context);
//         }
//       },
//       child: InkWell(
//         onTap: () async {
//           Position position = await _getGeoLocationPosition();
//           location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
//           print(position.latitude);
//           print(position.longitude);
//           data = checkin!.substring(0, 10);
//           checkinTime = checkin!.substring(11, 19);
//           print(checkinTime);
//           print(data);
//           BlocProvider.of<AccountBloc>(context).add(AddCheckoutStarted(
//             checkoutTime: checkinTime!,
//             lat: position.latitude.toString(),
//             // lat: "11.5567837",
//             lon: position.longitude.toString(),
//             locationId: widget.locationId,
//             // date: data!,
//             // timetableId: widget.timetableId
//           ));
//           print("sucess");
//         },
//         child: Container(
//           height: 200,
//           width: 200,
//           child: Card(
//             elevation: 2,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//             child: Container(
//                 alignment: Alignment.center,
//                 // color: Colors.red,
//                 child: Image.asset("assets/icon/check (1).png")),
//           ),
//         ),
//       ),
//     );
//   }
// }
