import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revive_eco_tech_app/widgets/Notification_Card.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  final String userId = "testUser"; // change later to FirebaseAuth UID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7ecd3),
      appBar: AppBar(
        backgroundColor: const Color(0xff003046),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notification",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("notifications")
            .doc(userId)
            .collection("userNotifications")
            .orderBy("timestamp", descending: true)
            .snapshots(),

        builder: (context, snapshot) {
          // 🔵 When Firebase is still loading data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 🔴 If there is an error
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Error loading notifications",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          // 🟡 If there is data but list is empty
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No notifications yet",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }

          // 🟢 Notifications found
          var docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index].data() as Map<String, dynamic>;

              return NotificationCard(
                date: data["date"] ?? "",
                dayTime: data["dayTime"] ?? "",
                title: data["title"] ?? "",
                description: data["description"] ?? "",
              );
            },
          );
        },
      ),
    );
  }
}
