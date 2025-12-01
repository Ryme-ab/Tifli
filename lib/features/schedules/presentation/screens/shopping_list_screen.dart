import 'package:flutter/material.dart';
import 'package:tifli/core/constants/app_colors.dart';
import 'package:tifli/core/constants/app_fonts.dart';
import 'package:tifli/core/constants/app_sizes.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _categories = [
    {
      "id": "1",
      "title": "Food & Groceries",
      "icon": Icons.restaurant,
      "items": [
        {
          "id": "a",
          "title": "Baby Cereal",
          "subtitle": "Organic, Stage 1",
          "checked": false,
        },
        {
          "id": "b",
          "title": "Formula Milk",
          "subtitle": "Hypoallergenic, 850g",
          "checked": false,
        },
        {
          "id": "c",
          "title": "Baby Food Jar",
          "subtitle": "Sweet potato, 4oz",
          "checked": true,
        },
      ],
    },
    {
      "id": "2",
      "title": "Clothes & Apparel",
      "icon": Icons.checkroom,
      "items": [
        {
          "id": "d",
          "title": "Baby Onesies",
          "subtitle": "3–6 months, cotton",
          "checked": false,
        },
        {
          "id": "e",
          "title": "Socks",
          "subtitle": "Infant, 6-pack",
          "checked": false,
        },
      ],
    },
    {
      "id": "3",
      "title": "Baby Necessities",
      "icon": Icons.favorite,
      "items": [
        {
          "id": "f",
          "title": "Diapers",
          "subtitle": "Size 2, 60 count",
          "checked": true,
        },
        {
          "id": "g",
          "title": "Wipes",
          "subtitle": "Sensitive, 4-pack",
          "checked": false,
        },
        {
          "id": "h",
          "title": "Stroller",
          "subtitle": "Lightweight",
          "checked": false,
        },
      ],
    },
  ];

  void _toggleCheck(String categoryId, String itemId) {
    setState(() {
      final category = _categories.firstWhere((c) => c['id'] == categoryId);
      final item = category['items'].firstWhere((i) => i['id'] == itemId);
      item['checked'] = !item['checked'];
    });
  }

  void _deleteItem(String categoryId, String itemId) {
    setState(() {
      final category = _categories.firstWhere((c) => c['id'] == categoryId);
      category['items'].removeWhere((i) => i['id'] == itemId);
    });
  }

  void _editItem(String categoryId, String itemId) async {
    final category = _categories.firstWhere((c) => c['id'] == categoryId);
    final item = category['items'].firstWhere((i) => i['id'] == itemId);

    final titleController = TextEditingController(text: item['title']);
    final subtitleController = TextEditingController(text: item['subtitle']);

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Item name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: subtitleController,
              decoration: const InputDecoration(hintText: 'Details'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, {
              'title': titleController.text,
              'subtitle': subtitleController.text,
            }),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (result != null && result['title']!.isNotEmpty) {
      setState(() {
        item['title'] = result['title'];
        item['subtitle'] = result['subtitle'];
      });
    }
  }

  void _addCategory() async {
    final titleController = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add New Category'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(hintText: 'Category name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, titleController.text),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result != null && result.trim().isNotEmpty) {
      setState(() {
        _categories.add({
          "id": DateTime.now().millisecondsSinceEpoch.toString(),
          "title": result,
          "icon": Icons.add,
          "items": [],
        });
      });
    }
  }

  void _addItemToCategory(String categoryId) async {
    final titleController = TextEditingController();
    final subtitleController = TextEditingController();

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add New Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Item name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: subtitleController,
              decoration: const InputDecoration(hintText: 'Details'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, {
              'title': titleController.text,
              'subtitle': subtitleController.text,
            }),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result != null && result['title']!.isNotEmpty) {
      setState(() {
        final category = _categories.firstWhere((c) => c['id'] == categoryId);
        category['items'].add({
          "id": DateTime.now().millisecondsSinceEpoch.toString(),
          "title": result['title'],
          "subtitle": result['subtitle'],
          "checked": false,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        centerTitle: true,
        title: Text("Shopping List", style: AppFonts.heading2),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.lg,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(),
                    const SizedBox(height: 12),
                    ..._categories
                        .map((cat) => _buildCategoryCard(cat)),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: SizedBox(
                height: 52,
                child: OutlinedButton(
                  onPressed: _addCategory,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primary, width: 1.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    "+ Add New Category",
                    style: AppFonts.body.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search shopping items...",
          hintStyle: AppFonts.body.copyWith(color: AppColors.textPrimaryLight),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    final items = category['items'] as List;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row with Add button
            Row(
              children: [
                Icon(category['icon'], color: AppColors.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    category['title'],
                    style: AppFonts.body.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                IconButton(
                  onPressed: () => _addItemToCategory(category['id']),
                  icon: const Icon(Icons.add_circle_outline),
                  color: AppColors.primary,
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...items
                .map((item) => _buildItemTile(category['id'], item)),
          ],
        ),
      ),
    );
  }

  Widget _buildItemTile(String categoryId, Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _toggleCheck(categoryId, item['id']),
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.primary),
                color: item['checked'] ? AppColors.primary : Colors.white,
              ),
              child: item['checked']
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : const SizedBox.shrink(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: AppFonts.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: item['checked']
                        ? Colors.grey
                        : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item['subtitle'],
                  style: AppFonts.body.copyWith(
                    color: AppColors.textPrimaryLight,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, size: 18),
            color: AppColors.primary,
            onPressed: () => _editItem(categoryId, item['id']),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 18),
            color: AppColors.primary,
            onPressed: () => _deleteItem(categoryId, item['id']),
          ),
        ],
      ),
    );
  }
}
