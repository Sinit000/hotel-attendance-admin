// import 'dart:developer';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotle_attendnce_admin/src/feature/employee_timetable/model/employee_timetable_model.dart';
// import 'package:hotle_attendnce_admin/src/feature/employee_timetable/repository/employee_timetable_repository.dart';

// import 'index.dart';

// class EmployeeTimetableBloc
//     extends Bloc<EmployeeTimetableEvent, EmployeeTimetableState> {
//   EmployeeTimetableBloc() : super(InitializingEmployeeTimetable());
//   EmployeeTimetableRepository employeeTimetableRepository =
//       EmployeeTimetableRepository();

//   List<EmployeeTimetablModel> timeList = [];
//   int rowperpage = 12;
//   int page = 1;
//   @override
//   Stream<EmployeeTimetableState> mapEventToState(
//       EmployeeTimetableEvent event) async* {
//     if (event is FetchEmloyeeTimetableStarted) {
//       yield FetchingEmployeeTimetable();
//       try {
//         print(page);
//         List<EmployeeTimetablModel> _timeList =
//             await employeeTimetableRepository.getSchedule(
//                 rowPerpage: rowperpage, page: page);

//         timeList.addAll(_timeList);
//         page++;
//         print(page);
//         print(timeList.length);
//         // yield FetchedEmployee();
//         print(_timeList.length);
//         if (_timeList.length < rowperpage) {
//           print(timeList.length);
//           yield EndofEmployeeTimetable();
//         } else {
//           yield FetchedEmployeeTimetable();
//         }
//       } catch (e) {
//         log(e.toString());
//         yield ErrorFetchingEmployeeTimetable(error: e.toString());
//       }
//     }
//     if (event is InitializeEmployeeTimetableStarted) {
//       yield InitializingEmployeeTimetable();
//       try {
//         // Future.delayed(Duration(milliseconds: 200));
//         print(page);
//         List<EmployeeTimetablModel> _timeList =
//             await employeeTimetableRepository.getSchedule(
//                 rowPerpage: rowperpage, page: page);

//         timeList.addAll(_timeList);
//         page++;
//         print(page);
//         print(timeList.length);
//         yield InitializedEmployeeTimetable();
//       } catch (e) {
//         log(e.toString());
//         yield ErrorFetchingEmployeeTimetable(error: e.toString());
//       }
//     }
//     // if (event is FetchEmloyeeTimetableStarted) {
//     //   yield FetchingEmployeeTimetable();
//     //   try {
//     //     print(page);
//     //     print(timeList.length);
//     //     List<EmployeeTimetablModel> _timeList =
//     //         await employeeTimetableRepository.getSchedule(
//     //             rowPerpage: rowperpage, page: page);
//     //     timeList.addAll(_timeList);
//     //     page++;
//     //     print(page);
//     //     print(timeList.length);
//     //     if (_timeList.length < rowperpage) {
//     //       print(timeList.length);
//     //       yield EndofEmployeeTimetable();
//     //     } else {
//     //       print(timeList.length);
//     //       yield FetchedEmployeeTimetable();
//     //     }
//     //   } catch (e) {
//     //     log(e.toString());
//     //     yield ErrorFetchingEmployeeTimetable(error: e.toString());
//     //   }
//     // }
//     // if (event is InitializeEmployeeTimetableStarted) {
//     //   yield InitializingEmployeeTimetable();
//     //   try {
//     //     List<EmployeeTimetablModel> _timeList =
//     //         await employeeTimetableRepository.getSchedule(
//     //             rowPerpage: rowperpage, page: page);
//     //     timeList.addAll(_timeList);
//     //     page++;
//     //     print(page);
//     //     print(timeList.length);
//     //     yield InitializedEmployeeTimetable();
//     //   } catch (e) {
//     //     log(e.toString());
//     //     yield ErrorFetchingEmployeeTimetable(error: e.toString());
//     //   }
//     // }

//     if (event is RefreshEmployeeTimetableStarted) {
//       yield FetchingEmployeeTimetable();
//       try {
//         page = 1;
//         if (timeList.length != 0) {
//           timeList.clear();
//         }
//         List<EmployeeTimetablModel> _timeList =
//             await employeeTimetableRepository.getSchedule(
//                 rowPerpage: rowperpage, page: page);
//         timeList.addAll(_timeList);
//         page++;
//         print(page);
//         print(timeList.length);
//         yield FetchedEmployeeTimetable();
//       } catch (e) {
//         log(e.toString());
//         yield ErrorFetchingEmployeeTimetable(error: e.toString());
//       }
//     }
//     if (event is AddEmployeeTimetableStarted) {
//       yield AddingEmployeeTimetable();
//       try {
//         await employeeTimetableRepository.addSchedule(
//             employeeId: event.employeeId, timetableId: event.timetableId);
//         yield AddedEmployeeTimetable();
//         yield FetchingEmployeeTimetable();
//         timeList.clear();
//         timeList = await employeeTimetableRepository.getSchedule(
//             rowPerpage: rowperpage, page: 1);
//         print(timeList.length);
//         yield FetchedEmployeeTimetable();
//       } catch (e) {
//         log(e.toString());
//         yield ErrorAddingEmployeeTimetable(error: e.toString());
//       }
//     }
//     if (event is UpdateEmployeeTimetableStarted) {
//       yield AddingEmployeeTimetable();
//       try {
//         await employeeTimetableRepository.editSchedule(
//             id: event.id,
//             employeeId: event.employeeId,
//             timetableId: event.timetableId);
//         yield AddedEmployeeTimetable();
//         yield FetchingEmployeeTimetable();
//         timeList.clear();
//         timeList = await employeeTimetableRepository.getSchedule(
//             rowPerpage: rowperpage, page: 1);
//         print(timeList.length);
//         yield FetchedEmployeeTimetable();
//       } catch (e) {
//         log(e.toString());
//         yield ErrorAddingEmployeeTimetable(error: e.toString());
//       }
//     }
//     if (event is DeleteEmployeeTimetableStarted) {
//       yield AddingEmployeeTimetable();
//       try {
//         await employeeTimetableRepository.deleteSchedule(
//           id: event.id,
//         );
//         yield AddedEmployeeTimetable();
//         yield FetchingEmployeeTimetable();
//         timeList.clear();
//         timeList = await employeeTimetableRepository.getSchedule(
//             rowPerpage: rowperpage, page: 1);
//         print(timeList.length);
//         yield FetchedEmployeeTimetable();
//       } catch (e) {
//         log(e.toString());
//         yield ErrorAddingEmployeeTimetable(error: e.toString());
//       }
//     }
//   }
// }
