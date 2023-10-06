import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:h2o_flutter/src/core/const/strings.dart';

class ShortcutButton extends StatefulWidget {
  final void Function() refreshAlarms;

  const ShortcutButton({Key? key, required this.refreshAlarms})
      : super(key: key);

  @override
  State<ShortcutButton> createState() => _ShortcutButtonState();
}

class _ShortcutButtonState extends State<ShortcutButton> {
  bool showMenu = false;

  Future<void> onPressButton(int delayInHours) async {
    DateTime dateTime = DateTime.now().add(Duration(hours: delayInHours));

    if (delayInHours != 0) {
      dateTime = dateTime.copyWith(second: 0, millisecond: 0);
    }

    setState(() => showMenu = false);

    alarmPrint(dateTime.toString());

    final alarmSettings = AlarmSettings(
      id: DateTime.now().millisecondsSinceEpoch % 10000,
      dateTime: dateTime,
      assetAudioPath: 'assets/sounds/water.mp3',
      volumeMax: true,
    );

    await Alarm.set(alarmSettings: alarmSettings);

    widget.refreshAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onLongPress: () {
            setState(() => showMenu = true);
          },
          child: FloatingActionButton(
            onPressed: () => onPressButton(0),
            backgroundColor: Colors.red,
            heroTag: null,
            child:
                const Text(Strings.kAlarmRingNow, textAlign: TextAlign.center),
          ),
        ),
        if (showMenu)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () => onPressButton(24),
                child: const Text("+24h"),
              ),
              TextButton(
                onPressed: () => onPressButton(36),
                child: const Text("+36h"),
              ),
              TextButton(
                onPressed: () => onPressButton(48),
                child: const Text("+48h"),
              ),
            ],
          ),
      ],
    );
  }
}