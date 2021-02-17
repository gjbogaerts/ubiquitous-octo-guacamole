abstract class Auth {
  Future<bool> login(String username, String password);
  Future<bool> register(String username, String password, String email);
  Future<bool> logout();
}
