class TFirebaseAuthException implements Exception {
  TFirebaseAuthException(this.code);
  final String code;
  String get message {
    switch (code) {
      case 'user-not-found':
        return 'User not found';
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
      case 'email already in use':
        return 'Email already in use';
      case 'network-request-failed':
        return 'Network request failed';
      case 'invalid-credential':
        return 'Invalid credential';
      case 'requires-recent-login':
        return 'Requires recent login';
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
      default:
        return 'Something went wrong';
    }
  }

  String getErrorMessage() {
    return message;
  }

  String getLocalizedMessage(String code) {
    // TODO: Implement locale-aware message lookup (e.g., from JSON files)
    throw UnimplementedError();
  }
}
