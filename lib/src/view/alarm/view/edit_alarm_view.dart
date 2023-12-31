import 'package:alarm/alarm.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_flutter/src/core/init/theme/theme_provider.dart';
import 'package:h2o_flutter/src/view/alarm/viewmodel/iedit_alarm_state.dart';

class EditAlarmView extends ConsumerStatefulWidget {
  final AlarmSettings? alarmSettings;

  const EditAlarmView({Key? key, this.alarmSettings}) : super(key: key);

  @override
  ConsumerState<EditAlarmView> createState() => _EditAlarmViewState();
}

class _EditAlarmViewState extends ConsumerState<EditAlarmView>
    with IEditAlarmState {
  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    "kAlarmCancel".tr(),
                    style: currentTheme.textTheme.displaySmall
                        ?.copyWith(color: Colors.blue),
                  ),
                ),
                TextButton(
                  onPressed: saveAlarm,
                  child: loading
                      ? const CircularProgressIndicator()
                      : Text(
                          "kAlarmSave".tr(),
                          style: currentTheme.textTheme.displaySmall
                              ?.copyWith(color: Colors.blue),
                        ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              getDay(),
              style: currentTheme.textTheme.displaySmall
                  ?.copyWith(color: Colors.blue),
            ),
            const SizedBox(
              height: 16,
            ),
            RawMaterialButton(
              elevation: 5,
              onPressed: pickTime,
              fillColor: Colors.grey[200],
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Text(
                  TimeOfDay.fromDateTime(selectedDateTime).format(context),
                  style: currentTheme.textTheme.displayLarge,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("kAlarmLoopAudio".tr(),
                    style: currentTheme.textTheme.headlineLarge),
                Switch(
                  value: loopAudio,
                  onChanged: (value) => setState(() => loopAudio = value),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("kAlarmVibrate".tr(),
                    style: currentTheme.textTheme.headlineLarge),
                Switch(
                  value: vibrate,
                  onChanged: (value) => setState(() => vibrate = value),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("kAlarmSystemVolume".tr(),
                    style: currentTheme.textTheme.headlineLarge),
                Switch(
                  value: volumeMax,
                  onChanged: (value) => setState(() => volumeMax = value),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("kAlarmShowNotification".tr(),
                    style: currentTheme.textTheme.headlineLarge),
                Switch(
                  value: showNotification,
                  onChanged: (value) =>
                      setState(() => showNotification = value),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("kAlarmSound".tr(),
                    style: currentTheme.textTheme.headlineLarge),
                DropdownButton(
                  value: assetAudio,
                  items: [
                    DropdownMenuItem<String>(
                      value: 'assets/sounds/water.mp3',
                      child: Text("kAlarmWater".tr(),
                          style: currentTheme.textTheme.headlineMedium),
                    ),
                    DropdownMenuItem<String>(
                      value: 'assets/nokia.mp3',
                      child: Text("kAlarmNokia".tr(),
                          style: currentTheme.textTheme.headlineMedium),
                    ),
                    DropdownMenuItem<String>(
                      value: 'assets/mozart.mp3',
                      child: Text("kAlarmMozart".tr(),
                          style: currentTheme.textTheme.headlineMedium),
                    ),
                    DropdownMenuItem<String>(
                      value: 'assets/star_wars.mp3',
                      child: Text("kAlarmStarWars".tr(),
                          style: currentTheme.textTheme.headlineMedium),
                    ),
                    DropdownMenuItem<String>(
                      value: 'assets/one_piece.mp3',
                      child: Text("kAlarmOnePiece".tr(),
                          style: currentTheme.textTheme.headlineMedium),
                    ),
                  ],
                  onChanged: (value) => setState(() => assetAudio = value!),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            if (!creating)
              TextButton(
                onPressed: deleteAlarm,
                child: Text(
                  "kAlarmDeleteAlarm".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.red),
                ),
              ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
