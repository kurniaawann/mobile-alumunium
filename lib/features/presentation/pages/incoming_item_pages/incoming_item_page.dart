import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/status_enum/state_enum.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/features/domain/entities/incoming_item/incoming_item.dart';
import 'package:mobile_alumunium/features/presentation/getx/incoming_item/incoming_item_controller.dart';
import 'package:mobile_alumunium/features/presentation/pages/incoming_item_pages/widgets/incomng_item_body.dart';
import 'package:mobile_alumunium/routes/route_name.dart';
import 'package:mobile_alumunium/service_locator.dart';

class IncomingItemPage extends StatefulWidget {
  const IncomingItemPage({super.key});

  @override
  State<IncomingItemPage> createState() => _IncomingItemPageState();
}

class _IncomingItemPageState extends State<IncomingItemPage> {
  final IncomingItemController incomingItemController =
      serviceLocator<IncomingItemController>();

  @override
  void initState() {
    incomingItemController.getDataIncomingItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Barang Masuk',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: AppColors.primaryColor),
            onPressed: () => Get.toNamed(RouteName.createIncomingItemPage),
          ),
        ],
      ),
      body: Obx(() {
        switch (incomingItemController.state) {
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestState.loaded:
            final incomingItem = incomingItemController.incomingItemList;

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: incomingItem.length,
              itemBuilder: (context, index) {
                final item = incomingItem[index];
                return IncomngItemBody(incomingItemEntity: item);
              },
            );
          case RequestState.error:
            return Center(child: Text(incomingItemController.message.value));
          case RequestState.empty:
            return const Center(child: Text('No data loaded yet'));
          case RequestState.success: // optional kalau pakai success
            return const Center(child: Text('Operation successful'));
        }
      }),
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
