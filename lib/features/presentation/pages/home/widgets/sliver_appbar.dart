import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/features/domain/entities/home.dart';

class SliverAppbar extends StatelessWidget {
  const SliverAppbar({super.key, required this.home});

  final HomeEntity home;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.primarygradientColor),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar on far left
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primaryWhiteColor,
              child: Text(
                home.user.userName[0].toUpperCase(),
                style: textTheme.titleLarge?.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Middle content (greeting and username)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greeting and time row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Selamat datang',
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.primaryWhiteColor.withOpacity(0.9),
                        ),
                      ),
                      Text(
                        DateFormat('HH:mm').format(DateTime.now()),
                        style: textTheme.bodyLarge?.copyWith(
                          color: AppColors.primaryWhiteColor.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),

                  // Username and location row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        home.user.userName,
                        style: textTheme.headlineMedium?.copyWith(
                          color: AppColors.primaryWhiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.primaryWhiteColor.withOpacity(0.8),
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            home.user.address,
                            style: textTheme.bodySmall?.copyWith(
                              color:
                                  AppColors.primaryWhiteColor.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
