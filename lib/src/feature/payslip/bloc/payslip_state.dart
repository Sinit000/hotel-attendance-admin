import 'package:equatable/equatable.dart';

class PayslipState extends Equatable {
  PayslipState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailizingPayslip extends PayslipState {}

class InitailizedPayslip extends PayslipState {}

class FetchingPayslip extends PayslipState {}

class FetchedPayslip extends PayslipState {}

class EndofPayslip extends PayslipState {}

class ErrorFetchingPayslip extends PayslipState {
  final dynamic error;
  ErrorFetchingPayslip({required this.error});
}

class AddingPayslip extends PayslipState {}

class AddedPayslip extends PayslipState {}

class ErrorAddingPayslip extends PayslipState {
  final dynamic error;
  ErrorAddingPayslip({required this.error});
}
