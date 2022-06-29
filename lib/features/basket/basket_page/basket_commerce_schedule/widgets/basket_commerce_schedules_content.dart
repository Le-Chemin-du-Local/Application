
import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/utils/dates_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_commerce_schedule/widgets/basket_schedules_list.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BasketCommerceSchedulesContent extends StatefulWidget {
  const BasketCommerceSchedulesContent({
    Key? key,
    required this.commerce,
    required this.onDateChoosed,
  }) : super(key: key);

  final Commerce commerce;

  final Function(DateTime) onDateChoosed;

  @override
  State<BasketCommerceSchedulesContent> createState() => _BasketCommerceSchedulesContentState();
}

class _BasketCommerceSchedulesContentState extends State<BasketCommerceSchedulesContent> {
  late DateTime _day;
  late DateTime _firstOpennedDate;

  int _timeIndex = -1;
  DateTime? _dateChoosed;

  @override
  void initState() {
    super.initState();

    _day = DateTime.now();

    if (!(widget.commerce.clickAndCollectHours?.isEmpty ?? true)) {
      bool isOpen = false;
      do {
        _day = _day.add(const Duration(days: 1));
        
        isOpen = widget.commerce.clickAndCollectHours?.isOpen(_day.weekday) ?? false;
      } 
      while (!isOpen);

      _firstOpennedDate = _day;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.commerce.clickAndCollectHours?.isEmpty ?? true) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenHelper.instance.horizontalPadding,
          vertical: 12,
        ),
        child: const ClStatusMessage(
          type: ClStatusMessageType.info,
          message: "Ce commerce n'est pas encore ouvert pour le Click and collect...",
        )
      );
    }

    return Stack(
      children: [
        Positioned(
          top: 0, left: 0, right: 0,
          bottom: 64,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenHelper.instance.horizontalPadding,
                vertical: 10
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Le titre
                  Text(
                    "Choix du créneau de retrait pour",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(widget.commerce.name, style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w500
                  ),),
                  const SizedBox(height: 12,),

                  // Le selecteur de date
                  Flexible(child: _buildDatePicker()),
                  const SizedBox(height: 8,),

                  // La liste des horraires
                  Flexible(
                    child: BasketSchedulesList(
                      commerce: widget.commerce,
                      currentDateIndex: _timeIndex,
                      day: _day,
                      onIndexChanged: (index,date) {
                        setState(() {
                          _timeIndex = index;
                          _dateChoosed = date;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8,),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0, right: 0, bottom: 12,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenHelper.instance.horizontalPadding),
            child: ElevatedButton(
              onPressed: _onDateChoosed,
              child: const Text("Continuer"),
            ),
          ),
        )
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
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius:  BorderRadius.circular(1.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              _day.isSameDate(DateTime.now()) 
                ? "Aujourd'hui"
                : DateFormat("dd/MM/yyyy").format(_day),
              style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBackDayButton() {
    bool isEnabled = !_day.isSameDate(_firstOpennedDate);

    return InkWell(
      onTap: !isEnabled ? null : () {
        setState(() {
           bool isOpen = false;
          _timeIndex = -1;
          _dateChoosed = null;

          do {
            _day = _day.subtract(const Duration(days: 1));
            
            isOpen = widget.commerce.clickAndCollectHours?.isOpen(_day.weekday) ?? false;
          } 
          while (!isOpen);
        });
      },
      child: Container(
        width: 32, height: 32,
        decoration: BoxDecoration(
          color:  Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline
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
          bool isOpen = false;
          _timeIndex = -1;
          _dateChoosed = null;

          do {
            _day = _day.add(const Duration(days: 1));
            
            isOpen = widget.commerce.clickAndCollectHours?.isOpen(_day.weekday) ?? false;
          } 
          while (!isOpen);
        });
      },
      child: Container(
        width: 32, height: 32,
        decoration: BoxDecoration(
          color:  Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline
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
    if (_timeIndex < 0 || _dateChoosed == null) return;

    widget.onDateChoosed(
      _dateChoosed!
    );
  }
}