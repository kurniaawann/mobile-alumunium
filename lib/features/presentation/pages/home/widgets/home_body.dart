import 'package:flutter/material.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/features/domain/entities/home.dart';
import 'package:mobile_alumunium/features/presentation/pages/home/widgets/build_item_card.dart';
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
                return SizedBox(height: 30);
              },
              itemBuilder: (BuildContext context, int index) {
                final item = home.item[index];

                return BuildItemCard(
                  item: item,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
