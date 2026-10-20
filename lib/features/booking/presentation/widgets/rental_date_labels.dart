import 'package:intl/intl.dart';

/// `14 Oct 2026, 08:00`
String rentalDateTimeLabel(DateTime value) =>
    DateFormat('d MMM yyyy, HH:mm').format(value);

/// `14 Oct 08:00`
String rentalDateTimeShort(DateTime value) =>
    DateFormat('d MMM HH:mm').format(value);
