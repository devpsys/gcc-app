/// 1.5% card processing fee, truncated to whole naira (MOB-VND-06).
int cardFeeFor(int amountDue) => (amountDue * 15) ~/ 1000;

int totalWithCardFee(int amountDue) => amountDue + cardFeeFor(amountDue);
