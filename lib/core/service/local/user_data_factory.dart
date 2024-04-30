import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:restaurant/core/service/local/interface/i_simple_user_data.dart';
import 'package:restaurant/core/service/remote/service_locator.dart';
import 'package:restaurant/core/service/simple_secure_user_data.dart';
import 'package:restaurant/core/service/simple_user_data.dart';
import 'package:restaurant/core/utilities/enums.dart';


mixin UserDataFactory {
  static ISimpleUserData createUserData(LocalDataType userDataType) {
    final isSecuredData = userDataType == LocalDataType.secured;

    if (isSecuredData) {
      return SimpleSecureData(ServiceLocator.instance<FlutterSecureStorage>());
    } else {
      return const SimpleLocalData();
    }
  }
}
