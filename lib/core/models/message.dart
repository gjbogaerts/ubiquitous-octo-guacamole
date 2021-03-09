import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import './user.dart';

class Message extends ParseObject implements ParseCloneable {
  Message() : super(_keyTableName);
  Message.clone() : this();

  @override
  clone(Map map) => Message.clone()..fromJson(map);
  static const _keyTableName = 'Message';

  static const _keySender = 'sender';
  static const _keyReceiver = 'receiver';
  static const _keyMsg = 'message';

  User get sender => get<User>(_keySender);
  User get receiver => get<User>(_keyReceiver);
  String get message => get<String>(_keyMsg);

  set sender(User u) => set<User>(_keySender, u);
  set receiver(User u) => set<User>(_keyReceiver, u);
  set message(String m) => set<String>(_keyMsg, m);
}
