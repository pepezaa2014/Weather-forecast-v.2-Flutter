import 'package:intl/intl.dart';

enum Time {
  h24,
  h12,
}

extension TimeExtension on Time {
  int get keyValue {
    switch (this) {
      case Time.h24:
        return 0;
      case Time.h12:
        return 1;
    }
  }

  String convertTime(int time) {
    final afterTime =
        DateTime.fromMillisecondsSinceEpoch((time.toInt()) * 1000);
    switch (this) {
      case Time.h24:
        return DateFormat('H:mm').format(afterTime);
      case Time.h12:
        return DateFormat('h:mm a').format(afterTime);
    }
  }
}
