import '../../keys/api.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../models/product.dart';

void initService() async {
  await Parse().initialize(
    b4appAppId,
    b4appParseApiUri,
    clientKey: b4appClientId,
    coreStore: await CoreStoreSharedPrefsImp.getInstance(),
    debug: true,
    autoSendSessionId: true,
    registeredSubClassMap: <String, ParseObjectConstructor>{
      'Product': () => Product(),
    },
  );
}
