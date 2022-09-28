// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:e_learning/src/feature/banner/bloc/index.dart';
// import 'package:e_learning/src/feature/banner/bloc/index.dart';
// import 'package:e_learning/src/feature/banner/model/model_banner.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';






// class BannerPage extends StatefulWidget {
//   const BannerPage({Key? key}) : super(key: key);

//   @override
//   _BannerPageState createState() => _BannerPageState();
// }

// class _BannerPageState extends State<BannerPage> {
//   List<BannerModel> bannerModel = [];
//   BannerBloc _bannerBloc = BannerBloc();
//   IndexingBloc indexingBloc = IndexingBloc();
//   @override
//   void initState() {
//     _bannerBloc.add(FetchedBannerStarted());
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _bannerBloc.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
// //_bannerBloc.add(FetchedBannerEvent());
//     return BlocBuilder(
//         bloc: _bannerBloc,
//         builder: (context, state) {
//           print(state);
//           if (state is FetchingBanner) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (state is ErrorFetchingBanner) {
//             return Center(
//               child: Text(state.error),
//             );
//           } else {
//             // print(_bannerBloc.bannerModel.length);
//             if (_bannerBloc.banners.length == 0) {
//               return Container(
//                 child: Text("No Banner",
//                     style: TextStyle(
//                       color: Colors.red,
//                     )),
//               );
//             }
//             // return Container(child: Text("HI"));
//             return Stack(
//               children: [
//                 CarouselSlider(
//                     items: _bannerBloc.banners
//                         .map(
//                           (e) => Container(
//                             height: 250,
//                             margin: EdgeInsets.symmetric(horizontal: 6),
//                             padding: EdgeInsets.only(
//                               top: 5,
//                               // bottom: ((((MediaQuery.of(context).size.width /
//                               //                     100) *
//                               //                 14) -
//                               //             12) /
//                               //         2) +
//                               //     0
//                             ),
//                             width: 600,
//                             child: Container(
//                               width: 500,
//                               height: 240,
//                               // height: 230,
//                               child: ClipRRect(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(18.0)),
//                                   child: Container(
//                                     height: 400,
//                                     width: 600,
//                                     child: Image.network(
//                                       "${e.image}",
//                                       fit: BoxFit.cover,
//                                     ),
//                                   )),
//                             ),
//                           ),
//                         )
//                         .toList(),
//                     options: CarouselOptions(
//                       onPageChanged: (index, s) {
//                         // indexingBloc.add(Taped(index: index));
//                       },
//                       // aspectRatio: 1.68,
//                       aspectRatio: 2,
//                       viewportFraction: 0.86,
//                       initialPage: 0,
//                       enableInfiniteScroll: true,
//                       reverse: false,
//                       autoPlay: true,
//                       autoPlayInterval: Duration(seconds: 3),
//                       autoPlayAnimationDuration: Duration(milliseconds: 600),
//                       autoPlayCurve: Curves.fastOutSlowIn,
//                       enlargeCenterPage: true,
//                       enlargeStrategy: CenterPageEnlargeStrategy.height,
//                       scrollDirection: Axis.horizontal,
//                     )),
//               ],
//             );
//           }
//         });
//   }
// }
