// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'src/navigation_controls.dart';
import 'src/web_view_stack.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({Key? key}) : super(key: key);

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  WebViewController? controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => requestStoragePermission());
  }

  Future<void> requestStoragePermission() async {
    final PermissionStatus status = await Permission.storage.request();
    if (status != PermissionStatus.granted) {
      // If the user does not grant permission, show a dialog or toast message
      // explaining why storage permission is needed and ask the user to grant
      // permission again.
    } else {
    // Permission granted, request the write external storage permission
    final PermissionStatus status = await Permission.storage.request();
    if (status != PermissionStatus.granted) {
      // If the user does not grant permission, show a dialog or toast message
      // explaining why write external storage permission is needed and ask
      // the user to grant permission again.
    } else {
      // Permission granted, load the web view
      setState(() {
        controller = WebViewController(); // Initialize the WebViewController object
        controller?.loadRequest(
          Uri.parse('https://infobus.in/login'),
        );
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InfoBus Login App'),
        actions: [
          if (controller != null) NavigationControls(controller: controller!),
        ],
      ),
      body: controller != null ? WebViewStack(controller: controller!) : const SizedBox(),
    );
  }
}
