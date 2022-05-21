import 'package:auto_route/auto_route.dart';
import 'package:movie_app/home/home.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(path: '/', page: HomePage, children: [
      AutoRoute(path: 'posts', name: 'PostRouter', page: EmptyRouterPage, children: [
        AutoRoute(
          path: '',
        )
      ]),
      // AutoRoute(page: )
    ]),
  ],
)
class $AppRouter {}
