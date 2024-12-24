import 'dart:ui';

import 'package:harmony/view/tab_multi/tab_multi_controller.dart';

import '../../base_project/package_widget.dart';
import 'bloc/tab_multi_bloc.dart';

class TabMultiMenu extends StatelessWidget {
  final TabMultiState state;
  final TabMultiController controller;
  const TabMultiMenu({super.key, required this.state, required this.controller});

  @override
  Widget build(BuildContext context) {
    double withBtn = (Common.screen(context, be: Be.width) - 46.w)/controller.listPage.length;
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.w),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 50.w,
          padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 6.w),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            color: Colors.black54,
            borderRadius: BorderRadius.circular(100.w)
          ),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
                width: withBtn,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: MyColor.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(100.w)
                ),
                margin: EdgeInsets.only(left: withBtn * state.currentIndex),
              ),
              Row(children: List.generate(controller.listPage.length, (index) {
                return Expanded(
                  child: IconButton(
                    onPressed: ()=> controller.linkList.navigationHandling(index, state),
                    icon: Icon(Icons.home),
                  ),
                );
              })),
            ],
          ),
        ),
      ),
    );
  }
}
