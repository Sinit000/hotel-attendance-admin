
import 'package:flutter/widgets.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/model/timetable_model.dart';

Widget time(BuildContext context, {required List<TimetableModel> time}) {
  return Container(
    child: ListView.builder(
        itemCount: time.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Text("from :"),
              Text(" ${time[index].onDutyTtime}"),
              Text(" to :"),
              Text("${time[index].offDutyTime}"),
            ],
          );
        }),
  );
}
