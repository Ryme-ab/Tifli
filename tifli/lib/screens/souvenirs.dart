// import 'package:flutter/material.dart';
// import 'appbar.dart';

// class MemoriesPage extends StatelessWidget {
//   const MemoriesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const CustomAppBar(title: "Memories"),

//       body: Stack(
//         children: [
//           // ✅ The grid content
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: GridView.count(
//               crossAxisCount: 2,
//               mainAxisSpacing: 16,
//               crossAxisSpacing: 16,
//               childAspectRatio: 0.9,
//               children: [
//                 _buildAddMemoryCard(context),
//                 _buildMemoryCard(
//                   imageUrl:
//                       'https://images.unsplash.com/photo-1503341455253-b2e723bb3dbb',
//                   title: "Baby’s first radiant smile!",
//                   date: "Jan 15, 2024",
//                 ),
//                 _buildMemoryCard(
//                   imageUrl:
//                       'https://images.unsplash.com/photo-1555255707-c07966088b7b',
//                   title: "Discovering new toys with glee.",
//                   date: "Feb 01, 2024",
//                 ),
//                 _buildMemoryCard(
//                   imageUrl:
//                       'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
//                   title: "Wobbly first steps, so proud!",
//                   date: "Mar 10, 2024",
//                   isVideo: true,
//                 ),
//                 _buildMemoryCard(
//                   imageUrl:
//                       'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
//                   title: "Holding mommy’s finger so tight.",
//                   date: "May 12, 2024",
//                 ),
//                 _buildMemoryCard(
//                   imageUrl:
//                       'https://images.unsplash.com/photo-1504151932400-72d4384f04b3',
//                   title: "Uncontrollable baby giggles!",
//                   date: "Jun 20, 2024",
//                   isVideo: true,
//                 ),
//               ],
//             ),
//           ),

//           // ✅ Floating button on top right
//           _buildFloatingAddButton(),
//         ],
//       ),
//     );
//   }

//   // ------------------------
//   // 🔹 Add Memory Card
//   // ------------------------
//   Widget _buildAddMemoryCard(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // TODO: Add functionality
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: Colors.grey.shade400,
//             style: BorderStyle.solid,
//           ),
//           color: Colors.white,
//         ),
//         child: const Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(Icons.add, size: 36, color: Colors.black87),
//               SizedBox(height: 8),
//               Text(
//                 "Add Memory",
//                 style: TextStyle(
//                   color: Colors.black87,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ------------------------
//   // 🔹 Memory Card
//   // ------------------------
//   Widget _buildMemoryCard({
//     required String imageUrl,
//     required String title,
//     required String date,
//     bool isVideo = false,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         image: DecorationImage(
//           image: NetworkImage(imageUrl),
//           fit: BoxFit.cover,
//           colorFilter: ColorFilter.mode(
//             Colors.black.withOpacity(0.25),
//             BlendMode.darken,
//           ),
//         ),
//       ),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 13,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   date,
//                   style: const TextStyle(color: Colors.white70, fontSize: 11),
//                 ),
//               ],
//             ),
//           ),
//           // 🔸 Edit Button (top right)
//           Positioned(
//             top: 8,
//             right: 8,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.8),
//                 shape: BoxShape.circle,
//               ),
//               child: IconButton(
//                 icon: const Icon(Icons.edit, size: 18, color: Colors.black87),
//                 onPressed: () {
//                   // TODO: Edit memory
//                 },
//               ),
//             ),
//           ),
//           // 🔸 Video Icon (center)
//           if (isVideo)
//             const Center(
//               child: Icon(
//                 Icons.play_circle_fill,
//                 size: 40,
//                 color: Colors.white,
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   // ------------------------
//   // 🔹 Floating Add Button (top right area)
//   // ------------------------
//   Widget _buildFloatingAddButton() {
//     return Positioned(
//       right: 20,
//       bottom: 55, // 👈 move higher on the screen
//       child: Container(
//         decoration: const BoxDecoration(
//           color: Colors.pinkAccent,
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 6,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: IconButton(
//           icon: const Icon(Icons.add, color: Colors.white),
//           iconSize: 32,
//           onPressed: () {
//             // TODO: Add memory action
//           },
//         ),
//       ),
//     );
//   }
// }
