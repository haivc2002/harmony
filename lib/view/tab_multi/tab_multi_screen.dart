import 'dart:ui';

import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/tab_multi/bloc/tab_multi_bloc.dart';
import 'package:harmony/view/tab_multi/tab_multi_controller.dart';
import 'package:harmony/view/tab_multi/tab_multi_drawer.dart';
import 'package:harmony/view/tab_multi/tab_multi_menu.dart';


class TabMultiScreen extends BaseView<TabMultiController> {
  static const String router = "/TabMultiScreen";
  const TabMultiScreen({super.key});

  @override
  TabMultiController controller(BuildContext context) => TabMultiController(context);

  @override
  Widget build(BuildContext context, BaseState system, TabMultiController controller) {
    return BlocBuilder<TabMultiBloc, TabMultiState>(
      builder: (context, state) {
        return Scaffold(
          drawer: const TabMultiDrawer(),
          body: Stack(
            children: [
              PageView.builder(
                controller: controller.pageController,
                itemCount: controller.linkList.getList(state).length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => controller.linkList.getList(state)[index],
              ),
              Positioned(
                bottom: 20.w,
                right: 17.w,
                left: 17.w,
                child: TabMultiMenu(state: state, controller: controller),
              ),
              Center(
                child: Builder(
                  builder: (context) {
                    return ElevatedButton(onPressed: () {
                      Scaffold.of(context).openDrawer();
                    }, child: Text("data"));
                  }
                ),
              )
            ],
          ),
        );
      }
    );
  }

}