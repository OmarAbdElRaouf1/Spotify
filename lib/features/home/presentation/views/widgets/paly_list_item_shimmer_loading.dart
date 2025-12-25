import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

import '../../../../../common/helpers/is_dark_mode.dart';

class PlayListItemShimmerLoading extends StatelessWidget {
  const PlayListItemShimmerLoading({super.key, this.itemCount = 10});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        return Shimmer(
          duration: const Duration(seconds: 2),
          interval: const Duration(seconds: 1),
          color: context.isDarkMode
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.1),
          colorOpacity: 0.3,
          enabled: true,
          direction: const ShimmerDirection.fromLTRB(),
          child: Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.isDarkMode
                      ? AppColors.darkGrey
                      : const Color(0xffE6E6E6),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16,
                    width: 150,
                    decoration: BoxDecoration(
                      color: context.isDarkMode
                          ? AppColors.darkGrey
                          : const Color(0xffE6E6E6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 11,
                    width: 100,
                    decoration: BoxDecoration(
                      color: context.isDarkMode
                          ? AppColors.darkGrey
                          : const Color(0xffE6E6E6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
