import '../payment_status.dart';

class Month {
  final String title;
  final int number;
  final PaymentStatus status;
  final String year;

  const Month({this.number, this.title, this.status, this.year});
}
