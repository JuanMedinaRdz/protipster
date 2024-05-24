import 'package:go_router/go_router.dart';
import 'package:protipster/home/homeScreen.dart';
import 'package:protipster/user/loginScreen.dart';
import 'package:protipster/user/postScreen.dart';
import 'package:protipster/user/registerScreen.dart';
import 'package:protipster/user/topicSelectionScreen.dart';

class MyAppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String topics = '/topics-selection';
  static const String post =
      '/post/:id'; // Agrega la ruta para la pantalla de detalle del post
}

final appRouter = GoRouter(
  initialLocation: MyAppRoutes.login,
  routes: [
    GoRoute(
      path: MyAppRoutes.login,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: MyAppRoutes.register,
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: MyAppRoutes.home,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: MyAppRoutes.topics,
      builder: (context, state) => TopicsSelectionScreen(),
    ),
    GoRoute(
      name: 'post', // Nombre de la ruta
      path: MyAppRoutes.post,
      builder: (context, state) {
        // Obtén el ID del post de la ruta
        final segments = state.uri.pathSegments;
        final postId = segments.isNotEmpty ? segments.last : null;
        return PostScreen(
            postId: postId!); // Asegurarse de que postId no sea nulo
      },
    ),
  ],
);
