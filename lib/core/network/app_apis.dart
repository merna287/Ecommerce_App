abstract final class AppApis {
  AppApis._();

  static const String baseUrl = 'https://api.escuelajs.co/api/v1';
  // Auth
  static const String login = '/auth/login';
  static const String register = '/users';
  static const String profile = '/auth/profile';
  static const String refreshToken = '/auth/refresh-token';

  // Users
  static const String users = '/users';

  static String userById(int id) {
    return '/users/$id';
  }

  static const String checkUserAvailable = '/users/is-available';

  // Products
  static const String products = '/products';

  static String productById(int id) {
    return '/products/$id';
  }

  static String productBySlug(String slug) {
    return '/products/slug/$slug';
  }

  static String relatedProducts(int id) {
    return '/products/$id/related';
  }

  // Categories
  static const String categories = '/categories';

  static String categoryById(int id) {
    return '/categories/$id';
  }

  static String categoryBySlug(String slug) {
    return '/categories/slug/$slug';
  }

  static String categoryProducts(int id) {
    return '/categories/$id/products';
  }

  // Files
  static const String uploadFile = '/files/upload';

  static String file(String filename) {
    return '/files/$filename';
  }
}
