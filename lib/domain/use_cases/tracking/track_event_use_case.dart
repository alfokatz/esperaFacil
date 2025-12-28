import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/config/tracking/mix_panel_utils.dart';

class TrackEventUseCase {
  final Ref ref;

  TrackEventUseCase({required this.ref});

  void trackEvent({
    required String eventName,
    required Map<String, String> data,
  }) {
    ref.read(mixPanelUtils).trackEvent(eventName, data);
  }
}

final trackEventUseCase = Provider<TrackEventUseCase>(
  (ref) => TrackEventUseCase(ref: ref),
);
