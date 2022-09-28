
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:hotle_attendnce_admin/src/feature/changeDayof/model/changeday_off_model.dart';
// import 'package:hotle_attendnce_admin/src/feature/holiday/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/feature/working_day/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
// // import 'package:date_time_picker/date_time_picker.dart';
// import 'package:intl/intl.dart';

// import '../../../appLocalizations.dart';


// class EditChangeDayoff extends StatefulWidget {
//   final ChangeDayOffModel changeDayOffModel;
//   const EditChangeDayoff({required this.changeDayOffModel});

//   @override
//   State<EditChangeDayoff> createState() => _EditChangeDayoffState();
// }

// class _EditChangeDayoffState extends State<EditChangeDayoff> {
//   WorkingDayBloc _workdayBloc = WorkingDayBloc();
//   HolidayBloc _holidayBloc = HolidayBloc();
//   final TextEditingController _typeCtrl = TextEditingController();
//   final TextEditingController _fromCtrl = TextEditingController();
//   final TextEditingController _toCtrl = TextEditingController();
//   final TextEditingController _reasonCtrl = TextEditingController();
//   final TextEditingController _numCtrl = TextEditingController();
//   late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
//   final TextEditingController? _workdayCtrl = TextEditingController();
//   final TextEditingController? _holidayCtrl = TextEditingController();
//   String select = "";
//   bool isSeclect = false;

//   DateTime? date;
//   DateTime dateNow = DateTime.now();
//   TimeOfDay selectedTime = TimeOfDay.now();
//   String? dateToday;
//   @override
//   List<String> typeList = ['cancel dayoff', 'change dayoff', 'change ph'];
//   @override
//   void initState() {
//     DateTime now = DateTime.now();
//     String formattedDate = DateFormat('yyyy/MM/dd').format(now);
//     // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
//     dateToday = formattedDate.toString();
//     _typeCtrl.text = widget.changeDayOffModel.type!;
//     _reasonCtrl.text = widget.changeDayOffModel.reason!;
//     _fromCtrl.text = widget.changeDayOffModel.fromDate!;
//     _toCtrl.text = widget.changeDayOffModel.toDate!;
//     select = widget.changeDayOffModel.type!;
//     if (widget.changeDayOffModel.holiday != null) {
//       _holidayCtrl!.text =
//           "from ${widget.changeDayOffModel.holiday!.fromDate} to ${widget.changeDayOffModel.holiday!.toDate}";

//       setState(() {
//         isSeclect = true;
//       });
//     }
//     if (widget.changeDayOffModel.workdayModel != null) {
//       _workdayCtrl!.text =
//           "Workday ${widget.changeDayOffModel.workdayModel!.workDay} Offday ${widget.changeDayOffModel.workdayModel!.offDay}";

//       setState(() {
//         isSeclect = true;
//       });
//     }
//     // _numCtrl.text = "0";
//     super.initState();
//   }

//   _dialogDate({required TextEditingController controller}) async {
//     return showDatePicker(
//       context: context,
//       initialDate: dateNow,
//       firstDate: DateTime(DateTime.now().year - 5),
//       lastDate: DateTime(DateTime.now().year + 60),
//     ).then((value) {
//       if (value == null) {
//         print("null");
//       } else {
//         setState(() {
//           date = value;
//           String formateDate = DateFormat('yyyy/MM/dd').format(date!);
//           controller.text = formateDate.toString();
//         });
//       }
//       // after click on date ,
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(widget.changeDayOffModel.holiday);
//     return Scaffold(
//       appBar: standardAppBar(
//           context, "${AppLocalizations.of(context)!.translate("holiday")!}"),
//       body: Builder(builder: (context) {
//         return BlocListener(
//             bloc: changeDayOffBloc,
//             listener: (context, state) {
//               if (state is AddingDayOff) {
//                 EasyLoading.show(status: 'loading...');
//               }
//               if (state is ErrorAddingDayOff) {
//                 EasyLoading.dismiss();
//                 errorSnackBar(text: state.error.toString(), context: context);
//               }
//               if (state is AddedDayOff) {
//                 EasyLoading.dismiss();
//                 EasyLoading.showToast('Success');
//                 Navigator.pop(context);
//                 print("success");
//               }
//             },
//             child: BlocListener(
//               bloc: _workdayBloc,
//               listener: (context, state) {
//                 print(state);
//                 if (state is FetchingWorkingDay) {
//                   EasyLoading.show(status: 'loading...');
//                 }
//                 if (state is ErrorFetchingWorkingDay) {
//                   EasyLoading.dismiss();
//                   errorSnackBar(text: state.error.toString(), context: context);
//                 }
//                 if (state is FetchedWorkingDay) {
//                   EasyLoading.dismiss();
//                   customModal(
//                       context,
//                       _workdayBloc.worklist
//                           .map((e) => "Workday ${e.workDay} Offday ${e.offDay}")
//                           .toList(), (value) {
//                     _workdayCtrl!.text = value;
//                     _holidayCtrl!.clear();
//                     // leaveTypeModel = _subtypeBloc.subtype
//                     //     .firstWhere((e) => e.leaveType == _subtypeCtrl!.text);
//                     // _numCtrl.text = subtypeModel!.duration;
//                   });
//                 }
//               },
//               child: BlocListener(
//                   bloc: _holidayBloc,
//                   listener: (context, state) {
//                     if (state is FetchingHoliday) {
//                       EasyLoading.show(status: 'loading...');
//                     }
//                     if (state is ErrorFetchingHoliday) {
//                       EasyLoading.dismiss();
//                       errorSnackBar(
//                           text: state.error.toString(), context: context);
//                     }
//                     if (state is FetchedHoliday) {
//                       EasyLoading.dismiss();
//                       customModal(
//                           context,
//                           _holidayBloc.holidaylist
//                               .map((e) => "from ${e.fromDate} to ${e.toDate}")
//                               .toList(), (value) {
//                         _holidayCtrl!.text = value;
//                         _workdayCtrl!.clear();
//                       });
//                     }
//                   },
//                   child: ListView(
//                     children: [
//                       Form(
//                         key: _formKey,
//                         child: Container(
//                           margin: EdgeInsets.symmetric(
//                               horizontal: 15, vertical: 15),
//                           child: Column(
//                             children: [
//                               // SizedBox(height: 15),
//                               TextFormField(
//                                 controller: _typeCtrl,
//                                 onTap: () {
//                                   customModal(context, typeList, (value) {
//                                     _typeCtrl.text = value;

//                                     select = value;
//                                     print(select);
//                                     setState(() {
//                                       isSeclect = true;
//                                     });
//                                   });
//                                 },

//                                 readOnly: true,
//                                 // keyboardType: TextInputType.text,
//                                 decoration: InputDecoration(
//                                     suffixIcon: Icon(Icons.arrow_drop_down),
//                                     fillColor: Colors.grey.shade100,
//                                     filled: true,
//                                     focusedBorder: OutlineInputBorder(
//                                         borderSide: new BorderSide(
//                                             color: Colors.grey.shade400)),
//                                     enabledBorder: InputBorder.none,
//                                     // isDense: true,
//                                     contentPadding: const EdgeInsets.only(
//                                       left: 14.0,
//                                     ),
//                                     labelText:
//                                         "${AppLocalizations.of(context)!.translate("type")!}"),
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'type  is required.';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               SizedBox(height: 15),
//                               widget.changeDayOffModel.workdayModel != null &&
//                                       isSeclect == true &&
//                                       select == "change dayoff"
//                                   ? TextFormField(
//                                       controller: _workdayCtrl,
//                                       onTap: () {
//                                         _workdayBloc
//                                             .add(FetchWoringdayStarted());
//                                       },

//                                       readOnly: true,
//                                       // keyboardType: TextInputType.text,
//                                       decoration: InputDecoration(
//                                           suffixIcon:
//                                               Icon(Icons.arrow_drop_down),
//                                           fillColor: Colors.grey.shade100,
//                                           filled: true,
//                                           focusedBorder: OutlineInputBorder(
//                                               borderSide: new BorderSide(
//                                                   color: Colors.grey.shade400)),
//                                           enabledBorder: InputBorder.none,
//                                           // isDense: true,
//                                           contentPadding: const EdgeInsets.only(
//                                             left: 14.0,
//                                           ),
//                                           labelText:
//                                               "${AppLocalizations.of(context)!.translate("workday")!}"),
//                                       validator: (value) {
//                                         if (value!.isEmpty) {
//                                           return 'workday is required.';
//                                         }
//                                         return null;
//                                       },
//                                     )
//                                   : widget.changeDayOffModel.workdayModel ==
//                                               null &&
//                                           isSeclect == true &&
//                                           select == "change dayoff"
//                                       ? TextFormField(
//                                           controller: _workdayCtrl,
//                                           onTap: () {
//                                             _workdayBloc
//                                                 .add(FetchWoringdayStarted());
//                                           },

//                                           readOnly: true,
//                                           // keyboardType: TextInputType.text,
//                                           decoration: InputDecoration(
//                                               suffixIcon:
//                                                   Icon(Icons.arrow_drop_down),
//                                               fillColor: Colors.grey.shade100,
//                                               filled: true,
//                                               focusedBorder: OutlineInputBorder(
//                                                   borderSide: new BorderSide(
//                                                       color: Colors
//                                                           .grey.shade400)),
//                                               enabledBorder: InputBorder.none,
//                                               // isDense: true,
//                                               contentPadding:
//                                                   const EdgeInsets.only(
//                                                 left: 14.0,
//                                               ),
//                                               labelText:
//                                                   "${AppLocalizations.of(context)!.translate("workday")!}"),
//                                           validator: (value) {
//                                             if (value!.isEmpty) {
//                                               return 'workday is required.';
//                                             }
//                                             return null;
//                                           },
//                                         )
//                                       : Container(),
//                               SizedBox(height: 15),
//                               widget.changeDayOffModel.holiday != null &&
//                                       isSeclect == true &&
//                                       select == "change ph"
//                                   ? TextFormField(
//                                       controller: _holidayCtrl,
//                                       onTap: () {
//                                         _holidayBloc.add(FetchHolidayStarted());
//                                       },

//                                       readOnly: true,
//                                       // keyboardType: TextInputType.text,
//                                       decoration: InputDecoration(
//                                           suffixIcon:
//                                               Icon(Icons.arrow_drop_down),
//                                           fillColor: Colors.grey.shade100,
//                                           filled: true,
//                                           focusedBorder: OutlineInputBorder(
//                                               borderSide: new BorderSide(
//                                                   color: Colors.grey.shade400)),
//                                           enabledBorder: InputBorder.none,
//                                           // isDense: true,
//                                           contentPadding: const EdgeInsets.only(
//                                             left: 14.0,
//                                           ),
//                                           labelText:
//                                               "${AppLocalizations.of(context)!.translate("holiday")!}"),
//                                       validator: (value) {
//                                         if (value!.isEmpty) {
//                                           return 'ph is required.';
//                                         }
//                                         return null;
//                                       },
//                                     )
//                                   : widget.changeDayOffModel.holiday == null &&
//                                           isSeclect == true &&
//                                           select == "change ph"
//                                       ? TextFormField(
//                                           controller: _holidayCtrl,
//                                           onTap: () {
//                                             _holidayBloc
//                                                 .add(FetchHolidayStarted());
//                                           },

//                                           readOnly: true,
//                                           // keyboardType: TextInputType.text,
//                                           decoration: InputDecoration(
//                                               suffixIcon:
//                                                   Icon(Icons.arrow_drop_down),
//                                               fillColor: Colors.grey.shade100,
//                                               filled: true,
//                                               focusedBorder: OutlineInputBorder(
//                                                   borderSide: new BorderSide(
//                                                       color: Colors
//                                                           .grey.shade400)),
//                                               enabledBorder: InputBorder.none,
//                                               // isDense: true,
//                                               contentPadding:
//                                                   const EdgeInsets.only(
//                                                 left: 14.0,
//                                               ),
//                                               labelText:
//                                                   "${AppLocalizations.of(context)!.translate("holiday")!}"),
//                                           validator: (value) {
//                                             if (value!.isEmpty) {
//                                               return 'ph is required.';
//                                             }
//                                             return null;
//                                           },
//                                         )
//                                       : Container(),
//                               // SizedBox(height: 15),
//                               SizedBox(height: 15),
//                               TextFormField(
//                                 controller: _reasonCtrl,
//                                 keyboardType: TextInputType.text,
//                                 maxLines: null,
//                                 decoration: InputDecoration(
//                                     fillColor: Colors.grey.shade100,
//                                     filled: true,
//                                     focusedBorder: OutlineInputBorder(
//                                         borderSide: new BorderSide(
//                                             color: Colors.grey.shade400)),
//                                     enabledBorder: InputBorder.none,
//                                     // isDense: true,
//                                     contentPadding: const EdgeInsets.only(
//                                       left: 14.0,
//                                     ),
//                                     labelText:
//                                         "${AppLocalizations.of(context)!.translate("reason")!}"),
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'Reason is required';
//                                   }
//                                   return null;
//                                 },
//                               ),

//                               SizedBox(height: 15),
//                               TextFormField(
//                                 controller: _fromCtrl,
//                                 readOnly: true,
//                                 // keyboardType: TextInputType.text,
//                                 onTap: () {
//                                   _dialogDate(controller: _fromCtrl);
//                                 },
//                                 decoration: InputDecoration(
//                                     prefixIcon: Icon(
//                                       Icons.date_range_outlined,
//                                       color: Colors.lightBlue,
//                                     ),
//                                     fillColor: Colors.grey.shade100,
//                                     filled: true,
//                                     focusedBorder: OutlineInputBorder(
//                                         borderSide: new BorderSide(
//                                             color: Colors.grey.shade400)),
//                                     enabledBorder: InputBorder.none,
//                                     // isDense: true,
//                                     contentPadding: const EdgeInsets.only(
//                                       left: 14.0,
//                                     ),
//                                     labelText:
//                                         "${AppLocalizations.of(context)!.translate("from_date")!}"),
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'From date is required';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               SizedBox(height: 15),
//                               TextFormField(
//                                 controller: _toCtrl,
//                                 // keyboardType: TextInputType.text,
//                                 readOnly: true,
//                                 onTap: () {
//                                   _dialogDate(controller: _toCtrl);
//                                 },
//                                 decoration: InputDecoration(
//                                     prefixIcon: Icon(
//                                       Icons.date_range_outlined,
//                                       color: Colors.lightBlue,
//                                     ),
//                                     fillColor: Colors.grey.shade100,
//                                     filled: true,
//                                     focusedBorder: OutlineInputBorder(
//                                         borderSide: new BorderSide(
//                                             color: Colors.grey.shade400)),
//                                     enabledBorder: InputBorder.none,
//                                     // isDense: true,
//                                     contentPadding: const EdgeInsets.only(
//                                       left: 14.0,
//                                     ),
//                                     labelText:
//                                         "${AppLocalizations.of(context)!.translate("to_date")!}"),
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'To Date is required';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               SizedBox(height: 15),
//                               SizedBox(
//                                   height:
//                                       MediaQuery.of(context).size.height / 10),
//                               Container(
//                                 margin: EdgeInsets.only(
//                                     left: 30, right: 30, bottom: 10),
//                                 height: 50,
//                                 width: double.infinity,
//                                 child: FlatButton(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20),
//                                       // side: BorderSide(color: Colors.red)
//                                     ),
//                                     color: Colors.blue,
//                                     onPressed: () {
//                                       String workdayId = "";
//                                       String holidayId = "";
//                                       if (_formKey!.currentState!.validate()) {
//                                         if (select == "change dayoff") {
//                                           // check workday befor have or not
//                                           if (widget.changeDayOffModel
//                                                   .workdayModel ==
//                                               null) {
//                                             WorkdayModel work = _workdayBloc
//                                                 .worklist
//                                                 .firstWhere((e) =>
//                                                     "Workday ${e.workDay} Offday ${e.offDay}" ==
//                                                     _workdayCtrl!.text);
//                                             workdayId = work.id;
//                                           } else {
//                                             if (_workdayCtrl!.text !=
//                                                 widget.changeDayOffModel
//                                                     .workdayModel!.name) {
//                                               WorkdayModel work = _workdayBloc
//                                                   .worklist
//                                                   .firstWhere((e) =>
//                                                       "Workday ${e.workDay} Offday ${e.offDay}" ==
//                                                       _workdayCtrl!.text);
//                                               workdayId = work.id;
//                                             } else {
//                                               workdayId = widget
//                                                   .changeDayOffModel
//                                                   .workdayModel!
//                                                   .id;
//                                             }
//                                           }
//                                         }
//                                         if (select == "change ph") {
//                                           if (widget
//                                                   .changeDayOffModel.holiday ==
//                                               null) {
//                                             HolidayModel work = _holidayBloc
//                                                 .holidaylist
//                                                 .firstWhere((e) =>
//                                                     "from ${e.fromDate} to ${e.toDate}" ==
//                                                     _holidayCtrl!.text);
//                                             holidayId = work.id;
//                                           } else {
//                                             if (_holidayCtrl!.text !=
//                                                 widget.changeDayOffModel
//                                                     .holiday!.name) {
//                                               HolidayModel work = _holidayBloc
//                                                   .holidaylist
//                                                   .firstWhere((e) =>
//                                                       "from ${e.fromDate} to ${e.toDate}" ==
//                                                       _holidayCtrl!.text);
//                                               holidayId = work.id;
//                                             } else {
//                                               workdayId = widget
//                                                   .changeDayOffModel
//                                                   .holiday!
//                                                   .id;
//                                             }
//                                           }
//                                         }
//                                         changeDayOffBloc
//                                             .add(UpdateDayOffStarted(
//                                           id: widget.changeDayOffModel.id,
//                                           workdayId: workdayId,
//                                           holidayId: holidayId,
//                                           fromDate: _fromCtrl.text,
//                                           toDate: _toCtrl.text,
//                                           reason: _reasonCtrl.text,
//                                           type: _typeCtrl.text,
//                                         ));
//                                         // addessdetail = 11.565271/94.6778 so we need to spilt into lat and long

//                                       }
//                                     },
//                                     padding: EdgeInsets.symmetric(vertical: 10),
//                                     child: Text(
//                                       "${AppLocalizations.of(context)!.translate("submit")!}",
//                                       // AppLocalizations.of(context)!.translate("submit")!,
//                                       textScaleFactor: 1.2,
//                                       style: TextStyle(color: Colors.white),
//                                     )),
//                               )
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   )),
//             ));
//       }),
//     );
//   }
// }
