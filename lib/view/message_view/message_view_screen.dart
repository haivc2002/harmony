import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/message_view/message_view_controller.dart';


class MessageViewScreen extends BaseView<MessageViewController> {
  static const String router = "/MessageViewScreen";
  const MessageViewScreen({super.key});

  @override
  MessageViewController controller(BuildContext context) => MessageViewController(context);

  @override
  Widget build(BuildContext context, BaseState system, MessageViewController controller) {
    return Scaffold(
      backgroundColor: system.colorUi.deep,
      body: Stack(
        children: [
          ListView.builder(
            itemCount: 10,
            physics: const BouncingScrollPhysics().applyTo(const AlwaysScrollableScrollPhysics()),
            itemBuilder: (context, index) {
              return Text(index.toString());
            }
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
              child: SizedBox(
                height: 50.w,
                width: double.infinity,
                child: ColoredBox(
                  color: MyColor.red.withOpacity(0.0),
                  child: IconButton(
                    onPressed: ()=> Navigator.pop(context),
                    icon: Icon(CupertinoIcons.back)
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}