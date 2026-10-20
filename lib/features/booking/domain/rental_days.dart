/// Calendar days billed for a stay. End must be after start.
///
/// Days are counted from the collection calendar date to the return calendar
/// date (14 Oct → 17 Oct is 3 days). A same-day stay bills as 1 day.
int rentalDays(DateTime from, DateTime to) {
  if (!to.isAfter(from)) {
    return 0;
  }
  final start = DateTime(from.year, from.month, from.day);
  final end = DateTime(to.year, to.month, to.day);
  final days = end.difference(start).inDays;
  return days == 0 ? 1 : days;
}
