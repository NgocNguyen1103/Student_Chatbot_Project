import 'package:flutter/material.dart';
import 'package:student_chatbot/services/auth_services.dart';
import 'package:student_chatbot/services/chat_services.dart';
import '../models/chat_session.dart';
import '../models/chat_message.dart';
import './chat_page.dart';
import '../widgets/settings_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  late String method;
  late String token;
  bool _isSending = false;
  late Future<Map<String, dynamic>?> _profile;
  final List<ChatSession> _sessions = [];
  late Future<List<ChatSession>> _sessionFuture;
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';
  List<ChatSession> _filteredSessions = [];

  void _sendMessage() async {
    final content = _controller.text;
    if (content.isEmpty) return;
    setState(() {
      _isSending = true; // Đánh dấu là đang gửi
    });

    // Gọi API tạo chat
    try {
      final response = await ChatService().startChat(content, token); // Gọi API
      // final session = response['session'];  // session info
      // final messages = response['message'];  // messages từ bot và user

      // 1. Lấy phần `session` ra dưới dạng Map
      final Map<String, dynamic> sessionJson =
          response['session'] as Map<String, dynamic>;
      // 2. Chuyển Map → ChatSession bằng factory constructor
      final ChatSession session = ChatSession.fromJson(sessionJson);
      print('Parsed session id: ${session.id}, title: ${session.title}');
      // final List<dynamic> msgsJson = response['messages'] as List<dynamic>;
      // final List<ChatMessage> messages = msgsJson
      //     .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
      //     .toList();
      // Sau khi có response, mở ChatPage
      _controller.clear();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatPage(session: session, token: token),
        ),
      );
    } catch (error) {
      print("Error: $error");
      // Bạn có thể hiển thị lỗi bằng snackbar nếu muốn
    } finally {
      setState(() {
        _isSending = false; // ✅ Cho phép gửi lại
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    method = args['method'];
    token = args["token"];
    _profile = AuthService().getProfile(token);
    _sessionFuture = ChatService().getSessions(token);
    _sessionFuture = ChatService().getSessions(token).then((sessions) {
      _filteredSessions = sessions; // Gán ban đầu
      return sessions;
    });
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
        backgroundColor: Color(0xFFF7F9FB),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(16, 60, 0, 20),
              child: Text(
                'Chat History',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            Expanded(
              child: FutureBuilder<List<ChatSession>>(
                future: _sessionFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return Center(child: CircularProgressIndicator());
                  if (snapshot.hasError) return Text("Error loading sessions");
                  if (!snapshot.hasData || snapshot.data!.isEmpty)
                    return Center(child: Text("No sessions"));

                  // Cập nhật danh sách gốc và lọc theo search
                  _sessions.clear();
                  _sessions.addAll(snapshot.data!);

                  final sessionsToShow =
                      _searchTerm.isEmpty
                          ? _sessions
                          : _sessions.where((session) {
                            return session.title.toLowerCase().contains(
                              _searchTerm.toLowerCase(),
                            );
                          }).toList();

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              _searchTerm = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search sessions...',
                            prefixIcon: Icon(Icons.search),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      // Expanded(
                      //   child: ListView.builder(
                      //     padding: EdgeInsets.zero,
                      //     itemCount: sessionsToShow.length,
                      //     itemBuilder: (context, index) {
                      //       final session = sessionsToShow[index];
                      //       return ListTile(
                      //         title: Text(session.title),
                      //         subtitle: Text("Session #${session.id}"),
                      //         onTap: () {
                      //           _searchController.clear();
                      //           _searchTerm = '';
                      //           Navigator.pop(context); // Close drawer
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder:
                      //                   (_) => ChatPage(
                      //                     session: session,
                      //                     token: token,
                      //                   ),
                      //             ),
                      //           );
                      //         },
                      //       );
                      //     },
                      //   ),
                      // ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: sessionsToShow.length,
                          itemBuilder: (context, index) {
                            final session = sessionsToShow[index];
                            return Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.grey.withOpacity(0.5),       // hiệu ứng gợn sáng
                                highlightColor: Colors.grey.withOpacity(0.2),    // hiệu ứng nhấn giữ
                                onTap: () {
                                  _searchController.clear();
                                  _searchTerm = '';
                                  Navigator.pop(context); // Close drawer
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => ChatPage(
                                            session: session,
                                            token: token,
                                          ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(session.title),
                                  subtitle: Text("Session #${session.id}"),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 65,
              child: FutureBuilder<Map<String, dynamic>?>(
                future: _profile,
                builder: (_, snap) {
                  if (snap.connectionState != ConnectionState.done)
                    return Center(child: CircularProgressIndicator());
                  if (snap.hasError) return Text(snap.error.toString());
                  if (snap.data == null) return Center(child: Text("Fail"));
                  final user = snap.data!;

                  return GestureDetector(
                    onTap: () {
                      showSettingsBottomSheet(context, user); //
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFFFDFEFF),
                        border: Border(top: BorderSide(color: Colors.grey.shade300)),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 12),
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            child: Icon(Icons.person, size: 18),
                          ),
                          SizedBox(width: 8),
                          Text(
                            user['user_name'] ?? "Unknown",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(width: 180,),
                          Icon(Icons.expand_less),
                          SizedBox(width: 12),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )

          ],
        ),
      ),

      body: Column(
        children: [
          Expanded(child: Center(child: Text("Good Morning"))),

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

// void _openSession(ChatSession session) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (_) => ChatPage(session: session, token: token,)),
//   );
// }
//
// void _startChat(String content) async {
//   try {
//     final response = await ChatService().startChat(content, _token!);
//     final session = response['session']; // session info
//     final messages = response['message']; // list of messages
//
//     // Mở trang ChatPage với session và message vừa gửi
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => ChatPage(
//           session: session,
//           messages: messages, // Truyền tin nhắn cho ChatPage
//         ),
//       ),
//     );
//   } catch (error) {
//     print('Error: $error');
//   }
// }
// void _sendMessage() {
//   // final text = _controller.text.trim();
//   // if (text.isEmpty) return;
//   //
//   // // final session = ChatSession(
//   // //   id: DateTime.now().millisecondsSinceEpoch.toString(),
//   // //   messages: [ChatMessage(text: text, isUser: true)],
//   // // );
//   //
//   // setState(() {
//   //   _sessions.insert(0, session);
//   // });
//   // _controller.clear();
//   //
//   // Navigator.push(
//   //   context,
//   //   MaterialPageRoute(builder: (_) => ChatPage(session: session)),
//   // );
// }
//
// void _deleteSession(int index) {
//   setState(() {
//     _sessions.removeAt(index);
//   });
// }
