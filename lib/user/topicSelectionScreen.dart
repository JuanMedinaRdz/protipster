import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopicsSelectionScreen extends StatefulWidget {
  @override
  _TopicsSelectionScreenState createState() => _TopicsSelectionScreenState();
}

class _TopicsSelectionScreenState extends State<TopicsSelectionScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> selectedTopics = [];
  final List<Map<String, dynamic>> availableTopics = [
    {
      'name': 'Finanzas',
      'image': 'assets/images/finanzas.jpeg',
    },
    {
      'name': 'Salud',
      'image': 'assets/images/salud.jpeg',
    },
    {
      'name': 'Trabajo',
      'image': 'assets/images/trabajo.jpeg',
    },
    {
      'name': 'Comida',
      'image': 'assets/images/salud.jpeg',
    },
    {
      'name': 'Hogar',
      'image': 'assets/images/hogar.jpeg',
    },
    {
      'name': 'Naturaleza',
      'image': 'assets/images/naturaleza.jpeg',
    },
  ];

  Future<void> _saveSelectedTopics() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      await _firestore.collection('users').doc(userId).set({
        'selectedTopics': selectedTopics,
      }, SetOptions(merge: true));
    }
  }

  void toggleTopic(String topic) {
    setState(() {
      if (selectedTopics.contains(topic)) {
        selectedTopics.remove(topic);
      } else {
        selectedTopics.add(topic);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selecciona tus temas de interés')),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: availableTopics.length,
        itemBuilder: (context, index) {
          final topic = availableTopics[index];
          final topicName = topic['name'];
          final topicImage = topic['image'];

          return GestureDetector(
            onTap: () => toggleTopic(topicName),
            child: Card(
              elevation: 4,
              margin: EdgeInsets.only(bottom: 16),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      topicImage,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: Center(
                      child: Text(
                        topicName,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Icon(
                      selectedTopics.contains(topicName)
                          ? Icons.check_circle
                          : Icons.circle,
                      color: selectedTopics.contains(topicName)
                          ? Colors.green
                          : Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _saveSelectedTopics();
          context.go('/home');
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
