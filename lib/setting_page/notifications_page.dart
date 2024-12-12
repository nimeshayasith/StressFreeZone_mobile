import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  TimeOfDay _meditationReminderTime = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay _contentNotificationTime = const TimeOfDay(hour: 18, minute: 0);

  bool _meditationReminderEnabled = true;
  bool _contentNotificationEnabled = true;
  bool _promoOffersEnabled = false;

  Future<void> _selectTime(BuildContext context, TimeOfDay initialTime,
      Function(TimeOfDay) onTimeSelected) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (pickedTime != null && pickedTime != initialTime) {
      onTimeSelected(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text("Meditation reminders"),
              subtitle: Text(
                  _meditationReminderEnabled
                      ? "Set for ${_meditationReminderTime.format(context)}"
                      : "Disabled",
                  style: TextStyle(
                      color: _meditationReminderEnabled
                          ? Colors.black
                          : Colors.grey)),
              value: _meditationReminderEnabled,
              onChanged: (value) {
                setState(() {
                  _meditationReminderEnabled = value;
                });
              },
            ),
            if (_meditationReminderEnabled)
              Center(
                child: GestureDetector(
                  onTap: () => _selectTime(context, _meditationReminderTime,
                      (selectedTime) {
                    setState(() {
                      _meditationReminderTime = selectedTime;
                    });
                  }),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time, color: Colors.teal),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        _meditationReminderTime.format(context),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const Divider(),
            SwitchListTile(
              title: const Text("Content notifications"),
              subtitle: Text(
                  _contentNotificationEnabled
                      ? "Set for ${_contentNotificationTime.format(context)}"
                      : "Disabled",
                  style: TextStyle(
                      color: _contentNotificationEnabled
                          ? Colors.black
                          : Colors.grey)),
              value: _contentNotificationEnabled,
              onChanged: (value) {
                setState(() {
                  _contentNotificationEnabled = value;
                });
              },
            ),
            if (_contentNotificationEnabled)
              Center(
                child: GestureDetector(
                  onTap: () => _selectTime(context, _contentNotificationTime,
                      (selectedTime) {
                    setState(() {
                      _contentNotificationTime = selectedTime;
                    });
                  }),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time, color: Colors.teal),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        _contentNotificationTime.format(context),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const Divider(),
            SwitchListTile(
              title: const Text("Promo offers"),
              subtitle: const Text("Notify me about special prices"),
              value: _promoOffersEnabled,
              onChanged: (value) {
                setState(() {
                  _promoOffersEnabled = value;
                });
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Save the settings.............................................
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                child: const Text("Save Changes"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
