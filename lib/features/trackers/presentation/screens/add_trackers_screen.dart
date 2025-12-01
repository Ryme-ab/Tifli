import 'package:flutter/material.dart';
import 'package:tifli/features/trackers/presentation/widgets/tracker_button.dart';

class AddTrackersPage extends StatefulWidget {
  const AddTrackersPage({super.key});

  @override
  State<AddTrackersPage> createState() => _AddTrackersPageState();
}

class _AddTrackersPageState extends State<AddTrackersPage> {
  final int _selectedIndex = -1;

  // void _navigateTo(int index) {
  //   setState(() => _selectedIndex = index);
  //   Widget page;

  //   // switch (index) {
  //   //   case 0:
  //   //     page = const FoodPage();
  //   //     break;
  //   //   case 1:
  //   //     page = const SleepPage();
  //   //     break;
  //   //   case 2:
  //   //     page = const BabyPage();
  //   //     break;
  //   //   default:
  //   //     return;
  //   // }

  //   Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Trackers'), centerTitle: true),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TrackerButton(
              icon: Icons.water_drop,
              borderColor: Colors.amber,
              activeColor: Colors.amber,
              isActive: _selectedIndex == 0,
              // onTap: () => _navigateTo(0),
            ),
            const SizedBox(width: 20),
            TrackerButton(
              icon: Icons.nightlight_round,
              borderColor: Colors.blue,
              activeColor: Colors.blue,
              isActive: _selectedIndex == 1,
              //   onTap: () => _navigateTo(1),
            ),

            const SizedBox(width: 20),

            TrackerButton(
              icon: Icons.child_care,
              borderColor: Colors.green,
              activeColor: Colors.green,
              isActive: _selectedIndex == 2,
              // onTap: () => _navigateTo(2),
            ),
          ],
        ),
      ),
    );
  }
}
