import 'package:flutter/material.dart';
import 'package:tifli/features/navigation/app_router.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentIndex = 0;

  // Create separate navigators for each tab to maintain state
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  Widget _buildNavigator(int index) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (settings) {
        // Define the initial route for each tab
        switch (index) {
          case 0: // Home
            return MaterialPageRoute(
              builder: (_) => Navigator(
                onGenerateRoute: (settings) {
                  if (settings.name == '/') {
                    return AppRouter.generateRoute(
                      RouteSettings(name: AppRoutes.home),
                    );
                  }
                  return AppRouter.generateRoute(settings);
                },
              ),
            );
          case 1: // Schedule
            return MaterialPageRoute(
              builder: (_) => Navigator(
                onGenerateRoute: (settings) {
                  if (settings.name == '/') {
                    return AppRouter.generateRoute(
                      RouteSettings(name: AppRoutes.schedules),
                    );
                  }
                  return AppRouter.generateRoute(settings);
                },
              ),
            );
          case 2: // Track
            return MaterialPageRoute(
              builder: (_) => Navigator(
                onGenerateRoute: (settings) {
                  if (settings.name == '/') {
                    return AppRouter.generateRoute(
                      RouteSettings(name: AppRoutes.trackers),
                    );
                  }
                  return AppRouter.generateRoute(settings);
                },
              ),
            );
          case 3: // Logs
            return MaterialPageRoute(
              builder: (_) => Navigator(
                onGenerateRoute: (settings) {
                  if (settings.name == '/') {
                    return AppRouter.generateRoute(
                      RouteSettings(name: AppRoutes.logs),
                    );
                  }
                  return AppRouter.generateRoute(settings);
                },
              ),
            );
          default:
            return MaterialPageRoute(
              builder: (_) => const Scaffold(
                body: Center(child: Text('Unknown Tab')),
              ),
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: List.generate(4, (index) => _buildNavigator(index)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFD93B63),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: 'Track',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Logs',
          ),
        ],
      ),
    );
  }
}
