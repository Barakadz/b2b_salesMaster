import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_master_app/config/constants.dart';

class WheelTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;
  final void Function(TimeOfDay) onChanged;

  const WheelTimePicker({
    super.key,
    required this.initialTime,
    required this.onChanged,
  });

  @override
  State<WheelTimePicker> createState() => _WheelTimePickerState();
}

class _WheelTimePickerState extends State<WheelTimePicker> {
  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;

  int selectedHour = 0;
  int selectedMinute = 0;

  @override
  void initState() {
    super.initState();
    selectedHour = widget.initialTime.hour;
    selectedMinute = widget.initialTime.minute;
    hourController = FixedExtentScrollController(initialItem: selectedHour);
    minuteController = FixedExtentScrollController(
        initialItem: (selectedMinute / 5).round()); // intervals of 5
  }

  void _onHourChanged(int index) {
    setState(() {
      selectedHour = index;
      widget.onChanged(TimeOfDay(hour: selectedHour, minute: selectedMinute));
    });
  }

  void _onMinuteChanged(int index) {
    setState(() {
      selectedMinute = index * 5;
      widget.onChanged(TimeOfDay(hour: selectedHour, minute: selectedMinute));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline)),
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(paddingS),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CupertinoPicker(
                looping: true,
                scrollController: hourController,
                itemExtent: 32,
                onSelectedItemChanged: _onHourChanged,
                children: List.generate(
                  24,
                  (i) => Center(child: Text(i.toString().padLeft(2, '0'))),
                ),
              ),
            ),
            const Text(":", style: TextStyle(fontSize: 24)),
            Expanded(
              child: CupertinoPicker(
                looping: true,
                scrollController: minuteController,
                itemExtent: 32,
                onSelectedItemChanged: _onMinuteChanged,
                children: List.generate(
                  12,
                  (i) {
                    final val = (i * 5).toString().padLeft(2, '0');
                    return Center(child: Text(val));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
