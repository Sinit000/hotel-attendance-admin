// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:hotle_attendnce_admin/src/feature/permission/bloc/leave_state.dart';
// import 'package:hotle_attendnce_admin/src/feature/permission/screen/leave_page.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';

// Future<void> _displayTextInputDialog({required BuildContext context,required String id}) async {
//   return showDialog(
//       context: context,
//       builder: (context) {
//         return Builder(builder: (context) {
//           return  BlocListener(
//             bloc: leaveBloc,
//             listener: (context, state) {
//               if (state is AddingLeave) {
//                 EasyLoading.show(status: 'loading...');
//               }
//               if (state is ErrorAddingLeave) {
//                 EasyLoading.dismiss();
//                 errorSnackBar(text: state.error.toString(), context: context);
//               }
//               if (state is AddedLeave) {
//                 EasyLoading.dismiss();
//                 EasyLoading.showSuccess('Success');
//                 Navigator.pop(context);
//                 print("success");
//               }
//             },
//             child: AlertDialog(
//               title: Text('Choose status'),
//               content: Container(
//                 height: MediaQuery.of(context).size.height / 3,
//                 child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           controller: _textFieldController,
//                           readOnly: true,
//                           onTap: () {
//                             customModal(context, _mylist, (value) {
//                               _textFieldController.text = value;
//                             });
//                           },
//                           // keyboardType: TextInputType.text,
//                           decoration: InputDecoration(
//                               suffixIcon: Icon(Icons.arrow_drop_down),
//                               contentPadding: EdgeInsets.all(15),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(5.0),
//                                 ),
//                                 borderSide: new BorderSide(
//                                   width: 1,
//                                 ),
//                               ),
//                               isDense: true,
//                               labelText: "Choose status"),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'status is required.';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         TextFormField(
//                           controller: _deductionCtrl,
//                           keyboardType: TextInputType.phone,
//                           decoration: InputDecoration(
//                               // suffixIcon: Icon(Icons.arrow_drop_down),
//                               contentPadding: EdgeInsets.all(15),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(5.0),
//                                 ),
//                                 borderSide: new BorderSide(
//                                   width: 1,
//                                 ),
//                               ),
//                               isDense: true,
//                               labelText: "Enter deduction"),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'type is required.';
//                             }
//                             return null;
//                           },
//                         )
//                       ],
//                     )),
//               ),
//               actions: <Widget>[
//                 FlatButton(
//                   color: Colors.red,
//                   textColor: Colors.white,
//                   child: Text('CANCEL'),
//                   onPressed: () {
//                     Navigator.pop(context);
//                     _textFieldController.clear();
//                   },
//                 ),
//                 FlatButton(
//                   color: Colors.green,
//                   textColor: Colors.white,
//                   child: Text('OK'),
//                   onPressed: () {
//                     if (_formKey!.currentState!.validate()) {
//                       String status = "";
//                       if (_textFieldController.text == "Approve") {
//                         status = "approved";
//                       }
//                       if (_textFieldController.text == "Reject") {
//                         status = "rejected";
//                       }
//                       print(status);
//                       print(id);
//                       leaveBloc.add(UpdateLeaveStatusStarted(
//                           id: id,
//                           status: status,
//                           deduction: _deductionCtrl.text));
//                     }
//                   },
//                 ),
//               ],
//             ),
//           );
//         });
//       });
// }
