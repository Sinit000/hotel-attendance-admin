// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:hotle_attendnce_admin/src/feature/change_password/repostiory/change_pass_repository.dart';


// import 'change_password_event.dart';
// import 'change_password_state.dart';

// class ChangePasswordBloc
//     extends Bloc<ChangePasswordEvent, ChangePasswordState> {
//   ChangePasswordRepository _userAccountRepository = ChangePasswordRepository();
//   @override
//   ChangePasswordBloc() : super(Initializing());

//   @override
//   Stream<ChangePasswordState> mapEventToState(
//       ChangePasswordEvent event) async* {
//     if (event is ChangePasswordButtonPressed) {
//       yield Changing();
//       try {
//         await Future.delayed(Duration(milliseconds: 500));
//         final String accessToken =
//             await _userAccountRepository.changeChangePassword(
//                 oldpass: event.oldpass,
//                 newpass: event.newpass,
//                 username: event.username);
//         yield Changed(accessToken: accessToken);
//       } catch (e) {
//         yield ChangeFailed(error: e);
//       }
//     }
//   }
// }
