class ChatRepository {
  static final ChatRepository _singleton = ChatRepository._internal();
  static ChatRepository getInstance() => _singleton;
  ChatRepository._internal();
}