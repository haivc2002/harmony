import 'package:harmony/base_project/package_widget.dart';

class MatchController extends BaseController {
  MatchController(super.context);

  RandomSizeImage randomSizeItem = RandomSizeImage();

  List<String> list = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRELwePlVdJLxQfLb7NXX1io9qZA9psWNFsQ&s",
    "https://i.pinimg.com/736x/c1/3c/27/c13c279d0a09e8911729a1baa0002e2f.jpg",
    "https://i.pinimg.com/736x/04/ba/39/04ba3968993d149a1201b8eb3bc1282d.jpg",
    "https://i.pinimg.com/736x/8a/06/f8/8a06f8cd5da8a4e3a4a2d6ef7a908b6f.jpg",
    "https://i.pinimg.com/736x/8b/1c/1f/8b1c1f1db3d8c162b79c46c02f855124.jpg",
  ];
}

class RandomSizeImage {
  double perform(int index) {
    if (index == 0) return 1 / 1;
    int mod = (index - 1) % 4;
    if (mod == 0 || mod == 1) {
      return 3 / 4;
    } else {
      return 1 / 1;
    }
  }
}