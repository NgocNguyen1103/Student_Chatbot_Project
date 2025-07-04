import 'package:flutter/material.dart';
import '../models/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Kiểm tra xem là tin nhắn của user hay bot
    final isUser = message.sender == 'user';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,

        children: [
          !isUser
              ? Row(

                children:[ CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(
                    Icons.smart_toy,
                    size: 18,
                    color: Colors.blue,
                  ),
                  radius: 16,
                ),
                  SizedBox(width: 8),

              ])
              : Container(),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.all(12),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
              color: isUser ? Colors.grey.shade200 : Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
                topLeft: isUser ? Radius.circular(12) : Radius.circular(5),
                topRight: isUser ? Radius.circular(5) : Radius.circular(12),
              ),
            ),
            child: Text(
              message.content,
              style: TextStyle(
                color: isUser ? Colors.black87 : Colors.white,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(width: 8),
          isUser
              ? Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.person, size: 18, color: Colors.blue),
                  radius: 16,
                ),
              )
              : Container(),
        ],
      ),
    );
  }
}
