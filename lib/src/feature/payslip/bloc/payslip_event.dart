import 'package:equatable/equatable.dart';

class PayslipEvent extends Equatable {
  PayslipEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailizePayslipStarted extends PayslipEvent {
   final String? dateRange;
  InitailizePayslipStarted({required this.dateRange});
}


class FetchPayslipStarted extends PayslipEvent { 
  final String? dateRange;
  FetchPayslipStarted({required this.dateRange});
}

class RefreshPayslipStarted extends PayslipEvent {
   final String? dateRange;
  RefreshPayslipStarted({required this.dateRange});
}


class AddPayslipStarted extends PayslipEvent {
  final String userId;
  // final String contractId;
  final String fromDate;
  final String toDate;
  final String allowance;
  final String bonus;
  final String senioritySalary;
  final String advanceMoney;
  final String currey;
  final String exChangeRate;
  final String deduction;
  AddPayslipStarted(
      {required this.userId,
      // required this.contractId,
      required this.fromDate,
      required this.toDate,
      required this.allowance,
      required this.bonus,
      required this.senioritySalary,
      required this.advanceMoney,
      required this.currey,
      required this.exChangeRate,
      required this.deduction});
}

class UpdatePayslipStarted extends PayslipEvent {
  final String id;
  final String userId;
  // final String contractId;
  final String fromDate;
  final String toDate;
  final String allowance;
  final String bonus;
  final String senioritySalary;
  final String advanceMoney;
  final String currey;
  final String exChangeRate;
  final String deduction;
  UpdatePayslipStarted(
      {required this.id,
      required this.userId,
      // required this.contractId,
      required this.fromDate,
      required this.toDate,
      required this.allowance,
      required this.bonus,
      required this.senioritySalary,
      required this.advanceMoney,
      required this.currey,
      required this.exChangeRate,
      required this.deduction});
}

class DeletePayslipStarted extends PayslipEvent {
  final String id;
  DeletePayslipStarted({
    required this.id,
  });
}
