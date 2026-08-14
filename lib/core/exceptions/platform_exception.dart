class TPlatformException implements Exception {
  TPlatformException(this.code);
  final String code;
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'Email already in use';
      case 'invalid-email':
        return 'Invalid email';
      case 'weak-password':
        return 'Weak password';
      case 'operation-not-allowed':
        return 'Operation not allowed';
      case 'user-disabled':
        return 'User disabled';
      case 'too-many-requests':
        return 'Too many requests';
      case 'quota-exceeded':
        return 'Quota exceeded';
      case 'network-request-failed':
        return 'Network request failed';
      case 'internal-error':
        return 'Internal error';
      case 'credential-already-in-use':
        return 'Credential already in use';
      case 'account-exists-with-different-credential':
        return 'Account exists with different credential';
      case 'email-not-verified':
        return 'Email not verified';
      case 'email-verified':
        return 'Email verified';
      case 'email-varification-failed':
        return 'Email varification failed';
      case 'email-varification-success':
        return 'Email varification success';
      case 'wrong-password':
        return 'Wrong password';
      case 'user-mismatch':
        return 'User mismatch';
      case 'require-recent-login':
        return 'Require recent login';
      case 'provider-already-linked':
        return 'Provider already linked';
      case 'maximum-retry-exceeded':
        return 'Maximum retry exceeded';
      case 'too-many-attempts-try-again-in-30-minutes':
        return 'Too many attempts, try again in 30 minutes';

      case 'invalid-phone-number':
        return 'Invalid phone number';
      case 'invalid-password':
        return 'Invalid password';
      case 'invalid-username':
        return 'Invalid username';
      case 'invalid-profile-picture':
        return 'Invalid profile picture';
      case 'invalid-address':
        return 'Invalid address';
      case 'invalid-city':
        return 'Invalid city';
      case 'invalid-state':
        return 'Invalid state';
      case 'invalid-zip-code':
        return 'Invalid zip code';
      case 'invalid-country':
        return 'Invalid country';
      default:
        return 'Something went wrong';
    }
  }
}
