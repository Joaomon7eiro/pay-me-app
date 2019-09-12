import 'package:flutter/material.dart';

enum PaymentStatus { Paid, PaidLate, NotPaid, OnTime }

String paymentStatus(monthStatus) {
  switch (monthStatus) {
    case PaymentStatus.NotPaid:
      return 'Não Pago';
    case PaymentStatus.Paid:
      return 'Pago';
    case PaymentStatus.PaidLate:
      return 'Pago Atrasado';
    case PaymentStatus.OnTime:
      return 'No Tempo';
    default:
      return 'Desconhecido';
  }
}

IconData paymentIcon(monthStatus) {
  switch (monthStatus) {
    case PaymentStatus.NotPaid:
      return Icons.error;
    case PaymentStatus.Paid:
      return Icons.check_circle;
    case PaymentStatus.PaidLate:
      return Icons.warning;
    case PaymentStatus.OnTime:
      return Icons.access_time;
    default:
      return Icons.access_time;
  }
}

Color paymentColor(monthStatus) {
  switch (monthStatus) {
    case PaymentStatus.NotPaid:
      return Colors.red.shade300;
    case PaymentStatus.Paid:
      return Colors.green.shade300;
    case PaymentStatus.PaidLate:
      return Colors.orange.shade300;
    case PaymentStatus.OnTime:
      return Colors.blue.shade200;
    default:
      return Colors.blue.shade200;
  }
}

PaymentStatus paymentIndex(index) {
  switch (index) {
    case 0:
      return PaymentStatus.NotPaid;
    case 1:
      return PaymentStatus.Paid;
    case 2:
      return PaymentStatus.PaidLate;
    case 3:
      return PaymentStatus.OnTime;
    default:
      return PaymentStatus.OnTime;
  }
}
