import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/presentation/base/theme/app_dimens.dart';
import 'package:template/presentation/flows/home/providers/home_provider.dart';
import 'package:template/presentation/flows/home/ui/widgets/home_app_bar.dart';
import 'package:template/presentation/flows/home/ui/widgets/waiter_card.dart';
import 'package:template/presentation/flows/home/ui/widgets/waiters_filter.dart';

import '../../../../base/content_state/content_state_widget.dart';

class HomeContent extends HookConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    final homeNotifier = ref.read(homeProvider.notifier);
    final selectedFilter = ref.watch(
      homeProvider.select((state) => state.selectedFilter),
    );

    // Get filtered waiters from provider
    final filteredWaiters = homeNotifier.getFilteredWaiters();

    return ContentStateWidget(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: HomeAppBar(
          businessName: homeState.businessName,
          waitingGroupsCount: homeState.waitingGroupsCount,
          onSettingsPressed: homeNotifier.onSettingsPressed,
        ),
        body: Column(
          children: [
            // Filter buttons
            Padding(
              padding: const EdgeInsets.only(
                top: AppDimens.mediumMargin,
                bottom: AppDimens.smallMargin,
              ),
              child: WaitersFilter(
                selectedFilter: selectedFilter,
                onFilterChanged: (filter) {
                  homeNotifier.setFilter(filter);
                },
              ),
            ),
            // Waiters list
            Expanded(
              child:
                  filteredWaiters.isEmpty
                      ? _EmptyState()
                      : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 80),
                        itemCount: filteredWaiters.length,
                        itemBuilder: (context, index) {
                          final waiter = filteredWaiters[index];
                          return WaiterCard(
                            name: waiter['name'] as String,
                            photoUrl: waiter['photoUrl'] as String?,
                            peopleCount: waiter['peopleCount'] as int,
                            waitingMinutes: waiter['waitingMinutes'] as int,
                            estimatedWaitMinutes:
                                waiter['estimatedWaitMinutes'] as int?,
                            status:
                                (waiter['status'] as String) == 'waiting'
                                    ? WaiterStatus.waiting
                                    : WaiterStatus.notified,
                            onCancel: () {
                              homeNotifier.cancelWaiter(waiter['id'] as String);
                            },
                            onNotify: () {
                              homeNotifier.notifyWaiter(waiter['id'] as String);
                            },
                            onServe: () {
                              homeNotifier.serveWaiter(waiter['id'] as String);
                            },
                          );
                        },
                      ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: homeNotifier.onAddWaiter,
          backgroundColor: const Color(0xFF2196F3),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
          const SizedBox(height: AppDimens.mediumMargin),
          Text(
            'No hay clientes en espera',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
