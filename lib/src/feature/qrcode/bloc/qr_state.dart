import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class QRState extends Equatable {
  QRState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchingQR extends QRState {}

class FetchedQR extends QRState {
  final String img;
  FetchedQR({
    required this.img
  });
  // final Uint8List? img;
  // FetchedQR({required this.img});
}

class ErrorFetchingQR extends QRState {
  final String error;
  ErrorFetchingQR({required this.error});
}
