import 'package:intl/intl.dart';

NumberFormat arg = NumberFormat.currency(locale: "es_AR");
NumberFormat dolar = NumberFormat.currency(
  locale: "en_US",
  symbol: "\$",
);
DateFormat dateFormat = DateFormat("dd/MM/yyyy");
