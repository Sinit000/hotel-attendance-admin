import 'dart:io';

import 'package:equatable/equatable.dart';

class EmployeeEvent extends Equatable {
  EmployeeEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchEmloyeeStarted extends EmployeeEvent {}

// class FetchRoleStarted extends EmployeeEvent {}

class InitializeEmployeeStarted extends EmployeeEvent {}

class RefreshEmployeeStarted extends EmployeeEvent {}

class FetchEmployeeDetailStarted extends EmployeeEvent {
  final String id;
  FetchEmployeeDetailStarted({required this.id});
}

class FetchAllEmployeeStarted extends EmployeeEvent {}

class AddEmployeeStarted extends EmployeeEvent {
  final String name;
  final String gender;
  final String dob;
  final String email;
  final String officeTel;
  final File? img;
  final String username;

  final String password;
  final String positionId;
  final String departmentId;

  final String phoneNumber;
  final String address;
  final String meritalStatus;

  final String coupleJob;
  final String child;
  final String cardNumber;
  final String nationality;
  final String roleId;
  final String timetalbeId;
  final String workdayId;
  AddEmployeeStarted(
      {required this.name,
      required this.gender,
      required this.dob,
      required this.email,
      required this.officeTel,
      required this.username,
      required this.img,
      required this.password,
      required this.positionId,
      required this.departmentId,
      required this.phoneNumber,
      required this.address,
      required this.meritalStatus,
      required this.coupleJob,
      required this.nationality,
      required this.cardNumber,
      required this.roleId,
      required this.timetalbeId,
      required this.workdayId,
      required this.child});
}

class UpdateEmployeeStarted extends EmployeeEvent {
  final String id;
  final String name;
  final String gender;
  final String dob;
  final String email;
  final String officeTel;
  final File? img;
  final String positionId;
  final String departmentId;
  // final String roleId;
  final String phoneNumber;
  final String address;
  final String imgUrl;
  final String meritalStatus;

  final String coupleJob;
  final String child;
  final String cardNumber;
  final String nationality;
  final String roleId;
  final String timetalbeId;
  final String workdayId;

  UpdateEmployeeStarted(
      {required this.id,
      required this.name,
      required this.gender,
      required this.dob,
      required this.email,
      required this.officeTel,
      required this.img,
      required this.imgUrl,
      required this.phoneNumber,
      required this.positionId,
      required this.departmentId,
      required this.meritalStatus,
      required this.coupleJob,
      required this.child,
      required this.nationality,
      required this.cardNumber,
      required this.roleId,
      required this.timetalbeId,
      required this.workdayId,
      required this.address});
}

class DeleteEmployeeStarted extends EmployeeEvent {
  final String id;

  // final String date;
  DeleteEmployeeStarted({
    required this.id,
  });
}

class AddCheckinStarted extends EmployeeEvent {
  final String checkinTime;
  final String employeeId;

  AddCheckinStarted({
    required this.checkinTime,
    required this.employeeId,
  });
}

class AddCheckoutStarted extends EmployeeEvent {
  final String id;
  final String checkoutTime;
  final String employeeId;
  AddCheckoutStarted({
    required this.checkoutTime,
    required this.id,
    required this.employeeId,
  });
}

class ChangePasswordButtonPressed extends EmployeeEvent {
  ChangePasswordButtonPressed({required this.id, required this.newpass});
  // final String oldpass;
  final String newpass;
  final String id;
  // final String username;
}

class AdminPasswordStarted extends EmployeeEvent {
  AdminPasswordStarted({required this.oldpass, required this.newpass});
  final String oldpass;
  final String newpass;
}
