class ChatMessage {
  final int? id;
  final int chatSessionId;
  final String sender;
  final int sequenceNo;
  final String content;
  final DateTime createdAt;

  ChatMessage({
    this.id,
    required this.chatSessionId,
    required this.sender,
    required this.sequenceNo,
    required this.content,
    required this.createdAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      chatSessionId: json['chat_session_id'],
      sender: json['sender'],
      sequenceNo: json['sequence_no'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
