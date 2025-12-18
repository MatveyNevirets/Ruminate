abstract class LoginParams {}

class EmailLoginParams implements LoginParams {
  final String email, password;

  EmailLoginParams({required this.email, required this.password});
}

class GoogleLoginParams implements LoginParams {
  GoogleLoginParams();
}

class RegistrationEmailParams {
  final String email, password;

  RegistrationEmailParams({required this.email, required this.password});
}
