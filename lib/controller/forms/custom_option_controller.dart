import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/widgets/my_text_utils.dart';

enum Gender {
  male,
  female,
  none;

  const Gender();
}

class CustomOptionController extends MyController {
  int selectRadioButton = 0;
  int customRadioButton = 0;
  int customImageRadioButton = 0;
  Gender selectedGender = Gender.male;
  List<String> dummyTexts = List.generate(
      12, (index) => MyTextUtils.getDummyText(60, withEmoji: true));

  void onChangeCustomButton(int id) {
    customRadioButton = id;
    update();
  }

  void onChangeCustomImageRadioButton(int id) {
    customImageRadioButton = id;
    update();
  }

  void onSelectButton(int id) {
    selectRadioButton = id;
    update();
  }

  void onChangeGender(Gender? value) {
    selectedGender = value ?? selectedGender;
    update();
  }
}
