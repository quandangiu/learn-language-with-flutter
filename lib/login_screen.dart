import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'main_navigation.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  String? _errorMessage;
  bool _isLoading = false;
  bool _isLoginTab = true; // true = Login, false = SignUp

  // Login Tab Controllers
  final TextEditingController _loginUsernameController = TextEditingController();
  final TextEditingController _loginPasswordController = TextEditingController();

  // SignUp Tab Controllers
  final TextEditingController _signupUsernameController = TextEditingController();
  final TextEditingController _signupEmailController = TextEditingController();
  final TextEditingController _signupPasswordController = TextEditingController();

  bool _obscureLoginPassword = true;
  bool _obscureSignupPassword = true;

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      final userCredential = await _authService.signInWithGoogle();
      if (userCredential != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainNavigation()),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleLogin() async {
    final username = _loginUsernameController.text.trim();
    final password = _loginPasswordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = "Vui lòng nhập tên người dùng và mật khẩu!");
      return;
    }

    setState(() => _isLoading = true);
    // Có thể thêm logic đăng nhập tại đây
    // Tạm thời cho phép đăng nhập
    await Future.delayed(Duration(milliseconds: 500));
    setState(() => _isLoading = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainNavigation()),
    );
  }

  Future<void> _handleSignUp() async {
    final username = _signupUsernameController.text.trim();
    final email = _signupEmailController.text.trim();
    final password = _signupPasswordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = "Vui lòng điền đầy đủ tất cả các trường!");
      return;
    }

    if (!email.contains('@')) {
      setState(() => _errorMessage = "Email không hợp lệ!");
      return;
    }

    setState(() => _isLoading = true);
    // Có thể thêm logic đăng ký tại đây
    await Future.delayed(Duration(milliseconds: 500));
    setState(() => _isLoading = false);

    // Sau khi đăng ký thành công, chuyển sang trang chính
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainNavigation()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4C9BF6),
              Color(0xFF64B5F6),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(height: 60),

                // Logo/Title
                Text(
                  "English Learning",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 40),

                // Tab Bar (Login / Sign Up)
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => setState(() => _isLoginTab = true),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _isLoginTab ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                            ),
                            child: Center(
                              child: Text(
                                "Log In",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: _isLoginTab ? Color(0xFF4C9BF6) : Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => setState(() => _isLoginTab = false),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: !_isLoginTab ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                            ),
                            child: Center(
                              child: Text(
                                "Log Up",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: !_isLoginTab ? Color(0xFF4C9BF6) : Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),

                // Login Form
                if (_isLoginTab) ...[
                  // Username Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _loginUsernameController,
                      decoration: InputDecoration(
                        hintText: "User name",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(Icons.person, color: Color(0xFF4C9BF6)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Password Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _loginPasswordController,
                      obscureText: _obscureLoginPassword,
                      decoration: InputDecoration(
                        hintText: "Passport",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(Icons.lock, color: Color(0xFF4C9BF6)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureLoginPassword ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onPressed: () => setState(() => _obscureLoginPassword = !_obscureLoginPassword),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      ),
                    ),
                  ),

                  SizedBox(height: 8),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot passport?",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Color(0xFF4C9BF6))
                          : Text(
                              "Log in",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4C9BF6),
                              ),
                            ),
                    ),
                  ),
                ],

                // Sign Up Form
                if (!_isLoginTab) ...[
                  // Username Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _signupUsernameController,
                      decoration: InputDecoration(
                        hintText: "User name",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(Icons.person, color: Color(0xFF4C9BF6)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Email Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _signupEmailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(Icons.email, color: Color(0xFF4C9BF6)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Password Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _signupPasswordController,
                      obscureText: _obscureSignupPassword,
                      decoration: InputDecoration(
                        hintText: "Passport",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(Icons.lock, color: Color(0xFF4C9BF6)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureSignupPassword ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onPressed: () => setState(() => _obscureSignupPassword = !_obscureSignupPassword),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleSignUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Color(0xFF4C9BF6))
                          : Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4C9BF6),
                              ),
                            ),
                    ),
                  ),
                ],

                SizedBox(height: 20),

                // Error Message
                if (_errorMessage != null)
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.withOpacity(0.5)),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red[300], fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),

                SizedBox(height: 24),

                // OR Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.white30, thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text("OR", style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ),
                    Expanded(child: Divider(color: Colors.white30, thickness: 1)),
                  ],
                ),

                SizedBox(height: 24),

                // Social Login Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Facebook
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.facebook, color: Color(0xFF1877F2), size: 28),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 20),
                    // Instagram
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.camera_alt, color: Colors.pink, size: 28),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 20),
                    // Google
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.g_mobiledata, color: Colors.red, size: 32),
                        onPressed: _isLoading ? null : _handleGoogleSignIn,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginUsernameController.dispose();
    _loginPasswordController.dispose();
    _signupUsernameController.dispose();
    _signupEmailController.dispose();
    _signupPasswordController.dispose();
    super.dispose();
  }
}
