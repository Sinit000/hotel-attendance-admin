// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
// import 'package:hotle_attendnce_admin/src/feature/payslip/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/feature/payslip/model/payslip_model.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// import '../../../appLocalizations.dart';

// class EditPayslip extends StatefulWidget {
//   final PayslipModel payslipModel;
//   const EditPayslip({required this.payslipModel});

//   @override
//   State<EditPayslip> createState() => _EditPayslipState();
// }

// class _EditPayslipState extends State<EditPayslip> {
//   EmployeeBloc _employeeBloc = EmployeeBloc();
//   final TextEditingController _usrCtrl = TextEditingController();
//   final TextEditingController _fromCtrl = TextEditingController();
//   final TextEditingController _toCtrl = TextEditingController();
//   final TextEditingController _contractId = TextEditingController();
//   final TextEditingController _allowancCtrl = TextEditingController();
//   final TextEditingController _bonusCtrl = TextEditingController();
//   final TextEditingController _seniorityCtrl = TextEditingController();
//   final TextEditingController _advanceCtrl = TextEditingController();
//   final TextEditingController _currencyCtrl = TextEditingController();
//   final TextEditingController _exchangeRate = TextEditingController();
//   final TextEditingController _deductionCtrl = TextEditingController();
//   late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();

//   DateTime? date;
//   DateTime dateNow = DateTime.now();
//   String? dateToday;
//   String id = "";
//   @override
//   void initState() {
//     _usrCtrl.text = widget.payslipModel.userModel!.name;
//     _currencyCtrl.text = widget.payslipModel.currey!;
//     widget.payslipModel.exChangeRate != null
//         ? _exchangeRate.text = ""
//         : _exchangeRate.text = widget.payslipModel.exChangeRate!;
//     _fromCtrl.text = widget.payslipModel.fromDate!;
//     _toCtrl.text = widget.payslipModel.toDate!;
//     //  _b.text = widget.payslipModel.toDate!;
//     widget.payslipModel.allowance != null
//         ? _allowancCtrl.text = ""
//         : _allowancCtrl.text = widget.payslipModel.allowance!;
//     widget.payslipModel.bonus != null
//         ? _bonusCtrl.text = ""
//         : _bonusCtrl.text = widget.payslipModel.bonus!;
//     widget.payslipModel.deduction != null
//         ? _deductionCtrl.text = ""
//         : _deductionCtrl.text = widget.payslipModel.deduction!;
//     widget.payslipModel.advanceMoney != null
//         ? _advanceCtrl.text = ""
//         : _advanceCtrl.text = widget.payslipModel.advanceMoney!;
//     widget.payslipModel.senioritySalary != null
//         ? _seniorityCtrl.text = ""
//         : _seniorityCtrl.text = widget.payslipModel.senioritySalary!;

//     DateTime now = DateTime.now();
//     String formattedDate = DateFormat('yyyy/MM/dd').format(now);
//     // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
//     dateToday = formattedDate.toString();
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
//   }

//   List<String> currency = ["riel", "usd"];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.withOpacity(0.2),
//       appBar: standardAppBar(context,
//           "${AppLocalizations.of(context)!.translate("edit_payslip")!}"),
//       body: Builder(builder: (context) {
//         return BlocListener(
//             bloc: BlocProvider.of<PayslipBloc>(context),
//             listener: (context, state) {
//               if (state is AddingPayslip) {
//                 EasyLoading.show(status: "loading....");
//               }
//               if (state is ErrorAddingPayslip) {
//                 EasyLoading.dismiss();

//                 errorSnackBar(text: state.error.toString(), context: context);
//               }
//               if (state is AddedPayslip) {
//                 EasyLoading.dismiss();
//                 EasyLoading.showSuccess("Success");
//                 Navigator.pop(context);
//               }
//             },
//             child: BlocListener(
//                 bloc: _employeeBloc,
//                 listener: (context, state) {
//                   if (state is FetchingEmployee) {
//                     EasyLoading.show(status: "loading...");
//                   }
//                   if (state is ErrorFetchingEmployee) {
//                     EasyLoading.dismiss();
//                     errorSnackBar(text: state.toString(), context: context);
//                   }
//                   if (state is FetchedEmployee) {
//                     EasyLoading.dismiss();

//                     customModal(
//                         context,
//                         _employeeBloc.emploList
//                             .map((e) => "${e.name}")
//                             .toList(), (value) {
//                       _usrCtrl.text = value;
//                     });
//                   }
//                 },
//                 child: ListView(
//                   children: [
//                     Form(
//                       key: _formKey,
//                       child: Container(
//                         margin:
//                             EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                         child: Column(
//                           children: [
//                             SizedBox(height: 15),
//                             TextFormField(
//                               controller: _currencyCtrl,
//                               onTap: () {
//                                 customModal(context, currency, (value) {
//                                   _currencyCtrl.text = value;
//                                 });
//                               },
//                               readOnly: true,
//                               // keyboardType: TextInputType.text,
//                               decoration: InputDecoration(
//                                   suffixIcon: Icon(Icons.arrow_drop_down),
//                                   contentPadding: const EdgeInsets.only(
//                                     left: 14.0,
//                                   ),
//                                   fillColor: Colors.grey.shade100,
//                                   filled: true,
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide: new BorderSide(
//                                           color: Colors.grey.shade400)),
//                                   labelText:
//                                       "${AppLocalizations.of(context)!.translate("currency")!}"),
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'Currency is required';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(height: 15),
//                             TextFormField(
//                               controller: _exchangeRate,
//                               onTap: () {
//                                 customModal(context, currency, (value) {
//                                   _currencyCtrl.text = value;
//                                 });
//                               },
//                               readOnly: true,
//                               // keyboardType: TextInputType.text,
//                               decoration: InputDecoration(
//                                   suffixIcon: Icon(Icons.arrow_drop_down),
//                                   contentPadding: const EdgeInsets.only(
//                                     left: 14.0,
//                                   ),
//                                   fillColor: Colors.grey.shade100,
//                                   filled: true,
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide: new BorderSide(
//                                           color: Colors.grey.shade400)),
//                                   labelText:
//                                       "${AppLocalizations.of(context)!.translate("exchange_rate")!}"),
//                               // validator: (value) {
//                               //   if (value!.isEmpty) {
//                               //     return 'Currency is required';
//                               //   }
//                               //   return null;
//                               // },
//                             ),
//                             SizedBox(height: 15),
//                             TextFormField(
//                               controller: _usrCtrl,
//                               onTap: () {
//                                 _employeeBloc.add(FetchAllEmployeeStarted());
//                               },
//                               readOnly: true,
//                               // keyboardType: TextInputType.text,
//                               decoration: InputDecoration(
//                                   suffixIcon: Icon(Icons.arrow_drop_down),
//                                   contentPadding: const EdgeInsets.only(
//                                     left: 14.0,
//                                   ),
//                                   fillColor: Colors.grey.shade100,
//                                   filled: true,
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide: new BorderSide(
//                                           color: Colors.grey.shade400)),
//                                   labelText:
//                                       "${AppLocalizations.of(context)!.translate("employee")!}"),
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'Employee is required';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(height: 15),

//                             TextFormField(
//                               controller: _fromCtrl,
//                               readOnly: true,
//                               onTap: () {
//                                 _dialogDate(controller: _fromCtrl);
//                               },
//                               decoration: InputDecoration(
//                                   prefixIcon: Icon(
//                                     Icons.date_range_outlined,
//                                     color: Colors.lightBlue,
//                                   ),
//                                   contentPadding: const EdgeInsets.only(
//                                     left: 14.0,
//                                   ),
//                                   fillColor: Colors.grey.shade100,
//                                   filled: true,
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide: new BorderSide(
//                                           color: Colors.grey.shade400)),
//                                   labelText:
//                                       "${AppLocalizations.of(context)!.translate("from_date")!}"),
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'From date is required.';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(height: 15),
//                             TextFormField(
//                               controller: _toCtrl,
//                               readOnly: true,
//                               onTap: () {
//                                 _dialogDate(controller: _toCtrl);
//                               },
//                               decoration: InputDecoration(
//                                   prefixIcon: Icon(
//                                     Icons.date_range_outlined,
//                                     color: Colors.lightBlue,
//                                   ),
//                                   contentPadding: const EdgeInsets.only(
//                                     left: 14.0,
//                                   ),
//                                   fillColor: Colors.grey.shade100,
//                                   filled: true,
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide: new BorderSide(
//                                           color: Colors.grey.shade400)),
//                                   labelText:
//                                       "${AppLocalizations.of(context)!.translate("end_date")!}"),
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'End date is required.';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(height: 15),
//                             TextFormField(
//                               controller: _allowancCtrl,
//                               keyboardType: TextInputType.text,
//                               decoration: InputDecoration(
//                                 // suffixIcon: Icon(Icons.arrow_drop_down),
//                                 contentPadding: const EdgeInsets.only(
//                                   left: 14.0,
//                                 ),
//                                 fillColor: Colors.grey.shade100,
//                                 filled: true,
//                                 focusedBorder: OutlineInputBorder(
//                                     borderSide: new BorderSide(
//                                         color: Colors.grey.shade400)),
//                                 labelText:
//                                     "${AppLocalizations.of(context)!.translate("allowance")!}",
//                               ),
//                               // validator: (value) {
//                               //   if (value!.isEmpty) {
//                               //     return 'Ref code is required.';
//                               //   }
//                               //   return null;
//                               // },
//                             ),
//                             SizedBox(height: 15),
//                             TextFormField(
//                               controller: _bonusCtrl,
//                               keyboardType: TextInputType.text,
//                               decoration: InputDecoration(
//                                 // suffixIcon: Icon(Icons.arrow_drop_down),
//                                 contentPadding: const EdgeInsets.only(
//                                   left: 14.0,
//                                 ),
//                                 fillColor: Colors.grey.shade100,
//                                 filled: true,
//                                 focusedBorder: OutlineInputBorder(
//                                     borderSide: new BorderSide(
//                                         color: Colors.grey.shade400)),
//                                 labelText:
//                                     "${AppLocalizations.of(context)!.translate("bonus")!}",
//                               ),
//                               // validator: (value) {
//                               //   if (value!.isEmpty) {
//                               //     return 'Working schedule is required.';
//                               //   }
//                               //   return null;
//                               // },
//                             ),
//                             SizedBox(height: 15),
//                             TextFormField(
//                               controller: _seniorityCtrl,
//                               keyboardType: TextInputType.text,
//                               decoration: InputDecoration(
//                                 // suffixIcon: Icon(Icons.arrow_drop_down),
//                                 contentPadding: const EdgeInsets.only(
//                                   left: 14.0,
//                                 ),
//                                 fillColor: Colors.grey.shade100,
//                                 filled: true,
//                                 focusedBorder: OutlineInputBorder(
//                                     borderSide: new BorderSide(
//                                         color: Colors.grey.shade400)),
//                                 labelText:
//                                     "${AppLocalizations.of(context)!.translate("seniority_money")!}",
//                               ),
//                               // validator: (value) {
//                               //   if (value!.isEmpty) {
//                               //     return 'Working schedule is required.';
//                               //   }
//                               //   return null;
//                               // },
//                             ),
//                             SizedBox(height: 15),
//                             TextFormField(
//                               controller: _deductionCtrl,
//                               keyboardType: TextInputType.text,
//                               decoration: InputDecoration(
//                                 // suffixIcon: Icon(Icons.arrow_drop_down),
//                                 contentPadding: const EdgeInsets.only(
//                                   left: 14.0,
//                                 ),
//                                 fillColor: Colors.grey.shade100,
//                                 filled: true,
//                                 focusedBorder: OutlineInputBorder(
//                                     borderSide: new BorderSide(
//                                         color: Colors.grey.shade400)),
//                                 labelText:
//                                     "${AppLocalizations.of(context)!.translate("deduction")!}",
//                               ),
//                               // validator: (value) {
//                               //   if (value!.isEmpty) {
//                               //     return 'Working schedule is required.';
//                               //   }
//                               //   return null;
//                               // },
//                             ),
//                             // SizedBox(height: 15),
//                             SizedBox(
//                                 height: MediaQuery.of(context).size.height / 4),
//                             standardBtn(
//                                 title:
//                                     "${AppLocalizations.of(context)!.translate("update")!}",
//                                 onTap: () {
//                                   if (_formKey!.currentState!.validate()) {
//                                     String userId = "";
//                                     if (_usrCtrl.text !=
//                                         widget.payslipModel.userModel!.name) {
//                                       EmployeeModel employeeModel =
//                                           _employeeBloc.emploList.firstWhere(
//                                               (e) =>
//                                                   "${e.name}" == _usrCtrl.text);
//                                       userId = employeeModel.id;
//                                     } else {
//                                       userId = widget.payslipModel.userId!;
//                                     }
//                                     // ContractBloc structureModel =
//                                     //     _structureBloc
//                                     //         .structure
//                                     //         .firstWhere((e) =>
//                                     //             "${e.name}" ==
//                                     //             _strucuteCtrl.text);

//                                     BlocProvider.of<PayslipBloc>(context).add(
//                                         UpdatePayslipStarted(
//                                             id: widget.payslipModel.id,
//                                             userId: userId,
//                                             fromDate: _fromCtrl.text,
//                                             toDate: _toCtrl.text,
//                                             allowance: _allowancCtrl.text,
//                                             bonus: _bonusCtrl.text,
//                                             senioritySalary:
//                                                 _seniorityCtrl.text,
//                                             advanceMoney: _advanceCtrl.text,
//                                             currey: _currencyCtrl.text,
//                                             exChangeRate: _exchangeRate.text,
//                                             deduction: _deductionCtrl.text));
//                                   }
//                                 })
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 )));
//       }),
//     );
//   }

//   @override
//   void dispose() {
//     // _contractBloc.close();
//     _employeeBloc.close();
//     super.dispose();
//   }
// }
