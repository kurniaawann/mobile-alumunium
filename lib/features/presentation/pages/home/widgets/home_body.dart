import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/features/domain/entities/home.dart';
import 'package:mobile_alumunium/features/presentation/pages/home/widgets/backgourd_value.dart';
import 'package:mobile_alumunium/features/presentation/pages/home/widgets/sliver_appbar.dart';
import 'package:mobile_alumunium/features/presentation/pages/home/widgets/statistic_item.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key, required this.home});

  final HomeEntity home;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header Sliver
          SliverAppBar(
            expandedHeight: 100,
            flexibleSpace:
                FlexibleSpaceBar(background: SliverAppbar(home: home)),
          ),

          // Stats Sliver
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 25)
                .add(EdgeInsets.only(top: 20)),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StatisticItem(
                        value: home.statistics.itemCount.toString(),
                        label: 'Total Barang',
                        icon: Icons.inventory_2,
                      ),
                      StatisticItem(
                        value: home.statistics.stockCount.toString(),
                        label: 'Total Stok',
                        icon: Icons.stacked_bar_chart,
                      ),
                      StatisticItem(
                        value: home.statistics.lowStockItemsCount.toString(),
                        label: 'Stok Rendah',
                        icon: Icons.warning,
                        isWarning: true,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StatisticItem(
                        value: home.statistics.incomingItemCount.toString(),
                        label: 'Barang Masuk',
                        icon: Icons.move_to_inbox,
                      ),
                      StatisticItem(
                        value: home.statistics.outgoingItemCount.toString(),
                        label: 'Barang Keluar',
                        icon: Icons.output,
                      ),
                      StatisticItem(
                        value: home.statistics.projectCount.toString(),
                        label: 'Proyek',
                        icon: Icons.assignment,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Items List Header
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 25)
                .add(EdgeInsets.only(top: 20)),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daftar Item Terbaru',
                    style: textTheme.titleLarge?.copyWith(
                      color: AppColors.primaryDarkColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Semua Item >',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Items List
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ).add(EdgeInsets.only(top: 10)),
            sliver: SliverList.separated(
              itemCount: home.item.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20);
              },
              itemBuilder: (BuildContext context, int index) {
                final item = home.item[index];

                return _buildItemCard(context, item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, ItemEntity item) {
    final textTheme = Theme.of(context).textTheme;
    final dateFormat = DateFormat('dd MMM yyyy');
    final isLowStock = item.stock < 5;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
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
                          text: dateFormat.format(item.createdAt),
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
                          text: dateFormat.format(item.createdAt),
                          style: textTheme.bodySmall?.copyWith(
                              // color: AppColors.primaryColor,
                              ),
                        ),
                      ],
                    )),

                    // Row(
                    //   children: [
                    //     Text(
                    //       'Ditambahkan: ',
                    //       style: textTheme.bodySmall?.copyWith(),
                    //     ),
                    //     BackgourdValue(
                    //       value: dateFormat.format(item.createdAt),
                    //     )
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       'Diupdate: ',
                    //       style: textTheme.bodySmall?.copyWith(),
                    //     ),
                    //     BackgourdValue(
                    //       value: dateFormat.format(item.createdAt),
                    //     )
                    //   ],
                    // ),
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
