import 'package:flutter/material.dart';
import '../models/chat_message.dart';
class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final bgColor    = message.isUser ? Colors.blue : Colors.grey.shade200;
    final textColor  = message.isUser ? Colors.white : Colors.black;
    final align      = message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius     = message.isUser
        ? BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
      bottomLeft: Radius.circular(16),
    )
        : BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
      bottomRight: Radius.circular(16),
    );

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.all(12),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: radius,
          ),
          child: Text(
            message.text,
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    );
  }
}