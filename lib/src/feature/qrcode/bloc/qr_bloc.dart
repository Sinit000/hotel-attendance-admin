import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/qrcode/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/qrcode/repository/qr_repository.dart';

class QRBloc extends Bloc<QREvent, QRState> {
  QRBloc() : super(FetchingQR());
  QrRepository _qrRepository = QrRepository();
  @override
  Stream<QRState> mapEventToState(QREvent event) async* {
    if (event is FetchQRStarted) {
      yield FetchingQR();
      try {
        // Uint8List? _img = await _qrRepository.getQR();
        String _img = await _qrRepository.getQR();
        yield FetchedQR(img: _img);
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingQR(error: e.toString());
      }
    }
  }
}
