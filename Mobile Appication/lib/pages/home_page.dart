import 'package:flutter/material.dart';
import 'package:student_chatbot/services/auth_services.dart';
import '../models/chat_session.dart';
import '../models/chat_message.dart';
import './chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  late String method;
  late String token;
  late Future<Map<String, dynamic>?> _profile;
  final List<ChatSession> _sessions = [];

  void _openSession(ChatSession session) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ChatPage(session: session)),
    );
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final session = ChatSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      messages: [ChatMessage(text: text, isUser: true)],
    );

    setState(() {
      _sessions.insert(0, session);
    });
    _controller.clear();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ChatPage(session: session)),
    );
  }

  void _deleteSession(int index) {
    setState(() {
      _sessions.removeAt(index);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    method = args['method'];
    token = args["token"];
    _profile = AuthService().getProfile(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 52.0),
          child: Row(
            children: [
              Image.asset(
                "assets/images/white_try_logo.png",
                width: 40,
                height: 40,
              ),
              Text(
                'StudentChat',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: FutureBuilder<Map<String, dynamic>?>(
                future: _profile,
                builder: (_, snap) {
                  if (snap.connectionState != ConnectionState.done)
                    return Center(child: CircularProgressIndicator());
                  if (snap.hasError) return Text(snap.error.toString());
                  if (snap.data == null) return Center(child: Text("Fail"));
                  final user = snap.data!;
                  return ListTile(
                    title: Text(user["username"]),
                    subtitle: Text(user["email"]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _sessions.length,
              itemBuilder: (ctx, i) {
                final sess = _sessions[i];
                return ListTile(
                  title: Text(
                    sess.messages.first.text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text('Session ${i + 1}'),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'open') {
                        _openSession(sess);
                      } else if (value == 'delete') {
                        _deleteSession(i);
                      }
                    },
                    itemBuilder:
                        (_) => [
                          PopupMenuItem(value: 'open', child: Text("Open")),
                          PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                  ),
                );
              },
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
                      hintText: "Start a new chat",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
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
