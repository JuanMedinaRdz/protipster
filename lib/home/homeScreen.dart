import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> userTopics = [];
  List<DocumentSnapshot> posts = [];
  List<String> postImageUrls = []; // Lista de URLs de imágenes para los posts
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserTopicsAndPosts();
  }

  Future<void> _fetchUserTopicsAndPosts() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final topics = List<String>.from(userDoc['selectedTopics']);

      setState(() {
        userTopics = topics;
      });

      final postsQuery = await _firestore
          .collection('topics')
          .where('topic', whereIn: userTopics)
          .get();
      final filteredPosts = postsQuery.docs;

      setState(() {
        posts = filteredPosts;
        isLoading = false;
      });

      // Obtener la URL de la imagen para cada post
      List<String> urls = [];
      for (var post in posts) {
        final data = post.data() as Map<String, dynamic>;
        final imageUrl = data[
            'imageUrl']; // Ajusta según el nombre de tu campo de imagen en Firestore
        urls.add(imageUrl);
      }
      setState(() {
        postImageUrls = urls;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index].data() as Map<String, dynamic>;

                return GestureDetector(
                  onTap: () {
                    // Navegar a la pantalla de detalles del post
                    context.go('/post/${posts[index].id}');
                  },
                  child: Card(
                    color: Colors.transparent,
                    elevation: 4,
                    margin: EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.white, width: 1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                post['title'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.favorite_border,
                                        color: Colors.white),
                                    onPressed: () {
                                      // Lógica para dar like al post
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.comment,
                                        color: Colors.white),
                                    onPressed: () {
                                      // Lógica para abrir la sección de comentarios
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          // Mostrar la vista preliminar con la misma imagen en cada card
                          Image.network(
                            postImageUrls[
                                index], // URL de imagen correspondiente al post
                            width: double
                                .infinity, // Ancho de la imagen igual al ancho de la card
                            height: 200, // Altura fija de la imagen
                            fit: BoxFit
                                .cover, // Ajustar la imagen para que cubra el espacio disponible
                          ),
                          SizedBox(height: 8),
                          Text(
                            post['description'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
