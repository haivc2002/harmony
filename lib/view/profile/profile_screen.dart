import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/profile/profile_controller.dart';


class ProfileScreen extends BaseView<ProfileController> {
  static const String router = '/ProfileScreen';
  const ProfileScreen({super.key});

  @override
  ProfileController controller(BuildContext context) => ProfileController(context);

  @override
  Widget build(BuildContext context, BaseState system, ProfileController controller) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WidgetBodyScroll(
        title: system.language.titleProfile,
        titleColor: system.colorUi.reverse,
        backGroundColor: system.colorUi.deep,
        bodyListWidget: [
          _myAvatar(context),
          SizedBox(height: 10.w),
          Text("huowng phamj • 20 tuoi", style: Styles.def.setColor(MyColor.pink).bold.setTextSize(14.sp)),
          Row(children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: MyColor.pink,
                borderRadius: BorderRadius.circular(100.w),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.w),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: MyColor.white, size: 17.sp),
                    SizedBox(width: 3.w),
                    Text("data", style: Styles.def.setColor(MyColor.white)),
                  ],
                ),
              ),
            ),
            const Spacer()
          ]),
          SizedBox(height: 10.w),
          _boxImageAndChart(context, system, controller),
        ],
      ),
    );
  }

  Widget _myAvatar(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0),
            Colors.black,
            Colors.black,
            Colors.black.withOpacity(0),
          ],
          stops: const [0.0, 0.1, 0.8, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: Image.network(
        'https://anhnail.com/wp-content/uploads/2024/10/Hinh-gai-xinh-Viet-Nam-ngau.jpg',
        width: Common.screen(context, be: Be.width) * 0.9,
        height: Common.screen(context, be: Be.width) * 0.9,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _boxImageAndChart(BuildContext context, BaseState system, ProfileController controller) {
    return SizedBox(
      height: Common.screen(context, be: Be.width)/2,
      child: Row(children: [
        WidgetImageStack(
          color: system.colorUi.fade,
          images: controller.list,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(children: [
            WidgetChartComplete(
              value: 66,
              title: 'ho so hoan thanh',
              color: system.colorUi.fade,
              titleColor: system.colorUi.reverse,
            ),
            SizedBox(height: 10.w),
            Expanded(child: SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: ColoredBox(
                  color: system.colorUi.fade,
                  child: Text('data'),
                ),
              ),
            ))
          ]),
        )
      ]),
    );
  }

}
