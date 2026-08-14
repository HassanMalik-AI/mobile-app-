class TFormatException implements Exception {
  final String message;

  ///default constructor with a generic message error
  const TFormatException([
    this.message = 'An unexpected format error occurred',
  ]);

  ///create a format exception from a specific error message
  factory TFormatException.fromMessage(String message) {
    return TFormatException(message);
  }

  ///get the corresponding format error message
  String get formattedMessage => message;

  //create a format exception from a specific error code
  factory TFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return TFormatException('Invalid email');
      case 'invalid-password':
        return TFormatException('Invalid password');
      case 'invalid-username':
        return TFormatException('Invalid username');
      case 'invalid-profile-picture':
        return TFormatException('Invalid profile picture');
      case 'invalid-address':
        return TFormatException('Invalid address');
      case 'invalid-city':
        return TFormatException('Invalid city');
      case 'invalid-state':
        return TFormatException('Invalid state');
      case 'invalid-zip-code':
        return TFormatException('Invalid zip code');
      case 'invalid-country':
        return TFormatException('Invalid country');
      default:
        return TFormatException('Something went wrong');
    }
  }
}
