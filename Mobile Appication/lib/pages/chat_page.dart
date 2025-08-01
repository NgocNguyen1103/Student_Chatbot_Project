import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../models/chat_session.dart';
import '../widgets/chat_bubble.dart';
import '../services/chat_services.dart';

class ChatPage extends StatefulWidget {
  final ChatSession session;
  final String token;

  const ChatPage({required this.session, required this.token, Key? key})
    : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = []; //
  final _controller = TextEditingController();
  final _scrollCtrl = ScrollController();
  bool _isSending = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory(); //
  }

  Future<void> _loadHistory() async {
    try {
      final history = await ChatService().getMessages(
        widget.session.id,
        widget.token,
      );
      setState(() {
        _messages.addAll(history);
        _loading = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() => _loading = false);
      print('Error loading history: $e');
    }
  }

  void _scrollToBottom() {
    // đảm bảo chạy sau khi build xong
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          id: null,
          chatSessionId: widget.session.id,
          sender: 'user',
          sequenceNo: _messages.length + 1,
          content: text,
          createdAt: DateTime.now(),
        ),
      );
      _isSending = true;
      _controller.clear();
    });
    _scrollToBottom();

    try {
      final respMap = await ChatService().continueChat(
        widget.session.id,
        text,
        widget.token,
      );

      final botMessage = ChatMessage.fromJson(
        respMap,
      ); // Vì API trả về 1 object, không phải list
      print(botMessage);
      setState(() {
        _messages.add(botMessage);
        _isSending = false;
      });
      _scrollToBottom();
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.session.title)),
      body: Column(
        children: [
          Expanded(
            child:
                _loading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      controller: _scrollCtrl,
                      itemCount: _messages.length,
                      itemBuilder: (_, i) => ChatBubble(message: _messages[i]),
                    ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask your question",
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                _isSending
                    ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : IconButton(
                      icon: Icon(Icons.send, color: Colors.black),
                      onPressed: _sendMessage,
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
