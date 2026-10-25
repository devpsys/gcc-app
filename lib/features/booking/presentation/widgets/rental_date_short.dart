import 'package:intl/intl.dart';

/// `14 Oct`
String rentalDateShort(DateTime value) => DateFormat('d MMM').format(value);
