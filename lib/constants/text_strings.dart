/// Centralized text/string constants for the FitAI Coach app.
/// Keeping every user-facing string here makes localization,
/// QA, and copy changes trivial — never hardcode strings in widgets.
class TText {
  TText._(); // Prevents instantiation

  // -------------------- GENERAL / COMMON --------------------
  static const String appName = "FitAI Coach";
  static const String age = "Age";
  static const String ok = "OK";
  static const String cancel = "Cancel";
  static const String yes = "Yes";
  static const String no = "No";
  static const String submit = "Submit";
  static const String next = "Next";
  static const String back = "Back";
  static const String skip = "Skip";
  static const String done = "Done";
  static const String save = "Save";
  static const String continueText = "Continue";
  static const String retry = "Retry";
  static const String close = "Close";
  static const String search = "Search";
  static const String loading = "Loading...";
  static const String tLoading = "Loading...";
  static const String comingSoon = "Coming Soon";
  static const String tBy = "by";
  static const String or = "OR";
  static const String and = "and";
  static const String termOfuse = "Term of use";
  static const String loginSubTitle = "Login to your account";

  // -------------------- ONBOARDING --------------------
  static const String onboardingTitle1 = "Perfect Form, Real Time.";
  static const String onboardingTitle2 = "Your AI Fitness Coach.";
  static const String onboardingTitle3 = "Train Together, Stay Accountable.";

  static const String onboardingSubtitle1 =
      "AI-powered motion tracking for instant feedback.";
  static const String onboardingSubtitle2 =
      "Personalized guidance, right in your pocket.";
  static const String onboardingSubtitle3 =
      "Link with a partner, share progress, and hit your goals side by side.";

  static const String onboardingSkip = "Skip";
  static const String onboardingGetStarted = "Get Started";

  // -------------------- PRIVACY / T&C --------------------
  static const String privacyPolicy = "Privacy Policy";
  static const String termsAndConditions = "Terms and Conditions";
  static const String iAgreeTo = "I agree to";

  // -------------------- SIGN IN / LOGIN --------------------
  static const String signinTitle = "Welcome Back";
  static const String signinSubtitle = "Login to your account";
  static const String loginTitle = "Welcome Back";
  static const String loginSubtitle = "Login to your account";
  static const String loginButton = "Login";
  static const String signIn = "Sign In";
  static const String rememberMe = "Remember Me";
  static const String orSignInWith = "Or sign in with";
  static const String dontHaveAnAccount = "Don't have an account?";

  // -------------------- SIGN UP --------------------
  static const String signupTitle = "Sign Up";
  static const String signupSubtitle = "Create Account";
  static const String signUp = "Sign Up";
  static const String createAccount = "Create Account";
  static const String orSignUpWith = "Or sign up with";
  static const String alreadyHaveAnAccount = "Already have an account?";
  static const String iAgreeToPrivacyPolicyAndTerms =
      "I agree to the Privacy Policy and Terms of Use";

  // -------------------- COMMON AUTH FORM FIELDS --------------------
  static const String firstName = "First Name";
  static const String lastName = "Last Name";
  static const String username = "Username";
  static const String email = "Email";
  static const String password = "Password";
  static const String confirmPassword = "Confirm Password";
  static const String phoneNo = "Phone Number";

  // -------------------- FORGOT / RESET PASSWORD --------------------
  static const String forgotPassword = "Forgot Password";
  static const String forgotPasswordTitle = "Forgot Password";
  static const String forgotPasswordSubtitle =
      "Enter your email address to receive a reset link";
  static const String forgotPasswordButton = "Reset Password";
  static const String resetPasswordSuccess =
      "Your password has been reset successfully";
  static const String tContinue = "Continue";
  static const String yourAccountCreatedTitle = "Your Account Created";
  static const String yourAccountCreatedSubTitle =
      "Your account has been created successfully";
  // -------------------- EMAIL VERIFICATION --------------------
  static const String verificationEmailTitle = "Verification Email";
  static const String verificationEmailSubtitle =
      "Enter your verification email address";

  static const String changeYourPasswordTitle = "Change your password";
  static const String changeYourPasswordSubtitle =
      "Create a strong new password to keep your account secure.";
  static const String confirmEmailTitle = "Confirm Email";
  static const String confirmEmailSubTitle = "Confirm your email address";
  static const String verificationEmailButton = "Send Verification Email";
  static const String verificationEmailSentSubtitle =
      "Verification email sent to your email address";
  static const String verificationEmailSentButton = "Login";

  static const String resendEmail = "Resend Email";
  static const String resendEmailSubtitle = "Resend verification email";
  static const String resendEmailButton = "Resend Email";

  static const String verifyEmailButton = "Verify Email";
  static const String verifyEmailButtonSubtitle = "Verify your email address";
  //static const String email = "Email";
  static const String confirmEmail = "Confirm Email";
  static const String confirmEmailButton = "Confirm Email";
  static const String confirmEmailButtonSubtitle = "Confirm your email address";

  // -------------------- FORM VALIDATION MESSAGES --------------------
  static const String validationFieldRequired = "This field is required";
  static const String validationEmailRequired = "Email is required";
  static const String validationEmailInvalid = "Enter a valid email address";
  static const String validationPasswordRequired = "Password is required";
  static const String validationPasswordLength =
      "Password must be at least 8 characters";
  static const String validationPasswordMismatch = "Passwords do not match";
  static const String validationPhoneInvalid = "Enter a valid phone number";
  static const String validationNameRequired = "Name is required";
  static const String validationTermsNotAccepted =
      "Please accept the Terms and Conditions to continue";

  // -------------------- ERROR / SUCCESS / EMPTY STATES --------------------
  static const String errorGeneric = "Something went wrong. Please try again.";
  static const String errorNoInternet =
      "No internet connection. Please check your network.";
  static const String errorTimeout = "Request timed out. Please try again.";
  static const String errorInvalidCredentials = "Invalid email or password.";
  static const String errorSomethingWentWrong = "Oops! Something went wrong";

  static const String successLoggedIn = "Logged in successfully";
  static const String successAccountCreated = "Account created successfully";
  static const String successProfileUpdated = "Profile updated successfully";
  static const String saveProfile = "Save Profile";

  static const String emptyStateNoData = "Nothing to show here yet";
  static const String emptyStateNoResults = "No results found";
  static const String emptyStateNoConnection = "You're offline";

  // -------------------- HOME / DASHBOARD --------------------
  static const String home = "Home";
  static const String workouts = "Workouts";
  static const String progress = "Progress";
  static const String profile = "Profile";
  static const String settings = "Settings";
  static const String logout = "Logout";
  static const String logoutConfirmation = "Are you sure you want to logout?";
}
