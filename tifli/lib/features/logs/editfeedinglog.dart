import 'package:flutter/material.dart';

class EditLogForm extends StatefulWidget {
  final Map<String, dynamic> log;
  const EditLogForm({super.key, required this.log});

  @override
  State<EditLogForm> createState() => _EditLogFormState();
}

class _EditLogFormState extends State<EditLogForm> {
  late TextEditingController typeController;
  late TextEditingController amountController;
  late TextEditingController timeController;

  @override
  void initState() {
    super.initState();
    typeController = TextEditingController(text: widget.log["type"]);
    amountController = TextEditingController(text: widget.log["amount"]);
    timeController = TextEditingController(text: widget.log["time"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Log"),
        backgroundColor: const Color(0xffb03a57),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Edit your log details:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(
                labelText: "Type",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: timeController,
              decoration: const InputDecoration(
                labelText: "Time",
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffb03a57),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                // return the updated log
                Navigator.pop(context, {
                  ...widget.log,
                  "type": typeController.text,
                  "amount": amountController.text,
                  "time": timeController.text,
                });
              },
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
