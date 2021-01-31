import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class DiagnosePageViewModel extends BaseModel {
  bool keyboard = false;

  DiagnosePageViewModel() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        keyboard = visible;
      },
    );
  }
}
