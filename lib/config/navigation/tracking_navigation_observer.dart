import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/domain/use_cases/tracking/track_event_use_Case.dart';

class TrackingNavigatorObserver extends NavigatorObserver {
  final Ref ref;

  TrackingNavigatorObserver({required this.ref});

  void _trackRoute(Route<dynamic>? route, String action) {
    final screenName = route?.settings.name;
    if (screenName != null && screenName.isNotEmpty) {
      final tracker = ref.read(trackEventUseCase);
      tracker.trackEvent(
        eventName: "screen_view",
        data: {"screen": screenName.toLowerCase()},
      );
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _trackRoute(route, "push");
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _trackRoute(previousRoute, "pop");
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _trackRoute(newRoute, "replace");
  }
}
