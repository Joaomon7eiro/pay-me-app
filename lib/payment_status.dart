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
