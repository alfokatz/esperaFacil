import 'package:template/domain/entities/photo.dart';
import 'package:template/presentation/flows/home/ui/widgets/waiters_filter.dart';

class HomeState {
  final List<Photo> photos;
  final String businessName;
  final int waitingGroupsCount;
  final List<Map<String, dynamic>> waiters;
  final WaitersFilterType selectedFilter;

  HomeState({
    this.photos = const [],
    this.businessName = '',
    this.waitingGroupsCount = 0,
    this.waiters = const [],
    this.selectedFilter = WaitersFilterType.all,
  }) : super();

  HomeState copyWith({
    List<Photo>? photos,
    String? showError,
    String? businessName,
    int? waitingGroupsCount,
    List<Map<String, dynamic>>? waiters,
    WaitersFilterType? selectedFilter,
  }) {
    return HomeState(
      photos: photos ?? this.photos,
      businessName: businessName ?? this.businessName,
      waitingGroupsCount: waitingGroupsCount ?? this.waitingGroupsCount,
      waiters: waiters ?? this.waiters,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}
