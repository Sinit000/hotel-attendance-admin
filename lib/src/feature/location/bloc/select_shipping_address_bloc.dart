// import 'package:bloc/bloc.dart';
// import 'package:hotle_attendnce_admin/src/feature/location/models/location_model.dart';
// import 'package:equatable/equatable.dart';


// class SelectShippingAddressBloc
//     extends Bloc<SelectShippingAddressEvent, SelectShippingAddressState> {
//   @override
//   SelectShippingAddressBloc() : super(Selecting());
//   late Address? address;

//   @override
//   Stream<SelectShippingAddressState> mapEventToState(
//       SelectShippingAddressEvent event) async* {
//     if (event is SelectAddress) {
//       yield Selecting();
//       address = event.address;
//       yield Selected();
//     }
//   }
// }

// abstract class SelectShippingAddressEvent extends Equatable {
//   SelectShippingAddressEvent([List props = const []]) : super();
//   @override
//   List<Object> get props => [];
// }

// class SelectAddress extends SelectShippingAddressEvent {
//   final Address address;
//   SelectAddress({required this.address});
// }

// abstract class SelectShippingAddressState extends Equatable {
//   SelectShippingAddressState([List props = const []]) : super();
//   @override
//   List<Object> get props => [];
// }

// class Selecting extends SelectShippingAddressState {}

// class Selected extends SelectShippingAddressState {}
