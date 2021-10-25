abstract class UserIRepositories{
  Future<String?> getToken();
  Future<void> setToken({required String token});
}