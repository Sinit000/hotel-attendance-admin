import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({ Key? key }) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Attendance"),
      // body: BlocBuilder(builder: builder),
    );
  }
}