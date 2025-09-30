import 'package:ecommunity/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:ecommunity/ai_assistant.dart';
import 'package:ecommunity/about.dart';
import 'package:ecommunity/signup.dart';
import 'dart:io';
import 'package:ecommunity/signup.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const App());
}

// Data model for a social media post
class Post {
  final String username;
  final String userAvatarUrl;
  final String postImageUrl;
  final String caption;

  Post({
    required this.username,
    required this.userAvatarUrl,
    required this.postImageUrl,
    required this.caption,
  });
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode _theme = ThemeMode.dark;

  void changeTheme() {
    setState(() {
      _theme = _theme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
          primary: AppColors.primary,
          surface: AppColors.lightBackground,
          secondary: AppColors.secondary,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
          primary: AppColors.primary,
          surface: AppColors.background,
          secondary: AppColors.secondary,
        ),
      ),
      themeMode: _theme,
      home: HomePage(title: 'Ecommunity', changeTheme: changeTheme),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, required this.changeTheme});

  final String title;
  final VoidCallback changeTheme;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Dummy data for the posts
  final List<Post> posts = [
    Post(
      username: 'ecofriendly',
      userAvatarUrl: 'https://i.pravatar.cc/150?img=1',
      postImageUrl:
          'https://media.istockphoto.com/id/1659684092/pt/foto/a-view-up-into-the-trees-direction-sky.jpg?s=1024x1024&w=is&k=20&c=w_bm_55yc8QGZwvdAHvr7ByWnihRyPDKGaT8OUMXl3w=',
      caption:
          '“Just swapped out all my plastic bags for reusable cotton ones! Small steps make a big impact 🌍♻️ #PlasticFree #Sustainability”',
    ),
    Post(
      username: 'eco',
      userAvatarUrl: 'https://i.pravatar.cc/150?img=2',
      postImageUrl:
          'https://cdn.pixabay.com/photo/2023/02/14/04/39/volunteer-7788809_1280.jpg',
      caption:
          'Did you know glass can be recycled endlessly without losing quality? Make sure to clean your jars before recycling!',
    ),
    Post(
      username: 'proRecycler',
      userAvatarUrl:
          'https://images.pexels.com/photos/1053845/pexels-photo-1053845.jpeg',
      postImageUrl:
          'https://media.istockphoto.com/id/1342229204/pt/foto/a-lake-in-the-shape-of-a-recycling-sign-in-the-middle-of-untouched-nature-an-ecological.jpg?s=1024x1024&w=is&k=20&c=Q-Cvz4PFNrktJnUxFVNeBIh-LkapsjjYBfYGXvZc-RU=',
      caption:
          'Upcycled my old t-shirts into reusable shopping bags! Who else loves DIY projects?',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: widget.changeTheme,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: posts[index]);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: null),
            //estava sendo repetido 4 vezes abaixo por algum motivo, comentei por enquanto para caso cause problema
            //IconButton(icon: Icon(Icons.home), onPressed: null),
            //IconButton(icon: Icon(Icons.home), onPressed: null),
            //IconButton(icon: Icon(Icons.home), onPressed: null),
            IconButton(icon: Icon(Icons.store), onPressed: null),
            //esse é para o marketplace
            IconButton(
              icon: Icon(Icons.assistant),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AiAssistantScreen(),
                  ),
                );
              },
            ),
            //aqui a gente linka para o profile/sign-in(up)
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginWidget()),
                );
              },
            ),
            //aqui a gente link para o about
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Custom widget for displaying a single post card
class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(backgroundImage: NetworkImage(post.userAvatarUrl)),
                const SizedBox(width: 8.0),
                Text(
                  post.username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Image.network(post.postImageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.caption),
          ),
        ],
      ),
    );
  }
}
