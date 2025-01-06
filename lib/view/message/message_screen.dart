import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/model/send/send_to_message_view.dart';
import 'package:harmony/view/message/message_controller.dart';

import '../message_view/message_view_screen.dart';

class MessageScreen extends BaseView<MessageController> {
  static const String router = '/MessageScreen';
  const MessageScreen({super.key});

  @override
  MessageController createController(BuildContext context) => MessageController(context);

  @override
  Widget build() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WidgetBodyScroll(
        title: os.language.titleMessage,
        titleColor: os.colorUi.reverse,
        backGroundColor: os.colorUi.deep,
        showIconLeading: false,
        buildType: BuildTypeData.list(
          itemCount: 6,
          itemBuilder: (context, index) {
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
          }
        ),
      ),
    );
  }
}