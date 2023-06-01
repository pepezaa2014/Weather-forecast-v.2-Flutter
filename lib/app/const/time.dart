import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum Time {
  h24,
  h12,
}

extension TimeExtension on Time {
  String convertTime(int time) {
    final afterTime =
        DateTime.fromMillisecondsSinceEpoch((time.toInt()) * 1000);
    switch (this) {
      case Time.h24:
        return DateFormat('H:mm', Get.locale?.languageCode).format(afterTime);
      case Time.h12:
        return DateFormat('h:mm a', Get.locale?.languageCode).format(afterTime);
    }
  }

  String convertTimeWithTimeZone(int time, int timeZone) {
    final timeNow = DateTime.fromMillisecondsSinceEpoch((time) * 1000);
    // final offsetTimeZone = 25200 - ();
    DateTime convertedDateTime = timeNow.add(Duration(seconds: timeZone));

    switch (this) {
      case Time.h24:
        return DateFormat('dd MMM yyyy H:mm', Get.locale?.languageCode)
            .format(convertedDateTime);
      case Time.h12:
        return DateFormat('dd MMM yyyy h:mm a', Get.locale?.languageCode)
            .format(convertedDateTime);
    }
  }

  String convertTimeWithTimeZoneSun(int time, int timeZone) {
    final timeNow = DateTime.fromMillisecondsSinceEpoch((time) * 1000);
    // final offsetTimeZone = 25200 - (timeZone);
    DateTime convertedDateTime = timeNow.add(Duration(seconds: timeZone));

    switch (this) {
      case Time.h24:
        return DateFormat('H:mm', Get.locale?.languageCode)
            .format(convertedDateTime);
      case Time.h12:
        return DateFormat('h:mm a', Get.locale?.languageCode)
            .format(convertedDateTime);
    }
  }

  //  DateTime? get locationTime {
  //   final current = DateTime.now().toUtc().millisecondsSinceEpoch;
  //   return DateTime.fromMillisecondsSinceEpoch(
  //     (current + ((timezone ?? 0) * 1000)),
  //     isUtc: true,
  //   );
  // }
}
