import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/message_view/message_view_controller.dart';


class MessageViewScreen extends BaseView<MessageViewController> {
  static const String router = "/MessageViewScreen";
  const MessageViewScreen({super.key});

  @override
  MessageViewController createController(BuildContext context) => MessageViewController(context);

  @override
  Widget build() {
    return WidgetBodyScroll(
      buildType: BuildTypeData.base(
        children: [
          Center(child: ElevatedButton(
            onPressed: ()=> controller.startAnimation(), 
            child: Text("data"),
          ))
        ]
      ),
    );
  }

}