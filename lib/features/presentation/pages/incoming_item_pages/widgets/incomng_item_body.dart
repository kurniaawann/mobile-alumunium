import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/common/utils/format_currency.dart';
import 'package:mobile_alumunium/common/widgets/custom_info_item.dart';
import 'package:mobile_alumunium/features/domain/entities/incoming_item/incoming_item.dart';

class IncomngItemBody extends StatelessWidget {
  const IncomngItemBody({super.key, required this.incomingItemEntity});

  final IncomingItemEntity incomingItemEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with actions
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Barang Masuk',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: AppColors.primaryColor,
                    letterSpacing: 1.2,
                  ),
                ),
                // _buildActionMenu(incomingItemEntity, context),
              ],
            ),
            const SizedBox(height: 15),

            // Main content
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomInfoItem(
                  icon: Icons.inventory,
                  title: 'Jumlah',
                  value: '${incomingItemEntity.quantity} pcs',
                  color: AppColors.primaryColor,
                ),
                CustomInfoItem(
                  icon: Icons.person,
                  title: 'Diterima oleh',
                  value: incomingItemEntity.receivedBy,
                  color: AppColors.infoColor,
                ),
              ],
            ),
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomInfoItem(
                  icon: Icons.attach_money,
                  title: 'Total Harga',
                  value: formatCurrency(incomingItemEntity.priceIncomingItem),
                  color: AppColors.successColor,
                ),
                CustomInfoItem(
                  icon: Icons.calendar_today,
                  title: 'Diterima',
                  value: DateFormat('dd MMM yyyy')
                      .format(incomingItemEntity.createdAt),
                  color: AppColors.warningColor,
                ),
              ],
            ),

            const SizedBox(height: 12),
            Divider(
              height: 2,
              color: AppColors.navBarUnselectedItem,
            ),
            const SizedBox(height: 8),

            // Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Updated: ${DateFormat('dd MMM yyyy HH:mm').format(incomingItemEntity.updatedAt)}',
                  style: theme.textTheme.bodySmall?.copyWith(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
