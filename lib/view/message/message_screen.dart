import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/model/send/send_to_message_view.dart';
import 'package:harmony/view/message/message_controller.dart';

import '../message_view/message_view_screen.dart';

class MessageScreen extends BaseView<MessageController> {
  static const String router = '/MessageScreen';
  const MessageScreen({super.key});

  @override
  MessageController controller(BuildContext context) => MessageController(context);

  @override
  Widget build(BuildContext context, BaseState system, BaseController controller) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WidgetBodyScroll(
        title: system.language.titleMessage,
        titleColor: system.colorUi.reverse,
        backGroundColor: system.colorUi.deep,
        bodyListWidget: List.generate(6, (index) {
          return GestureDetector(
            onTap: ()=> Navigator.pushNamed(context,
                MessageViewScreen.router, arguments: SendToMessageView(tag: index)),
            child: Material(
              color: Colors.transparent,
              child: const ListTile(
                leading: CircleAvatar(),
                title: Text("Tewwrwe"),
                subtitle: Text("dfakwefwe"),
              ),
            ),
          );
        })
      ),
    );
  }
}