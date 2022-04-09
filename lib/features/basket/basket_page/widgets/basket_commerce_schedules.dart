import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/utils/dates_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/features/basket/basket_page/widgets/basket_schedules_list.dart';
import 'package:chemin_du_local/features/commerces/commerce.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BasketCommerceSchedule extends StatefulWidget {
  const BasketCommerceSchedule({
    Key? key,
    required this.commerce,
    required this.onDateChoosed,
  }) : super(key: key);

  final Commerce commerce;

  final Function(DateTime) onDateChoosed;

  @override
  State<BasketCommerceSchedule> createState() => _BasketCommerceScheduleState();
}

class _BasketCommerceScheduleState extends State<BasketCommerceSchedule> {
  DateTime _day = DateTime.now();
  int _timeIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: ScreenHelper.horizontalPadding,
                vertical: 10
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Le titre
                  Text(
                    "Choix du créneau de retrait pour ${widget.commerce.name}",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(height: 12,),

                  // Le selecteur de date
                  Flexible(child: _buildDatePicker()),
                  const SizedBox(height: 8,),

                  // La liste des horraires
                  Flexible(
                    child: BasketSchedulesList(
                      commerce: widget.commerce,
                      currentDateIndex: _timeIndex,
                      onIndexChanged: (index) {
                        setState(() {
                          _timeIndex = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8,),

                  Flexible(
                    child: ClElevatedButton(
                      onPressed: _onDateChoosed,
                      child: const Text("Continuer"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }

  Widget _buildDatePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBackDayButton(),
              _buildNextDayButton() 
            ]
          ),
        ),

        Flexible(
          child: ClElevatedButton(
            onPressed: () {},
            borderRadius: BorderRadius.circular(1.0),
            child: Text(
              _day.isSameDate(DateTime.now()) 
                ? "Aujourd'hui"
                : DateFormat("dd/MM/yyyy").format(_day)
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBackDayButton() {
    bool isEnabled = !_day.isSameDate(DateTime.now());

    return InkWell(
      onTap: !isEnabled ? null : () {
        setState(() {
          _day = _day.subtract(const Duration(days: 1));
          _timeIndex = -1;
        });
      },
      child: Container(
        width: 32, height: 32,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(
            color: Theme.of(context).dividerColor
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0)
          )
        ),
        child: const Center(
          child: Icon(
            Icons.chevron_left
          ),
        ),
      ),
    );
  }

  Widget _buildNextDayButton() {
    return InkWell(
      onTap: () {
        setState(() {
          _day = _day.add(const Duration(days: 1));
          _timeIndex = -1;
        });
      },
      child: Container(
        width: 32, height: 32,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(
            color: Theme.of(context).dividerColor
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0)
          )
        ),
        child: const Center(
          child: Icon(
            Icons.chevron_right
          ),
        ),
      ),
    );
  }

  void _onDateChoosed() {
    final List<TimeOfDay> times = [
      const TimeOfDay(hour: 9, minute: 30),
      const TimeOfDay(hour: 10, minute: 30),
      const TimeOfDay(hour: 11, minute: 30),
      const TimeOfDay(hour: 12, minute: 30),
      const TimeOfDay(hour: 13, minute: 30),
      const TimeOfDay(hour: 14, minute: 30),
      const TimeOfDay(hour: 15, minute: 30),
      const TimeOfDay(hour: 16, minute: 30),
      const TimeOfDay(hour: 17, minute: 30),
    ];

    if (_timeIndex < 0) return;

    widget.onDateChoosed(
      DateTime(
        _day.year,
        _day.month,
        _day.day,
        times[_timeIndex].hour,
        times[_timeIndex].minute,
      )
    );
  }
}