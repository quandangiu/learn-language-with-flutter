# English Learning App with AI Assistant 🎓📱

A comprehensive Flutter-based mobile application designed to help users learn English through interactive scenarios, AI-powered conversations, and personalized study plans. This app combines modern UI/UX design with powerful AI capabilities to create an engaging and effective language learning experience.


<img width="456" height="1034" alt="image" src="https://github.com/user-attachments/assets/9f3d7c83-7013-4ebf-afd3-52c7d221ee7a" />


## 🌟 Features

### 🔐 Authentication System
- **Firebase Authentication** integration for secure user management
- **Google Sign-In** support for seamless login experience
- Cross-platform authentication (Web, iOS, Android)
- Persistent user sessions with automatic state management

### 🤖 AI-Powered Learning (Learn with AI)
- Interactive chatbot powered by **Hugging Face API**
- Real-time conversation practice with AI assistant
- Context-aware responses for natural language learning
- Speech bubble UI with smooth animations
- Automatic greeting detection and contextual responses
- Support for various learning topics and scenarios

### 🎬 Scene-Based Learning
- **Practical scenario-based lessons** covering real-life situations:
  - **Grocery Shopping**: Learn vocabulary for prices, items, and payment
  - **Classroom Interaction**: Practice academic discussions and expressing opinions
  - **Airport Security Check**: Master travel-related communication
  - **Birthday Party**: Develop social conversation skills
- Each scene includes:
  - Detailed descriptions and learning objectives
  - Categorized tags (Daily Life, School Life, Travel, Social Events)
  - Custom illustrations and visual aids
  - Interactive dialogue practice
  - Multiple-choice questions for comprehension

### 📅 Study Plan & Progress Tracking
- **Personalized calendar-based study planner**
- Visual progress tracking with:
  - Study streak counter
  - Completed days highlighting
  - Planned activities overview
- **Daily task management** with:
  - Vocabulary practice sessions
  - Speaking practice exercises
  - Duration tracking for each activity
  - Completion status indicators
- Monthly view with easy date navigation
- Statistics and achievements display

### 👤 User Profile
- Personal profile management
- Learning statistics and achievements
- Study history and progress visualization
- Account settings and preferences

### 🎨 Modern UI/UX Design
- Clean and intuitive Material Design interface
- Smooth animations and transitions
- Responsive layout for all screen sizes
- Custom gradient backgrounds and themed components
- Professional color scheme (Blue #4C9BF6 as primary)

## 🛠️ Technology Stack

### Frontend
- **Flutter** (SDK ^3.9.2) - Cross-platform mobile framework
- **Dart** - Programming language
- **Material Design** - UI component library

### Backend & Services
- **Firebase Core** (^4.1.1) - Backend infrastructure
- **Firebase Auth** (^6.1.0) - User authentication
- **Google Sign-In** (6.3.0) - OAuth integration
- **Hugging Face API** - AI language model integration

### Additional Libraries
- **http** (^1.1.0) - HTTP requests for API calls
- **intl** (^0.19.0) - Internationalization and date formatting
- **google_generative_ai** (^0.4.3) - AI content generation
- **flutter_dotenv** (^5.1.0) - Environment variable management
- **cupertino_icons** (^1.0.8) - iOS-style icons

## 📦 Project Structure

```
lib/
├── main.dart                 # App entry point and Firebase initialization
├── auth_service.dart         # Authentication service logic
├── login_screen.dart         # Login UI and authentication flow
├── main_navigation.dart      # Bottom navigation bar and routing
├── home_screen.dart          # Dashboard and main features
├── learn_with_ai_page.dart   # AI chatbot interface and logic
├── scene_list_page.dart      # Scenario-based learning catalog
├── scene_detail_page.dart    # Individual scene learning interface
├── study_plan_page.dart      # Calendar and task management
└── profile_page.dart         # User profile and settings
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (version 3.9.2 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Firebase account
- Hugging Face API key

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/quandangiu/learn-language-with-flutter.git
   cd learn-language-with-flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place configuration files in appropriate directories:
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`
   - Update Firebase configuration in `main.dart` with your project credentials

4. **Set up environment variables**
   
   Create a `.env` file in the root directory:
   ```env
   HUGGINGFACE_API_KEY=your_huggingface_api_key
   HUGGINGFACE_API_URL=https://api-inference.huggingface.co/models/
   HUGGINGFACE_MODEL=your_model_name
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

**Android:**
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

## 🔧 Configuration

### Firebase Setup
The app requires Firebase configuration for both web and mobile platforms. Update the Firebase options in `main.dart`:

```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: 'YOUR_API_KEY',
    authDomain: 'YOUR_AUTH_DOMAIN',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_STORAGE_BUCKET',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    appId: 'YOUR_APP_ID',
    measurementId: 'YOUR_MEASUREMENT_ID',
  ),
);
```

### Hugging Face API
The AI chat feature uses Hugging Face's inference API. Make sure to:
1. Create an account at [Hugging Face](https://huggingface.co/)
2. Generate an API token
3. Choose an appropriate model (e.g., `meta-llama/Llama-2-7b-chat-hf`)
4. Add credentials to `.env` file

## 📱 App Screenshots

### Home Screen
The main dashboard provides quick access to all learning features and displays your progress:

![Home Screen](screenshots/home_screen.png)

**Key Features Shown:**
- 🏠 **Personalized Greeting**: Welcome message with user's name
- 📊 **Study Statistics**: 
  - Consecutive study days tracker
  - Total study hours
  - Completed courses counter
- 📅 **Daily Progress**: Real-time tracking of today's study goals with visual progress bar
- 🎯 **Current Study Courses**: Quick access to ongoing lessons
- 💡 **Recommended Courses**: Personalized course suggestions
- 🤖 **AI Assistant**: Direct access to AI-powered learning chat

### Main Features
- 🏠 **Home Screen**: Quick access to all learning modules
- 💬 **AI Chat**: Interactive conversation with AI tutor
- 🎭 **Scene Learning**: Situational dialogue practice
- 📊 **Study Plan**: Track progress and manage daily goals
- 👤 **Profile**: View achievements and statistics

## 🎯 Key Functionalities

### AI Learning System
- Natural language processing for conversation
- Context retention across chat sessions
- Adaptive responses based on user input
- Support for multiple learning topics
- Real-time message streaming

### Scene Learning Module
- 4+ pre-built learning scenarios
- Expandable scene library
- Interactive dialogue systems
- Comprehension quizzes
- Progress tracking per scene

### Study Management
- Daily task creation and tracking
- Calendar-based planning
- Streak counting for motivation
- Activity duration monitoring
- Completion statistics

## 🔒 Security Features
- Secure Firebase authentication
- OAuth 2.0 with Google Sign-In
- Environment variable protection for API keys
- Secure HTTPS API calls
- User data encryption

## 🌐 Platform Support
- ✅ Android (5.0 and above)
- ✅ iOS (11.0 and above)
- ✅ Web (Chrome, Firefox, Safari, Edge)

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📞 Contact & Support

For questions, suggestions, or support:
- Create an issue in the GitHub repository
- Email:  quandinh3011@gmail.com
- Project Link: [https://github.com/quandangiu/learn-language-with-flutter](https://github.com/quandangiu/learn-language-with-flutter)

## 🙏 Acknowledgments

- [Flutter Team](https://flutter.dev/) for the amazing framework
- [Firebase](https://firebase.google.com/) for backend services
- [Hugging Face](https://huggingface.co/) for AI capabilities
- All contributors who help improve this project

## 📚 Documentation & Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Hugging Face Documentation](https://huggingface.co/docs)
- [Material Design Guidelines](https://material.io/design)

---

**Made with ❤️ using Flutter**





