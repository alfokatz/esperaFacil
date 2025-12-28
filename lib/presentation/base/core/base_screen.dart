import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/config/navigation/navigator.dart';
import 'package:template/presentation/base/alert/alert_data.dart';
import 'package:template/presentation/base/alert/alert_provider.dart';
import 'package:template/presentation/base/alert/alert_type.dart';
import 'package:template/presentation/base/navigation/navigation_event.dart';

mixin class BaseScreen {
  void subscribeAlert({required WidgetRef ref, required BuildContext context}) {
    ref.listen<AlertData?>(
      alertProvider,
      (previous, next) {
        if (next != null) {
          _showAlert(context, next);
        }
      },
    );
  }

  void _showAlert(BuildContext context, AlertData alertData) {
    Color backgroundColor;
    IconData icon;

    switch (alertData.alertType) {
      case AlertType.success:
        backgroundColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case AlertType.warning:
        backgroundColor = Colors.orange;
        icon = Icons.warning;
        break;
      case AlertType.error:
        backgroundColor = Colors.red;
        icon = Icons.error;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (alertData.title != null)
                    Text(
                      alertData.title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  if (alertData.message != null)
                    Text(
                      alertData.message!,
                      style: const TextStyle(color: Colors.white),
                    ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void subscribeNavigation({
    required WidgetRef ref,
    required BuildContext context,
  }) {
    ref.listen<NavigationEvent?>(
      navigationProvider,
      (previous, next) {
        if (next != null) {
          next.navigate(context: context);
        }
      },
    );
  }

  void runAfterPostFrameCallback(Function function) {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback(
      (_) {
        function.call();
      },
    );
  }
}
