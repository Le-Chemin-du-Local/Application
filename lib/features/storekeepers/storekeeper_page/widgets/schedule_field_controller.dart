import 'package:chemin_du_local/features/commerces/schedule.dart';
import 'package:flutter/cupertino.dart';

class ScheduleFieldController extends ChangeNotifier {
  List<Schedule> _schedules = [];

  List<Schedule> get schedules => _schedules;
  set schedules(List<Schedule> newSchedules) {
    _schedules = newSchedules;
    notifyListeners();
  }

  void addEmptySchedule() {
    _schedules.add(const Schedule(opening: "", closing: ""));
    notifyListeners();
  }

  void clearSchedule() {
    _schedules.clear();
    notifyListeners();
  }

  void setOpening(int index, String newOpening) {
    _schedules[index] = _schedules[index].copyWith(opening: newOpening);
    notifyListeners();
  }

  void setClosing(int index, String newClosing) {
    _schedules[index] = _schedules[index].copyWith(closing: newClosing);
    notifyListeners();
  }
}