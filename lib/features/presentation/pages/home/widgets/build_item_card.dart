import 'package:flutter/material.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/common/utils/format_date.dart';
import 'package:mobile_alumunium/features/domain/entities/home.dart';
import 'package:mobile_alumunium/features/presentation/pages/home/widgets/backgourd_value.dart';

class BuildItemCard extends StatelessWidget {
  final ItemEntity item;
  const BuildItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isLowStock = item.stock <= 5;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    item.itemName,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isLowStock
                          ? AppColors.errorColor
                          : AppColors.primaryDarkColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isLowStock
                        ? AppColors.errorColor.withOpacity(0.1)
                        : AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isLowStock
                          ? AppColors.errorColor.withOpacity(0.3)
                          : AppColors.primaryColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '${item.stock} stok',
                    style: textTheme.labelMedium?.copyWith(
                      color: isLowStock
                          ? AppColors.errorColor
                          : AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (item.itemCode != null) ...[
              Row(
                children: [
                  Text(
                    'Kode: ',
                    style: textTheme.bodySmall?.copyWith(),
                  ),
                  BackgourdValue(
                    value: item.itemCode.toString(),
                  )
                ],
              ),
            ],
            if (item.height != null && item.width != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Dimensi: ',
                    style: textTheme.bodySmall?.copyWith(),
                  ),
                  BackgourdValue(
                    value: '${item.height} x ${item.width}',
                  )
                ],
              )
            ],
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    RichText(
                        text: TextSpan(
                      text: 'Dibuat: ',
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryGreyColor,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: formatDateTime(item.createdAt),
                          style: textTheme.bodySmall?.copyWith(
                              // color: AppColors.primaryColor,
                              ),
                        ),
                      ],
                    )),
                    RichText(
                        text: TextSpan(
                      text: 'Diperbaharui: ',
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryGreyColor,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: formatDateTime(item.updatedAt),
                          style: textTheme.bodySmall?.copyWith(
                              // color: AppColors.primaryColor,
                              ),
                        ),
                      ],
                    )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
