// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:hotle_attendnce_admin/src/feature/department/bloc/department_bloc.dart';
// import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';

// import 'department_page.dart';

// class AddDepartment extends StatefulWidget {
//   final bool isGroup;
//   const AddDepartment({this.isGroup = false}) ;

//   @override
//   State<AddDepartment> createState() => _AddDepartmentState();
// }

// class _AddDepartmentState extends State<AddDepartment> {
//   final TextEditingController _reasonCtrl = TextEditingController();
//   late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: standardAppBar(context, "Add Department"),
//       body: Builder(builder: (context) {
//         return BlocListener(
//           bloc: departmentBlc,
//           listener: (context, state) {
//             if (state is AddingDepartment) {
//               EasyLoading.show(status: "loading....");
//             }
//             if (state is ErrorAddingDepartment) {
//               Navigator.pop(context);
//               errorSnackBar(text: state.error.toString(), context: context);
//             }
//             if (state is AddedDepartment) {
//               EasyLoading.dismiss();
//               EasyLoading.showSuccess("Sucess");
//               Navigator.pop(context);
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
//                       SizedBox(height: 15),
//                       TextFormField(
//                         controller: _reasonCtrl,
//                         keyboardType: TextInputType.text,
//                         decoration: InputDecoration(
//                             contentPadding: EdgeInsets.all(15),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(5.0),
//                               ),
//                               borderSide: new BorderSide(
//                                 width: 1,
//                               ),
//                             ),
//                             isDense: true,
//                             labelText: "Department name"),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Department name';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height / 4),
//                       standardBtn(
//                           title: "Submit",
//                           onTap: () {
//                             if (_formKey!.currentState!.validate()) {
//                               departmentBlc.add(AddDepartmentStarted(
//                                   name: _reasonCtrl.text,
//                                   locationId: "",
//                                   groupId: "",
//                                   notes: ""));
//                             }
//                           })
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
// // 