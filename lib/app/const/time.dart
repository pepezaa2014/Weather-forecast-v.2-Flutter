import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum Time {
  h24,
  h12,
}

extension TimeExtension on Time {
  String convertTimeInFutureWidget(int time) {
    final getTime = DateTime.fromMillisecondsSinceEpoch((time.toInt()) * 1000);
    switch (this) {
      case Time.h24:
        return DateFormat('H:mm', Get.locale?.languageCode).format(getTime);
      case Time.h12:
        return DateFormat('h:mm a', Get.locale?.languageCode).format(getTime);
    }
  }

  String convertTimeWithTimeZone(
    int time,
    int timeZone,
  ) {
    final localTimeZone =
        (DateTime.now().timeZoneOffset.inMilliseconds / 1000).round().toInt();
    final timeNow = DateTime.fromMillisecondsSinceEpoch((time) * 1000);
    final offsetTimeZone = timeZone - localTimeZone;
    DateTime convertedDateTime = timeNow.add(Duration(seconds: offsetTimeZone));

    switch (this) {
      case Time.h24:
        return DateFormat('dd MMM yyyy H:mm', Get.locale?.languageCode)
            .format(convertedDateTime);
      case Time.h12:
        return DateFormat('dd MMM yyyy h:mm a', Get.locale?.languageCode)
            .format(convertedDateTime);
    }
  }

  String convertTimeWithTimeZoneSun(
    int time,
    int timeZone,
  ) {
    final localTimeZone =
        (DateTime.now().timeZoneOffset.inMilliseconds / 1000).round().toInt();
    final timeNow = DateTime.fromMillisecondsSinceEpoch((time) * 1000);
    final offsetTimeZone = timeZone - localTimeZone;
    DateTime convertedDateTime = timeNow.add(Duration(seconds: offsetTimeZone));

    switch (this) {
      case Time.h24:
        return DateFormat('H:mm', Get.locale?.languageCode)
            .format(convertedDateTime);
      case Time.h12:
        return DateFormat('h:mm a', Get.locale?.languageCode)
            .format(convertedDateTime);
    }
  }
}
