
import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/explorer/explorer_controller.dart';
import 'package:harmony/view/match/match_screen.dart';

class ExplorerScreen extends BaseView<ExplorerController> {
  static const String router = "/ExplorerScreen";
  const ExplorerScreen({super.key});

  @override
  ExplorerController createController(BuildContext context) => ExplorerController(context);

  @override
  Widget build() {
    return Scaffold(
      backgroundColor: os.colorUi.deep,
      body: WidgetBodyScroll(
        titleColor: os.colorUi.reverse,
        backGroundColor: os.colorUi.deep,
        title: os.language.titleExplorer,
        showIconLeading: false,
        buildType: BuildTypeData.base(children: [
          Row(children: [
            Expanded(child: GestureDetector(
              onTap: ()=> Navigator.pushNamed(context, MatchScreen.router),
              child: WidgetBadges(
                value: 11,
                child: Container(
                  height: 200.w,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    border: Border.all(color: MyColor.grey, width: 2.w),
                    image: const DecorationImage(
                        image: AssetImage(MyImage.matchesImage),
                        fit: BoxFit.cover
                    ),
                  ),
                  padding: EdgeInsets.only(right: 10.w, left: 10.w, bottom: 10.w, top: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipOval(child: ColoredBox(
                        color: MyColor.white,
                        child: Padding(
                          padding: EdgeInsets.all(5.w),
                          child: const Icon(Icons.favorite_outlined, color: MyColor.red),
                        ),
                      )),
                      const Spacer(),
                      Expanded(
                          flex: 4,
                          child: Text(os.language.titleMatch, style: Styles.def.bold.setTextSize(20.sp).setColor(MyColor.white))
                      )
                    ],
                  ),
                ),
              ),
            )),
            SizedBox(width: 10.w),
            Expanded(child: GestureDetector(
              child: WidgetSparkling(
                child: Container(
                  height: 200.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    image: const DecorationImage(
                        image: AssetImage(MyImage.monopolyImage),
                        fit: BoxFit.cover
                    ),
                  ),
                  padding: EdgeInsets.only(right: 10.w, left: 10.w, bottom: 10.w, top: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                            color: MyColor.black,
                            border: Border.all(),
                            shape: BoxShape.circle,
                            boxShadow: const [BoxShadow(color: MyColor.white, blurRadius: 10, spreadRadius: 8)]
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5.w),
                          child: const Icon(Icons.star_rounded, color: MyColor.white),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 4,
                        child: Text(
                          os.language.contentItemMonopoly,
                          style: Styles.def.bold.setTextSize(20.sp),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
          ]),
          Container(
            height: 170.w,
            margin: EdgeInsets.only(top: 10.w),
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              color: os.colorUi.fade,
              border: Border.all(color: MyColor.grey.withOpacity(0.2), width: 2.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(os.language.contentNewsSeeMatches,
                    style: Styles.def
                        .setColor(os.colorUi.reverse)
                        .italic.setTextSize(10.sp)
                ),
                Expanded(child: Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Row(
                        children: [
                          Text(os.language.contentNewStatus, style: Styles.def.setColor(os.colorUi.reverse)),
                          SizedBox(width: 10.w),
                          DecoratedBox(
                            decoration: BoxDecoration(
                                color: MyColor.white,
                                borderRadius: BorderRadius.circular(100.w)
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5.w, 3.w, 10.w, 3.w),
                              child: Row(children: [
                                const Icon(Icons.add, color: MyColor.greenFade),
                                Text("98", style: Styles.def.bold)
                              ]),
                            ),
                          ),
                        ],
                      )),
                      Row(children: [
                        _iconNews(MyImage.doubleFavourite),
                        _iconNews(MyImage.iconLetter),
                        _iconNews(MyImage.doubleGlass),
                        _iconNews(MyImage.doubleIconImage),
                      ]),
                      SizedBox(height: 10.w),
                    ],
                  ),
                  const Spacer(),
                  Image.asset(MyImage.nonsenseChart, color: os.colorUi.reverse, fit: BoxFit.cover)
                ]))
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget _iconNews(String icon) {
    return Align(
      widthFactor: 0.8,
      child: SizedBox(
        width: 33.w,
        height: 33.w,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: MyColor.white,
            border: Border.all(color: MyColor.black.withOpacity(0.3)),
            boxShadow: [BoxShadow(color: os.colorUi.reverse.withOpacity(0.2), blurRadius: 10)]
          ),
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Opacity(opacity: 0.5, child: Image.asset(icon)),
          ),
        ),
      ),
    );
  }

}