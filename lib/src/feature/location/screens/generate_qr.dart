import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQr extends StatefulWidget {
  final String id;
  GenerateQr({required this.id});

  @override
  State<GenerateQr> createState() => _GenerateQrState();
}

class _GenerateQrState extends State<GenerateQr> {
  GlobalKey globalKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.share),
        //     onPressed: () {},
        //   )
        // ],
      ),
      body: _contentWidget(),
    );
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.only(
          //     top: _topSectionTopPadding,
          //     left: 20.0,
          //     right: 10.0,
          //     bottom: _topSectionBottomPadding,
          //   ),
          //   child: Container(
          //     height: _topSectionHeight,
          //     child: Row(
          //       mainAxisSize: MainAxisSize.max,
          //       crossAxisAlignment: CrossAxisAlignment.stretch,
          //       children: <Widget>[
          //         // Expanded(
          //         //   child: TextField(
          //         //     controller: _textController,
          //         //     decoration: InputDecoration(
          //         //       hintText: "Enter a custom message",
          //         //       errorText: _inputErrorText,
          //         //     ),
          //         //   ),
          //         // ),
          //         // Padding(
          //         //   padding: const EdgeInsets.only(left: 10.0),
          //         //   child: FlatButton(
          //         //     child: Text("SUBMIT"),
          //         //     onPressed: () {
          //         //       setState(() {
          //         //         _dataString = _textController.text;
          //         //         _inputErrorText = null;
          //         //       });
          //         //     },
          //         //   ),
          //         // )
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: Center(
              child: QrImage(
                data: "ban/${widget.id}",
                size: 0.5 * bodyHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
