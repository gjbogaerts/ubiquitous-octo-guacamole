import '../../keys/api.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../models/product.dart';
import '../models/user.dart';

Future<void> initService() async {
  await Parse().initialize(
    b4appAppId,
    b4appParseApiUri,
    clientKey: b4appClientId,
    coreStore: await CoreStoreSharedPrefsImp.getInstance(),
    debug: true,
    autoSendSessionId: true,
    parseUserConstructor: (username, password, emailAddress,
            {client, debug, sessionToken}) =>
        User(username, password, emailAddress),
    registeredSubClassMap: <String, ParseObjectConstructor>{
      'Product': () => Product(),
    },
  );
}
