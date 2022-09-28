// import 'package:e_learning/src/feature/ot_compesation/bloc/index.dart';
// import 'package:e_learning/src/feature/ot_compesation/model/ot_compesation_model.dart';
// import 'package:e_learning/src/shared/widget/custome_modal.dart';
// import 'package:e_learning/src/shared/widget/error_snackbar.dart';
// import 'package:e_learning/src/shared/widget/standard_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:intl/intl.dart';

// import '../../../../appLocalizations.dart';
// import 'ot_comesation_page.dart';

// class EditOtCompesation extends StatefulWidget {
//   final OTCompesationModel otCompesationModel;
//   const EditOtCompesation({required this.otCompesationModel});

//   @override
//   State<EditOtCompesation> createState() => _EditOtCompesationState();
// }

// class _EditOtCompesationState extends State<EditOtCompesation> {
//   final TextEditingController _typeCtrl = TextEditingController();
//   final TextEditingController _fromCtrl = TextEditingController();
//   final TextEditingController _toCtrl = TextEditingController();
//   final TextEditingController _reasonCtrl = TextEditingController();
//   final TextEditingController _numCtrl = TextEditingController();
//   late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();

//   DateTime? date;
//   DateTime dateNow = DateTime.now();
//   TimeOfDay selectedTime = TimeOfDay.now();
//   String? dateToday;
//   @override
//   List<String> typeList = ['hour', 'day'];
//   String? createDate;
//   @override
//   void initState() {
//     DateTime now = DateTime.now();
//     String formattedDate = DateFormat('MM/dd/yyyy').format(now);
//     String creDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
//     createDate = creDate.toString();
//     dateToday = formattedDate.toString();
//     _reasonCtrl.text = widget.otCompesationModel.reason!;
//     _fromCtrl.text = widget.otCompesationModel.fromDate!;
//     _toCtrl.text = widget.otCompesationModel.toDate!;
//     _typeCtrl.text = widget.otCompesationModel.type!;
//     _numCtrl.text = widget.otCompesationModel.duration!;

//     // _numCtrl.text = "0";
//     super.initState();
//   }

//   _dialogDate({required TextEditingController controller}) async {
//     DatePicker.showDatePicker(context,
//             showTitleActions: true,
//             minTime: DateTime(DateTime.now().year - 5),
//             maxTime: DateTime(DateTime.now().year + 60),
//             // minTime: DateTime(2018, 01, 01),
//             // maxTime: DateTime(2030, 01, 01),
//             theme: DatePickerTheme(
//                 // headerColor: Colors.blueGrey,
//                 headerColor: Colors.blue,
//                 backgroundColor: Colors.white,
//                 itemStyle: TextStyle(
//                     color: Colors.black,
//                     // fontWeight: FontWeight.bold,
//                     fontSize: 18),
//                 doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
//             onChanged: (date) {},
//             onConfirm: (date) {},
//             currentTime: DateTime.now(),
//             locale: LocaleType.en)
//         .then((value) {
//       if (value == null) {
//         print("null");
//       } else {
//         setState(() {
//           date = value;
//           String formateDate = DateFormat('yyyy/MM/dd').format(date!);
//           controller.text = formateDate.toString();
//         });
//       }
//     });
//     // DatePicker.showDatePicker(context,
//     //         showTitleActions: true,
//     //         minTime: DateTime(2018, 01, 01),
//     //         maxTime: DateTime(2030, 01, 01),
//     //         theme: DatePickerTheme(
//     //             // headerColor: Colors.blueGrey,
//     //             headerColor: Colors.blue,
//     //             backgroundColor: Colors.white,
//     //             itemStyle: TextStyle(
//     //                 color: Colors.black,
//     //                 // fontWeight: FontWeight.bold,
//     //                 fontSize: 18),
//     //             doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
//     //         onChanged: (date) {},
//     //         onConfirm: (date) {},
//     //         currentTime: DateTime.now(),
//     //         locale: LocaleType.en)
//     //     .then((value) {
//     //   if (value == null) {
//     //     print("null");
//     //   } else {
//     //     setState(() {
//     //       date = value;
//     //       String formateDate = DateFormat('yyyy/MM/dd').format(date!);
//     //       controller.text = formateDate.toString();
//     //     });
//     //   }
//     // });
//     // if (date != null && date != dateNow) {
//     //   setState(() {
//     //     date = dateNow;

//     //     dateInCtrl.text = date.toString();
//     //   });
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: standardAppBar(context,
//           "${AppLocalizations.of(context)!.translate("edit_compesation")!}"),
//       body: Builder(builder: (context) {
//         return BlocListener(
//           bloc: otCompesationBloc,
//           listener: (context, state) {
//             if (state is AddingOTCompesation) {
//               EasyLoading.show(status: 'loading...');
//             }
//             if (state is ErrorAddingOTCompesation) {
//               EasyLoading.dismiss();
//               errorSnackBar(text: state.error.toString(), context: context);
//             }
//             if (state is AddedOTCompesation) {
//               EasyLoading.dismiss();
//               EasyLoading.showSuccess('Success');
//               Navigator.pop(context);
//               print("success");
//             }
//           },
//           child: ListView(
//             children: [
//               Form(
//                 key: _formKey,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                   child: Column(
//                     children: [
//                       // SizedBox(height: 15),
//                       TextFormField(
//                         controller: _typeCtrl,
//                         onTap: () {
//                           customModal(context, typeList, (value) {
//                             _typeCtrl.text = value;
//                             print(value);
//                           });
//                         },

//                         readOnly: true,
//                         // keyboardType: TextInputType.text,
//                         decoration: InputDecoration(
//                             suffixIcon: Icon(Icons.arrow_drop_down),
//                             fillColor: Colors.grey.shade100,
//                             filled: true,
//                             focusedBorder: OutlineInputBorder(
//                                 borderSide: new BorderSide(
//                                     color: Colors.grey.shade400)),
//                             enabledBorder: InputBorder.none,
//                             // isDense: true,
//                             contentPadding: const EdgeInsets.only(
//                               left: 14.0,
//                             ),
//                             labelText:
//                                 "${AppLocalizations.of(context)!.translate("type")!}"),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'type  is required.';
//                           }
//                           return null;
//                         },
//                       ),
//                       // SizedBox(height: 15),
//                       SizedBox(height: 15),
//                       TextFormField(
//                         controller: _reasonCtrl,
//                         keyboardType: TextInputType.text,
//                         maxLines: null,
//                         decoration: InputDecoration(
//                             fillColor: Colors.grey.shade100,
//                             filled: true,
//                             focusedBorder: OutlineInputBorder(
//                                 borderSide: new BorderSide(
//                                     color: Colors.grey.shade400)),
//                             enabledBorder: InputBorder.none,
//                             // isDense: true,
//                             contentPadding: const EdgeInsets.only(
//                               left: 14.0,
//                             ),
//                             labelText:
//                                 "${AppLocalizations.of(context)!.translate("reason")!}"),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Reason is required';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 15),
//                       TextFormField(
//                         controller: _numCtrl,
//                         keyboardType: TextInputType.number,
//                         // keyboardType: TextInputType.multiline,
//                         // minLines: 5,
//                         // maxLines: 20,
//                         decoration: InputDecoration(
//                             fillColor: Colors.grey.shade100,
//                             filled: true,
//                             focusedBorder: OutlineInputBorder(
//                                 borderSide: new BorderSide(
//                                     color: Colors.grey.shade400)),
//                             enabledBorder: InputBorder.none,
//                             // isDense: true,
//                             contentPadding: const EdgeInsets.only(
//                               left: 14.0,
//                             ),
//                             labelText:
//                                 "${AppLocalizations.of(context)!.translate("duration")!}"),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Duration is required.';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 15),
//                       TextFormField(
//                         controller: _fromCtrl,
//                         readOnly: true,
//                         // keyboardType: TextInputType.text,
//                         onTap: () {
//                           _dialogDate(controller: _fromCtrl);
//                         },
//                         decoration: InputDecoration(
//                             prefixIcon: Icon(
//                               Icons.date_range_outlined,
//                               color: Colors.lightBlue,
//                             ),
//                             fillColor: Colors.grey.shade100,
//                             filled: true,
//                             focusedBorder: OutlineInputBorder(
//                                 borderSide: new BorderSide(
//                                     color: Colors.grey.shade400)),
//                             enabledBorder: InputBorder.none,
//                             // isDense: true,
//                             contentPadding: const EdgeInsets.only(
//                               left: 14.0,
//                             ),
//                             labelText:
//                                 "${AppLocalizations.of(context)!.translate("from_date")!}"),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'From date is required';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 15),
//                       TextFormField(
//                         controller: _toCtrl,
//                         // keyboardType: TextInputType.text,
//                         readOnly: true,
//                         onTap: () {
//                           _dialogDate(controller: _toCtrl);
//                         },
//                         decoration: InputDecoration(
//                             prefixIcon: Icon(
//                               Icons.date_range_outlined,
//                               color: Colors.lightBlue,
//                             ),
//                             fillColor: Colors.grey.shade100,
//                             filled: true,
//                             focusedBorder: OutlineInputBorder(
//                                 borderSide: new BorderSide(
//                                     color: Colors.grey.shade400)),
//                             enabledBorder: InputBorder.none,
//                             // isDense: true,
//                             contentPadding: const EdgeInsets.only(
//                               left: 14.0,
//                             ),
//                             labelText:
//                                 "${AppLocalizations.of(context)!.translate("to_date")!}"),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'To Date is required';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 15),
//                       SizedBox(height: MediaQuery.of(context).size.height / 10),
//                       Container(
//                         margin:
//                             EdgeInsets.only(left: 30, right: 30, bottom: 10),
//                         height: 50,
//                         width: double.infinity,
//                         child: FlatButton(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               // side: BorderSide(color: Colors.red)
//                             ),
//                             color: Colors.blue,
//                             onPressed: () {
//                               if (_formKey!.currentState!.validate()) {
//                                 // addessdetail = 11.565271/94.6778 so we need to spilt into lat and long
//                                 otCompesationBloc
//                                     .add(UpdateOTCompesationStarted(
//                                   id: widget.otCompesationModel.id,
//                                   createdDate: createDate!,
//                                   today: dateToday!,
//                                   duration: _numCtrl.text,
//                                   fromDate: _fromCtrl.text,
//                                   toDate: _toCtrl.text,
//                                   reason: _reasonCtrl.text,
//                                   type: _typeCtrl.text,
//                                 ));
//                               }
//                             },
//                             padding: EdgeInsets.symmetric(vertical: 10),
//                             child: Text(
//                               "${AppLocalizations.of(context)!.translate("submit")!}",
//                               // AppLocalizations.of(context)!.translate("submit")!,
//                               textScaleFactor: 1.2,
//                               style: TextStyle(color: Colors.white),
//                             )),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
