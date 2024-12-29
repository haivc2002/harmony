import 'package:harmony/base_project/package_widget.dart';

import '../../model/send/send_to_message_view.dart';

class MessageViewController extends BaseController {
  MessageViewController(super.context);

  @override
  get args => onCreateArgument<SendToMessageView>();

  @override
  void onInitState() {
    super.onInitState();
  }
}