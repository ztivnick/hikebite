import 'package:flutter/material.dart';
import 'package:hikebite/utils/dimensions.dart';

class WelcomePage extends StatelessWidget {
  final Future<void> Function() popWelcomePage;
  const WelcomePage({required this.popWelcomePage, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.hiking_rounded,
            size: 64,
            color: colorScheme.primary,
          ),
          const SizedBox(height: Dimensions.DIVIDER_SIZE_SMALL),
          Text(
            'Welcome to HikeBite',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: Dimensions.DIVIDER_SIZE_SMALL),
          Text(
            'Plan your backpacking meals with ease!',
            style: TextStyle(
              fontSize: 16,
              color:
                  colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: Dimensions.DIVIDER_SIZE_DOUBLE),
          ElevatedButton(
            onPressed: () {
              popWelcomePage.call();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  colorScheme.primary,
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.DIVIDER_SIZE_DOUBLE,
                  vertical: Dimensions.DIVIDER_SIZE_SMALL),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Get Started',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme
                    .onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
