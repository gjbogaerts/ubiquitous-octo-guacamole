import '../models/message.dart';

abstract class MessageService {
  Future<Message> save(Map<String, dynamic> m);
}
