import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ContentState {
  loading,
  loadingOverlay,
  showContent,
  networkError,
  genericError,
}

class ContentStateNotifier extends StateNotifier<ContentState> {
  ContentStateNotifier() : super(ContentState.loading);

  void setLoading() {
    print('🎯 [ContentStateNotifier] setLoading() llamado');
    _setState(contentState: ContentState.loading);
    print('🎯 [ContentStateNotifier] Estado actualizado a: loading');
  }

  void setLoadingOverlay() {
    print('🎯 [ContentStateNotifier] setLoadingOverlay() llamado');
    _setState(contentState: ContentState.loadingOverlay);
    print('🎯 [ContentStateNotifier] Estado actualizado a: loadingOverlay');
  }

  void setShowContent() {
    print('🎯 [ContentStateNotifier] setShowContent() llamado');
    _setState(contentState: ContentState.showContent);
    print('🎯 [ContentStateNotifier] Estado actualizado a: showContent');
  }

  void setNetworkError() {
    _setState(contentState: ContentState.networkError);
  }

  void setGenericError() {
    _setState(contentState: ContentState.genericError);
  }

  void _setState({required ContentState contentState}) {
    print('🎯 [ContentStateNotifier] _setState() llamado con: $contentState');
    final previousState = state;
    state = contentState;
    print('🎯 [ContentStateNotifier] Estado cambiado de $previousState a $contentState');
  }
}

final contentStateNotifierProvider =
    StateNotifierProvider<ContentStateNotifier, ContentState>(
  (ref) {
    return ContentStateNotifier();
  },
);
