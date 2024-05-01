part of 'restaurant_remote_data_source.dart';
mixin _RestaurantEndPoints {
  static const String getRestaurants = "branches?lat=20.256565&long=30.556654654&company_id=3";
  static const String getCategories = "branch/";
  static String category(int id) => "$getCategories/$id/categories";
}