import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MapWebView extends StatefulWidget {
  const MapWebView({Key? key}) : super(key: key);

  @override
  State<MapWebView> createState() => _MapWebViewState();
}

class _MapWebViewState extends State<MapWebView> {
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop:true,
        onPopInvoked: (bool didPop) async{
          //  onWillPop: () async {

          return Future.value(true);
        },
        child: Scaffold(
          body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri('https://www.google.co.in/maps/'),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  inAppWebViewController = controller;
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                },
              ),
              _progress < 1
                  ? Container(
                child: LinearProgressIndicator(
                  value: _progress,
                ),
              )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
