import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class MixPanelUtils {
  final Mixpanel mixPanel;

  MixPanelUtils({required this.mixPanel});

  void trackEvent(String eventName, Map<String, dynamic> properties) {
    mixPanel.track(eventName, properties: properties);
  }
}

final mixPanelProvider = Provider<Mixpanel>(
  ((ref) => throw UnimplementedError()),
);

final mixPanelUtils = Provider(
  (ref) => MixPanelUtils(mixPanel: ref.watch(mixPanelProvider)),
);
