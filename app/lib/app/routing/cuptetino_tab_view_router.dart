import 'package:flutter/cupertino.dart';

class CupertinoTabViewRoutes {
  static const jobEntriesPage = '/job-entries-page';
}

class CupertinoTabViewRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CupertinoTabViewRoutes.jobEntriesPage:
        return CupertinoPageRoute(
          builder: (_) => Center(),
          settings: settings,
          fullscreenDialog: false,
        );
    }
    return null;
  }
}
