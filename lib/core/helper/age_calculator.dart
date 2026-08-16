


/// Utility for age-related calculations used across the app.
/// Kept as a static utility (no state) — pure functions, easy to unit test.
class AgeCalculator {
  AgeCalculator._(); // prevent instantiation

  static const int minAgeAllowed = 13; // e.g. COPPA baseline — adjust per your policy
  static const int adultAge = 18;

  /// Calculates precise age in years from a birth date.
  static int calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    final hasHadBirthdayThisYear = (today.month > birthDate.month) ||
        (today.month == birthDate.month && today.day >= birthDate.day);
    if (!hasHadBirthdayThisYear) age--;
    return age;
  }

  /// Returns true if user is under 18 (Alpha Gen flag).
  static bool isMinor(DateTime birthDate) {
    return calculateAge(birthDate) < adultAge;
  }

  /// Returns true if the birth date makes the user too young to use the app at all.
  static bool isBelowMinimumAge(DateTime birthDate) {
    return calculateAge(birthDate) < minAgeAllowed;
  }

  /// Validates a birth date is realistic (not future, not absurdly old).
  static String? validateBirthDate(DateTime? birthDate) {
    if (birthDate == null) return 'Please select your date of birth';
    if (birthDate.isAfter(DateTime.now())) return 'Birth date cannot be in the future';
    if (isBelowMinimumAge(birthDate)) {
      return 'You must be at least $minAgeAllowed years old to use this app';
    }
    return null; // valid
  }
}