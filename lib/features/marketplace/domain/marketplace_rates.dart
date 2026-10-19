/// Weekly is 5.6 times the daily rate. Monthly is 20 daily rates.
const minimumInsurancePerDay = 500;

int weeklyRate(int daily) => daily * 56 ~/ 10;

int monthlyRate(int daily) => daily * 20;

/// 1.5% of the daily rate, and never under [minimumInsurancePerDay].
int insurancePerDay(int daily) {
  final share = daily * 15 ~/ 1000;
  return share < minimumInsurancePerDay ? minimumInsurancePerDay : share;
}

/// Rate, one delivery, and insurance. The caution deposit is not included.
int stayTotal({required int daily, required int delivery, int days = 3}) {
  return daily * days + delivery + insurancePerDay(daily) * days;
}
