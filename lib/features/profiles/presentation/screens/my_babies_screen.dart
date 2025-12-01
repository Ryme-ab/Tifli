import 'package:flutter/material.dart';
import '../widgets/appbar.dart';

class MyBabiesPage extends StatelessWidget {
  const MyBabiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Babies",
      ), // 👈 added this comma and fixed placement

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Row for first two babies
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              BabyCard(
                name: 'Donia',
                age: '3 years, 1 month',
                imageUrl:
                    'https://images.unsplash.com/photo-1546435770-a3e426bf472b',
                borderColor: Colors.pinkAccent,
              ),
              BabyCard(
                name: 'Cilia',
                age: '3 months',
                imageUrl:
                    'https://images.unsplash.com/photo-1503455637927-730bce8583c0',
                borderColor: Colors.amber,
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Single baby in center
          const BabyCard(
            name: 'Islem',
            age: '1 year, 2 months',
            imageUrl:
                'https://images.unsplash.com/photo-1606046604972-77cc76aee944',
            borderColor: Colors.lightBlueAccent,
          ),

          const SizedBox(height: 100),

          // Add Baby Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent[100],
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.add_reaction_outlined,
                color: Colors.black87,
              ),
              label: const Text(
                'Add Baby',
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------
// BabyCard Widget
// -------------------------
class BabyCard extends StatelessWidget {
  final String name;
  final String age;
  final String imageUrl;
  final Color borderColor;

  const BabyCard({
    super.key,
    required this.name,
    required this.age,
    required this.imageUrl,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 3),
          ),
          child: CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        Text(age, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
      ],
    );
  }
}
