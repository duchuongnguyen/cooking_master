extension CapExtension on String {
  String get inCaps =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach => this
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCaps)
      .join(" ");
}

String getDurationString(DateTime dateTime) {
  String differenceString;
  Duration duration = DateTime.now().difference(dateTime);

  if (duration.inDays ~/ 365 >= 2) {
    differenceString = '${(duration.inDays ~/ 365).toString()} years';
  } else if (duration.inDays ~/ 365 == 1) {
    differenceString = 'a year';
  } else if (duration.inDays >= 2) {
    differenceString = '${duration.inDays.toString()} days';
  } else if (duration.inDays == 1) {
    differenceString = 'a day';
  } else if (duration.inHours >= 2) {
    differenceString = '${duration.inHours.toString()} hours';
  } else if (duration.inHours == 1) {
    differenceString = 'a hour';
  } else if (duration.inMinutes >= 2) {
    differenceString = '${duration.inMinutes.toString()} minutes';
  } else if (duration.inMinutes == 1) {
    differenceString = 'a minute';
  } else {
    differenceString = 'less than a minutes';
  }

  return differenceString;
}
