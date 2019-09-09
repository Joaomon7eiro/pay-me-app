enum PaymentStatus { Paid, PaidLate, NotPaid, OnTime }

class Month {
  final String title;
  final PaymentStatus status;
  final Icon icon;
}
