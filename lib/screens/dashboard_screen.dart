import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/list_post_cloud_screen.dart';
import 'package:flutter_demo/screens/list_post_screen.dart';
import 'package:flutter_demo/settings/styles.dart';
import 'package:flutter_demo/widgets/futures_modal.dart';
import 'package:provider/provider.dart';
import '../provider/flags_provider.dart';
import '../provider/theme_provider.dart';
import '../widgets/modal_add_post.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkThemeEnable = true;

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    FlagsProvider flags = Provider.of<FlagsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lince Sacial :)'),
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
                  backgroundImage: NetworkImage(
                      'https://i.ytimg.com/vi/-LmKCdYhrjg/maxresdefault.jpg'),
                ),
                accountName: Text('Alejandro Capilla'),
                accountEmail: Text('19031028@itcelaya.edu.mx')),
            ListTile(
              onTap: () => Navigator.pushNamed(context, '/popular'),
              title: const Text('API Movies'),
              leading: const Icon(Icons.movie),
              trailing: const Icon(Icons.chevron_right),
            ),
            IconButton(
                onPressed: () => Navigator.pushNamed(context, '/settings'),
                icon: const Icon(Icons.settings)),
            IconButton(
                onPressed: () => Navigator.pushNamed(context, '/events'),
                icon: const Icon(Icons.event))
          ],
        ),
      ),
    );
  }
}
