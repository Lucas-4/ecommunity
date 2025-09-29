import 'package:ecommunity/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:ecommunity/ai_assistant.dart';
import 'package:ecommunity/about.dart';
import 'package:ecommunity/signup.dart';

void main() {
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
      username: 'FlutterDev',
      userAvatarUrl: 'https://i.pravatar.cc/150?img=1',
      postImageUrl: 'https://picsum.photos/600/400?image=10',
      caption: 'Loving the new features in Flutter 3!',
    ),
    Post(
      username: 'eco',
      userAvatarUrl: 'https://i.pravatar.cc/150?img=2',
      postImageUrl: 'https://picsum.photos/600/400?image=20',
      caption: 'Dart is such a powerful and versatile language.',
    ),
    Post(
      username: 'proRecycler',
      userAvatarUrl: 'https://images.pexels.com/photos/1053845/pexels-photo-1053845.jpeg',
      postImageUrl: 'https://picsum.photos/600/400?image=30',
      caption: 'Just starting my journey with Flutter. Any tips?',
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
            IconButton(icon: Icon(Icons.store), onPressed: null), //esse é para o marketplace 
            IconButton(
              icon: Icon(Icons.assistant), 
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AiAssistantScreen()),
                );
              },
            ),
            //aqui a gente linka para o profile/sign-in(up)
            IconButton(icon: Icon(Icons.person), onPressed: null),
            //aqui a gente link para o about
            IconButton(icon: Icon(Icons.info), 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            }),
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
