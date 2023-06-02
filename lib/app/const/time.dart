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

  String currentTime(
    int time,
    int timeZone,
  ) {
    final current = DateTime.now().toUtc().millisecondsSinceEpoch;
    DateTime convertedDateTime = DateTime.fromMillisecondsSinceEpoch(
      (current + (timeZone * 1000)),
      isUtc: true,
    );

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
    DateTime convertedDateTime = DateTime.fromMillisecondsSinceEpoch(
      (time + timeZone) * 1000,
      isUtc: true,
    );

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
