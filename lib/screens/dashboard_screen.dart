import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/list_post_cloud_screen.dart';
import 'package:flutter_demo/widgets/futures_modal.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkThemeEnable = true;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lince Social :)'),
      ),
      // body: const ListPostScreen() == true
      //     ? const ListPostScreen()
      //     : ListPostScreen(),
      body: ListPostCloudScreen(),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => openCustomePostDialog(context, null),
          icon: const Icon(Icons.add),
          label: const Text('Post it')),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(user.photoURL!),
                ),
                accountName: Text(user.displayName!),
                accountEmail: Text(user.email!)),
            ListTile(
              onTap: () => Navigator.pushNamed(context, '/popular'),
              title: const Text('API Movies'),
              leading: const Icon(Icons.movie),
              trailing: const Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () => Navigator.pushNamed(context, '/favorite_movies'),
              title: const Text('Favorite Movies'),
              leading: const Icon(Icons.movie),
              trailing: const Icon(Icons.chevron_right),
            ),
            IconButton(
                onPressed: () => Navigator.pushNamed(context, '/settings'),
                icon: const Icon(Icons.settings)),
            IconButton(
                onPressed: () => Navigator.pushNamed(context, '/events'),
                icon: const Icon(Icons.event)),
            IconButton(
                onPressed: () => Navigator.pushNamed(context, '/about'),
                icon: const Icon(Icons.map)),
          ],
        ),
      ),
    );
  }
}
