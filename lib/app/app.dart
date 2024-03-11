

import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../Home/view/HomeViewScreen.dart';

@StackedApp(
routes:[
  MaterialRoute(
    page: HomeScreen,
    initial: false,
  ),
],
  dependencies:[
    LazySingleton(classType: NavigationService),
  ],
  logger: StackedLogger(),
)
class $AppRouter {}


//flutter pub run build_runner build --delete-conflicting-outputs