// import 'package:e_learning/src/feature/banner/bloc/index.dart';
// import 'package:e_learning/src/feature/banner/model/model_banner.dart';
// import 'package:e_learning/src/feature/banner/repository/banner_repository.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


// class BannerBloc extends Bloc<BannerEvent, BannerState> {
//   List<BannerModel> banners = [];
//   BannerRepository _appContentsRepository = BannerRepository();
//   @override
//   BannerBloc() : super(FetchingBanner());

//   @override
//   Stream<BannerState> mapEventToState(BannerEvent event) async* {
//     if (event is FetchedBannerStarted) {
//       yield FetchingBanner();
//       try {
//         await Future.delayed(Duration(milliseconds: 200));
//         banners = await _appContentsRepository.getListBanner();
//         // if (banners != null) {
//         //   yield FetchedBanner();
//         // } else {
//         //   yield ErrorFetchingBanner(error: e);
//         // }
//         yield FetchedBanner();
//       } catch (e) {
//         yield ErrorFetchingBanner(error: e);
//       }
//     }
//   }
// }
