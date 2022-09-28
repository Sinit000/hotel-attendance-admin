// import 'dart:developer';

// import 'package:hotle_attendnce_admin/src/feature/account/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/feature/account/model/account_model.dart';
// import 'package:hotle_attendnce_admin/src/feature/account/repository/account_repository.dart';
// import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AccountBloc extends Bloc<AccountEvent, AccountState> {
//   AccountRepository _accountRepository = AccountRepository();
//   AccountModel? accountModel;
//   // CheckInOutRepository checkInOutRepository = CheckInOutRepository();

//   @override
//   AccountBloc() : super(FethchingAccount());
//   @override
//   Stream<AccountState> mapEventToState(AccountEvent event) async* {
//     if (event is FetchAccountStarted) {
//       yield FethchingAccount();
//       try {
//         Future.delayed(Duration(microseconds: 200));
//         accountModel = await _accountRepository.getAccount();
//         yield FethedAccount();
//       } catch (e) {
//         print(e.toString());
//         yield ErrorFethchingAccount(error: e.toString());
//       }
//     }
//     // if (event is AddCheckinStarted) {
//     //   yield AddingCheckin();
//     //   try {
//     //     print(event.lat);
//     //     print(event.lon);
//     //     await _accountRepository.checkin(
//     //       checkinTime: event.checkinTime,
//     //       lat: event.lat,
//     //       lon: event.lon,
//     //       locationId: event.locationId,
//     //       // date: event.date,
//     //       // timetableId: event.timetableId
//     //     );
//     //     yield AddedCheckin();
//     //     yield FethchingAccount();
//     //     accountModel = await _accountRepository.getAccount();
//     //     yield FethedAccount();
//     //   } catch (e) {
//     //     log(e.toString());
//     //     yield ErrorAddingCheckInOut(error: e.toString());
//     //   }
//     // }
//     // if (event is AddCheckoutStarted) {
//     //   yield AddingCheckout();
//     //   try {
//     //     await _accountRepository.checkout(
//     //       checkoutTime: event.checkoutTime,
//     //       lat: event.lat,
//     //       lon: event.lon,
//     //       locationId: event.locationId,
//     //       // date: event.date,
//     //       // timetableId: event.timetableId
//     //     );
//     //     yield AddedCheckin();
//     //     yield FethchingAccount();
//     //     accountModel = await _accountRepository.getAccount();
//     //     print(accountModel!.status);
//     //     yield FethedAccount();
//     //   } catch (e) {
//     //     log(e.toString());
//     //     yield ErrorAddingCheckInOut(error: e.toString());
//     //   }
//     // }

//     if (event is UpdateAccountStated) {
//       yield UpdatingAccount();
//       try {
//         final String image = await uploadImage(image: event.imageUrl);
//         print(image);

//         await _accountRepository.updateAccount(
//             name: event.name,
//             phone: event.phone,
//             email: event.email,
//             city: event.city,
//             company: event.company,
//             address: event.address,
//             skills: event.skill,
//             educations: event.education,
//             experiences: event.experience,
//             imageUrl: image);
//         //event.user.image = imageUrl;
//         //await _accountRepository.updateAccount(event.user);
//         yield UpdatedAccount();
//         yield FethchingAccount();
//         accountModel = await _accountRepository.getAccount();
//         yield FethedAccount();
//       } catch (e) {
//         yield ErrorUpdatingAccount(error: e.toString());
//       }
//     }
//     if (event is UpgradeAccountStarted) {
//       yield UpgradingAccount();
//       try {
//         final String image = await uploadImage(image: event.imageUrl);
//         print(image);

//         await _accountRepository.upgradeAccount(
//             subscriptionId: event.subscriptionId,
//             paymentMethod: event.paymentMethod,
//             imageUrl: image);

//         yield UpgradedAccount();
//         yield FethchingAccount();
//         accountModel = await _accountRepository.getAccount();
//         yield FethedAccount();
//       } catch (e) {
//         print(e.toString());
//         yield ErrorUpdatingAccount(error: e.toString());
//       }
//     }
//   }
// }
