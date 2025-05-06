import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/features/domain/entities/incoming_item/incoming_item.dart';

class IncomingItemPage extends StatelessWidget {
  final List<IncomingItemEntity> dummyItems = [
    IncomingItemEntity(
      incomingItemsId: '1',
      itemId: '101',
      quantity: 50,
      receivedBy: 'John Doe',
      priceIncomingItem: 1250000,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    IncomingItemEntity(
      incomingItemsId: '2',
      itemId: '102',
      quantity: 120,
      receivedBy: 'Jane Smith',
      priceIncomingItem: 2750000,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    IncomingItemEntity(
      incomingItemsId: '3',
      itemId: '103',
      quantity: 75,
      receivedBy: 'Robert Johnson',
      priceIncomingItem: 1850000,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now(),
    ),
  ];

  IncomingItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Incoming Items',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.scaffoldBackground,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: AppColors.primaryColor),
            onPressed: () => _addNewItem(context),
          ),
        ],
      ),
      backgroundColor: AppColors.scaffoldBackground,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: dummyItems.length,
          itemBuilder: (context, index) {
            final item = dummyItems[index];
            return _buildIncomingItemCard(item, context);
          },
        ),
      ),
    );
  }

  Widget _buildIncomingItemCard(IncomingItemEntity item, BuildContext context) {
    final theme = Theme.of(context);
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'INCOMING STOCK',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: AppColors.primaryColor,
                    letterSpacing: 1.2,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.successColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'COMPLETED',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppColors.successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildActionMenu(item, context),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Main content
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoItem(
                  context: context,
                  icon: Icons.inventory,
                  title: 'Quantity',
                  value: '${item.quantity} pcs',
                  color: AppColors.primaryColor,
                ),
                _buildInfoItem(
                  context: context,
                  icon: Icons.person,
                  title: 'Received By',
                  value: item.receivedBy,
                  color: AppColors.infoColor,
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoItem(
                  context: context,
                  icon: Icons.attach_money,
                  title: 'Total Price',
                  value: currencyFormat.format(item.priceIncomingItem),
                  color: AppColors.successColor,
                ),
                _buildInfoItem(
                  context: context,
                  icon: Icons.calendar_today,
                  title: 'Received Date',
                  value: DateFormat('dd MMM yyyy').format(item.createdAt),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transaction ID: ${item.incomingItemsId}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  'Updated: ${DateFormat('dd MMM yyyy HH:mm').format(item.updatedAt)}',
                  style: theme.textTheme.bodySmall?.copyWith(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionMenu(IncomingItemEntity item, BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      color: AppColors.primaryWhiteColor,
      icon: Icon(Icons.more_vert, color: AppColors.textSecondary),
      onSelected: (value) {
        if (value == 'edit') _editItem(context, item);
        if (value == 'delete') _confirmDelete(context, item);
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'edit',
          child: ListTile(
            leading: Icon(Icons.edit, color: AppColors.primaryColor),
            title: Text('Edit', style: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: ListTile(
            leading: Icon(Icons.delete, color: AppColors.errorColor),
            title:
                Text('Delete', style: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            Text(
              title,
              style: theme.textTheme.labelMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _addNewItem(BuildContext context) {
    // Implement add new item functionality
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddIncomingItemPage()),
    );
  }

  void _editItem(BuildContext context, IncomingItemEntity item) {
    // Implement edit item functionality
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditIncomingItemPage(item: item),
        ));
  }

  Future<void> _confirmDelete(
      BuildContext context, IncomingItemEntity item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Confirm Delete',
          style: Theme.of(ctx).textTheme.titleLarge,
        ),
        content: Text(
          'Delete ${item.receivedBy}\'s incoming item?',
          style: Theme.of(ctx).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            child: Text(
              'CANCEL',
              style: Theme.of(ctx).textTheme.labelLarge,
            ),
            onPressed: () => Navigator.of(ctx).pop(false),
          ),
          TextButton(
            child: Text(
              'DELETE',
              style: Theme.of(ctx).textTheme.labelLarge?.copyWith(
                    color: AppColors.errorColor,
                  ),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      _deleteItem(context, item);
    }
  }

  void _deleteItem(BuildContext context, IncomingItemEntity item) {
    // Implement delete functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Deleted ${item.receivedBy}\'s item',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.primaryWhiteColor,
              ),
        ),
        backgroundColor: AppColors.successColor,
      ),
    );

    // In real app, you would call your delete API here
    // and update the state accordingly
  }
}

// Placeholder pages for add/edit (create these separately)
class AddIncomingItemPage extends StatelessWidget {
  const AddIncomingItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Item')),
      body: Center(child: Text('Add Item Form')),
    );
  }
}

class EditIncomingItemPage extends StatelessWidget {
  final IncomingItemEntity item;

  const EditIncomingItemPage({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Item')),
      body: Center(child: Text('Edit Form for ${item.receivedBy}')),
    );
  }
}
