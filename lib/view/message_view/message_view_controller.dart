import 'package:flutter/services.dart';
import 'package:harmony/base_project/package_widget.dart';

import '../../model/send/send_to_message_view.dart';

class MessageViewController extends BaseController {
  MessageViewController(super.context);

  @override
  get args => onCreateArgument<SendToMessageView>();

  final MethodChannel _channel = const MethodChannel('native_animation');

  Future<void> startAnimation() async {
    try {
      await _channel.invokeMethod('startAnimation');
    } on PlatformException catch (e) {
      print('Failed to start animation: ${e.message}');
    }
  }
}