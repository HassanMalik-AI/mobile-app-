import 'package:intl/intl.dart';

class TFormatter {
  static String formatDate(DateTime date) {
    if (date == DateTime.now()) {
      return 'Today';
    }
    return DateFormat('dd MMM yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en-US', symbol: '\$').format(amount);
  }

  //format phone number
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6, 10)}';
    } else if (phoneNumber.length == 11) {
      return '+1 (${phoneNumber.substring(1, 4)}) ${phoneNumber.substring(4, 7)}-${phoneNumber.substring(7, 11)}';
    }
    return phoneNumber;
  }

  //not fully tested
  static String internationalFormatPhoneNumber(String phoneNumber) {
    //remove any non digit caracter from the phone number
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');
    //extract the country code from the digits only
    String countryCode = '+${digitsOnly.substring(0, 2)}';
    //remove the country code from the digits only
    String phoneNo = digitsOnly.substring(2);
    //format the phone numberreturn '''
    return '($countryCode) $phoneNo';
  }
}
