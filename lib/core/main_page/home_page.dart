import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:racer_app/core/app_strings.dart';
import 'package:racer_app/dependency_injection.dart' as depIn;
import 'package:racer_app/presentation/feed/controller/feed_bloc.dart';
import 'package:racer_app/presentation/feed/pages/main_feed_page.dart';
import 'package:racer_app/presentation/run/controller/map_bloc.dart';
import 'package:racer_app/presentation/run/pages/map_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.people_alt_outlined),
      label: AppStrings.feed
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.run_circle_rounded),
      label:  AppStrings.run,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label:  AppStrings.profile
    ),
  ];

  int page = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(child: _buildPage(page)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        items: items,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        selectedItemColor: theme.primary,
        unselectedItemColor: theme.onSurfaceVariant,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: theme.surface,
        elevation: 8,
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return BlocProvider(
          create: (context) => GetIt.instance.get<FeedBloc>(),
          child: MainFeedPage(),
        );
      case 1:
        return BlocProvider(
          create: (context) => GetIt.instance.get<MapBloc>(),
          child: MapPage(googleAPiKey: depIn.googleApiKey,),
        );
      case 2:
        return BlocProvider(
          create: (context) => GetIt.instance.get<FeedBloc>(),
          child: MainFeedPage(),
        );
      default:
        return Container();
    }
  }
}
