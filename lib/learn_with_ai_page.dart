import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LearnWithAIPage extends StatefulWidget {
  final String title;
  final String imagePath;

  const LearnWithAIPage({
    required this.title,
    required this.imagePath,
    super.key,
  });

  @override
  State<LearnWithAIPage> createState() => _LearnWithAIPageState();
}

class _LearnWithAIPageState extends State<LearnWithAIPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final ScrollController _scrollController = ScrollController();

  bool _showChat = false;
  bool _loading = false;

  late String _huggingfaceApiKey;
  late String _huggingfaceApiUrl;
  late String _huggingfaceModel;

  @override
  void initState() {
    super.initState();
    _initHuggingFace();
  }

  Future<void> _initHuggingFace() async {
    try {
      print("🔍 [Init] Bắt đầu tải .env...");
      await dotenv.load(fileName: ".env");
      print("✅ [Init] File .env tải thành công");

      final apiKey = dotenv.env['HUGGINGFACE_API_KEY'] ?? '';
      final apiUrl = dotenv.env['HUGGINGFACE_API_URL'] ?? '';
      final model = dotenv.env['HUGGINGFACE_MODEL'] ?? '';
      
      print("🔑 [Init] API Key length: ${apiKey.length}");
      print("🌐 [Init] API URL: $apiUrl");
      print("🤖 [Init] Model: $model");

      if (apiKey.isEmpty || apiUrl.isEmpty || model.isEmpty) {
        print("❌ [Init] Thiếu thông tin cấu hình!");
        return;
      }

      _huggingfaceApiKey = apiKey;
      _huggingfaceApiUrl = apiUrl;
      _huggingfaceModel = model;
      print("✅ [Init] Hugging Face API đã sẵn sàng!");
    } catch (e) {
      print("❌ [Init] Lỗi: $e");
    }
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    print("💬 [Send] Người dùng gửi: $text");

    setState(() {
      _messages.add({"type": "user", "text": text});
      _controller.clear();
      _loading = true;
    });

    _scrollToBottom();

    try {
      // Kiểm tra từ khóa chào hỏi
      final lowerText = text.toLowerCase();
      final greetings = ['hi', 'hello', 'hi guy'];
      final isGreeting = greetings.any((greeting) => lowerText.contains(greeting));

      String reply;
      if (isGreeting) {
        print("✅ [Send] Phát hiện lời chào");
        reply = "Hello, what topic would you like to learn about today? Please give me a suggestion.";
      } else {
        print("🤖 [Send] Gọi Hugging Face API");
        reply = await _callHuggingFace(text);
      }

      setState(() {
        _messages.add({"type": "ai", "text": reply});
      });
    } catch (e) {
      print("❌ [Send] Lỗi: $e");
      setState(() {
        _messages.add({
          "type": "ai",
          "text": "Sorry, something went wrong. Please try again! 😅"
        });
      });
    } finally {
      setState(() => _loading = false);
      _scrollToBottom();
    }
  }

  Future<String> _callHuggingFace(String message) async {
    try {
      if (_huggingfaceApiKey.isEmpty) {
        throw Exception("API Key không có");
      }

      final systemPrompt = """
You are a friendly, patient English teacher helping a student practice real-life conversations.
Current situation: ${widget.title}

Rules:
- Reply naturally and conversationally
- If user speaks English → respond in the situation + gentle correction if needed
- If user writes Vietnamese → reply in Vietnamese + English translation + encouragement
- Keep reply short (2-4 sentences)
- End with a question to continue
- Add emoji sometimes""";

      print("📤 [HuggingFace] Gửi request...");
      print("🌐 [HuggingFace] Model: $_huggingfaceModel");

      final url = Uri.parse(_huggingfaceApiUrl);

      final response = await http 
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $_huggingfaceApiKey',
            },
            body: jsonEncode({
              'model': _huggingfaceModel,
              'messages': [
                {
                  'role': 'system',
                  'content': systemPrompt,
                },
                {
                  'role': 'user',
                  'content': message,
                }
              ],
              'temperature': 0.7,
              'max_tokens': 500,
            }),
          )
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              print("❌ [HuggingFace] Timeout");
              throw TimeoutException("API timeout");
            },
          );

      print("📥 [HuggingFace] Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices']?[0]?['message']?['content'] ??
            'No response';
        print("✅ [HuggingFace] Response: $content");
        return content;
      } else {
        print("❌ [HuggingFace] Error status ${response.statusCode}");
        print("❌ [HuggingFace] Body: ${response.body}");
        final errorData = jsonDecode(response.body);
        final errorMsg = errorData['error']?['message'] ?? 'Unknown error';
        throw Exception(errorMsg);
      }
    } catch (e) {
      print("❌ [HuggingFace] Exception: $e");
      rethrow;
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildBubble(String text, bool isUser) {
    return Row(
      mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isUser) _avatar("AI", Colors.deepPurple),
        if (!isUser) const SizedBox(width: 10),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              gradient: isUser
                  ? const LinearGradient(
                      colors: [Color(0xFF4C9BF6), Color(0xFF2196F3)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: isUser ? null : Colors.grey[100],
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(isUser ? 20 : 4),
                bottomRight: Radius.circular(isUser ? 4 : 20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: isUser ? Colors.white : Colors.black87,
                fontWeight: isUser ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        ),
        if (isUser) const SizedBox(width: 10),
        if (isUser) _avatar("You", const Color(0xFF4C9BF6)),
      ],
    );
  }

  Widget _avatar(String text, Color color) => Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text == "AI" ? "🤖" : "👤",
            style: const TextStyle(fontSize: 18),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Learn with AI",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4C9BF6), Color(0xFF2196F3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: _showChat ? _chatUI() : _previewUI(),
    );
  }

  Widget _previewUI() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[50]!, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  widget.imagePath,
                  width: 240,
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Color(0xFF1565C0),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Tap to start practicing English!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () => setState(() => _showChat = true),
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4C9BF6), Color(0xFF2196F3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4C9BF6).withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.chat_bubble_rounded,
                  size: 55,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Start Chat",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chatUI() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[50]!, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              child: Image.asset(
                widget.imagePath,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (_messages.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.blue[100]!, Colors.blue[50]!],
                        ),
                      ),
                      child: const Icon(
                        Icons.chat_bubble_outline,
                        size: 60,
                        color: Color(0xFF4C9BF6),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Start your conversation",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4C9BF6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Say something to begin...",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: _messages.length,
                itemBuilder: (_, i) {
                  final msg = _messages[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildBubble(msg["text"] as String, msg["type"] == "user"),
                  );
                },
              ),
            ),
          if (_loading)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        const Color(0xFF4C9BF6),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "AI is thinking...",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: TextField(
                        controller: _controller,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _sendMessage(),
                        decoration: InputDecoration(
                          hintText: "Type your message...",
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4C9BF6), Color(0xFF2196F3)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4C9BF6).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: _loading ? null : _sendMessage,
                      icon: const Icon(Icons.send_rounded, color: Colors.white),
                      iconSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
