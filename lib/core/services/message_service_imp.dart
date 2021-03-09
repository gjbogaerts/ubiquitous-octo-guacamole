import '../models/message.dart';

import './message_service.dart';

class MessageServiceImp extends MessageService {
  @override
  Future<Message> save(Map<String, dynamic> m) async {
    try {
      Message msg = Message();
      msg.set('message', m['message']);
      msg.set('sender', m['sender']);
      msg.set('receiver', m['receiver']);
      await msg.save();
      return msg;
    } catch (err) {
      return null;
    }
  }
}
