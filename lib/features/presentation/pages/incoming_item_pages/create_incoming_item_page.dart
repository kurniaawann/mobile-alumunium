// create_incoming_item_page.dart
import 'package:flutter/material.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/common/widgets/custom_detail_chip.dart';
import 'package:mobile_alumunium/common/widgets/custom_information_textfield.dart';
import 'package:mobile_alumunium/common/widgets/custom_leading_appbar.dart';
import 'package:mobile_alumunium/common/widgets/custom_textfield.dart';
import 'package:mobile_alumunium/features/domain/entities/incoming_item/create_incoming_item.dart';
import 'package:mobile_alumunium/features/domain/entities/item/dropdown_item.dart';
import 'package:mobile_alumunium/features/presentation/getx/item/dropdown_item_controller.dart';
import 'package:mobile_alumunium/features/presentation/pages/incoming_item_pages/widgets/dropdown_item.dart';
import 'package:mobile_alumunium/service_locator.dart';

class CreateIncomingItemPage extends StatefulWidget {
  const CreateIncomingItemPage({super.key});

  @override
  State<CreateIncomingItemPage> createState() => _CreateIncomingItemPageState();
}

class _CreateIncomingItemPageState extends State<CreateIncomingItemPage> {
  final List<CreateIncomingItem> _items = []; // List untuk menyimpan item
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  void _addItem() {
    bool allValid = _formKeys.every((key) => key.currentState!.validate());
    if (allValid) {
      final newItem = CreateIncomingItem(
        itemName: _itemNameController.text,
        itemCode: int.tryParse(_itemCodeController.text),
        width: _widthController.text.isEmpty
            ? null
            : int.tryParse(_widthController.text),
        height: _heightController.text.isEmpty
            ? null
            : int.tryParse(_heightController.text),
        // quantity: int.tryParse(_quantityController.text) ?? 1,
        quantity: _quantityController.text.isEmpty
            ? null
            : int.tryParse(_quantityController.text),
        isFromDropdown: selectedItem != null,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      );

      setState(() {
        _items.add(newItem);
        _resetForm();
      });
    }
  }

  void _editItem(int index) {
    final item = _items[index];
    setState(() {
      _itemNameController.text = item.itemName;
      _itemCodeController.text = item.itemCode?.toString() ?? '';
      _widthController.text =
          item.width?.toString() ?? '0'; // Ubah null menjadi '0'
      _heightController.text =
          item.height?.toString() ?? '0'; // Ubah null menjadi '0'
      _quantityController.text = item.quantity?.toString() ?? '1';

      // Jika item dari dropdown, set selected item
      if (item.isFromDropdown) {
        selectedItem = DropdownItemEntity(
          itemName: item.itemName,
          itemCode: item.itemCode,
          width: item.width ?? 0, // Tambahkan default value 0 jika null
          height: item.height ?? 0, // Tambahkan default value 0 jika null
        );
      } else {
        selectedItem = null;
      }

      _items
          .removeAt(index); // Hapus item lama untuk diganti dengan yang diedit
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  late final TextEditingController _itemNameController;
  late final TextEditingController _itemCodeController;
  late final TextEditingController _quantityController;
  late final TextEditingController _heightController;
  late final TextEditingController _widthController;

  final dropdownItemController = serviceLocator<DropdownItemController>();
  DropdownItemEntity? selectedItem;

  @override
  void initState() {
    _itemNameController = TextEditingController();
    _itemCodeController = TextEditingController();
    _quantityController = TextEditingController();
    _heightController = TextEditingController();
    _widthController = TextEditingController();

    // dropdownItemController.getDataDropdownItem('', 1);
    dropdownItemController.getDataDropdownItem('', 1);
    super.initState();
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemCodeController.dispose();
    _quantityController.dispose();
    _heightController.dispose();
    _widthController.dispose();
    dropdownItemController.resetState();
    super.dispose();
  }

  void _onItemSelected(DropdownItemEntity? item) {
    setState(() {
      selectedItem = item;
      if (item != null) {
        _itemNameController.text = item.itemName;
        _itemCodeController.text = item.itemCode.toString();
        _widthController.text =
            item.width?.toString() ?? '0'; // Ubah null menjadi '0'
        _heightController.text =
            item.height?.toString() ?? '0'; // Ubah null menjadi '0'
      } else {
        _itemNameController.clear();
        _itemCodeController.clear();
        _widthController.clear();
        _heightController.clear();
      }
    });
  }

  void _resetForm() {
    setState(() {
      selectedItem = null;
      _itemNameController.clear();
      _itemCodeController.clear();
      _quantityController.clear();
      _widthController.clear();
      _heightController.clear();
      dropdownItemController.resetState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Barang Masuk',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
        leading: CustomLeadingAppbar(
          onPressed: _resetForm,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        children: [
          CustomInformationTextfield(
            message:
                'Jika barang yang masuk sudah ada maka silahkan pilih dengan dropdown',
          ),
          const SizedBox(height: 20),
          //!Drop down
          PaginatedDropdown(
            controller: dropdownItemController,
            onSelected: _onItemSelected,
            hintText: 'Pilih Barang',
            labelText: 'Barang yang Sudah Ada',
            selectedValue: selectedItem,
          ),
          const SizedBox(height: 20),
          //!Nama barang
          CustomTextfield(
            hintText: 'Masukkan nama barang baru',
            labelText: 'Nama Barang',
            validator: (value) =>
                value?.isEmpty ?? true ? 'Nama barang wajib diisi' : null,
            textEditingController: _itemNameController,
            enabled: selectedItem == null,
            formKey: _formKeys[0],
          ),
          const SizedBox(height: 20),
          //!kode barag
          CustomTextfield(
            hintText: selectedItem != null
                ? 'Kode barang terisi otomatis'
                : 'Masukkan kode barang baru (opsional)',
            labelText: 'Kode Barang',
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                if (int.tryParse(value) == null) {
                  return 'Harus berupa angka';
                }
              }
              return null;
            },
            textEditingController: _itemCodeController,
            enabled: selectedItem == null,
            formKey: _formKeys[1],
            // keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          //!quantity
          CustomTextfield(
            hintText: 'Masukkan quantity',
            labelText: 'Quantity',
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Jumlah wajib diisi';
              if (int.tryParse(value!) == null) return 'Harus berupa angka';
              if (int.parse(value) <= 0) return 'Jumlah harus lebih dari 0';
              return null;
            },
            textEditingController: _quantityController,
            // keyboardType: TextInputType.number,
            formKey: _formKeys[2],
          ),
          const SizedBox(height: 20),
          CustomTextfield(
            hintText: 'Masukkan tinggi barang (Opsional)',
            labelText: 'Tinggi Barang',
            textEditingController: _heightController,
            enabled: selectedItem == null,
            formKey: _formKeys[3],
            // keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          CustomTextfield(
            hintText: 'Masukkan lebar barang (Opsional)',
            labelText: 'Lebar Barang',
            textEditingController: _widthController,
            enabled: selectedItem == null,
            formKey: _formKeys[4],
            // keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _addItem,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('TAMBAH KE LIST'),
          ),
          const SizedBox(height: 30),
          if (_items.isNotEmpty)
            Divider(
              thickness: 2,
            ),

          if (_items.isNotEmpty) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        'Daftar Barang',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${_items.length} items',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey.shade700,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return Dismissible(
                      key: Key(item.id!),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: AppColors.errorColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.delete, color: AppColors.errorColor),
                      ),
                      onDismissed: (direction) => _deleteItem(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => _editItem(index),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.itemName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: item.isFromDropdown
                                              ? Colors.green.shade50
                                              : Colors.blue.shade50,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          item.isFromDropdown
                                              ? 'Dari Daftar'
                                              : 'Manual',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: item.isFromDropdown
                                                    ? AppColors.successColor
                                                    : AppColors.primaryColor,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 8,
                                    children: [
                                      if (item.itemCode != null)
                                        CustomDetailChip(
                                            icon: Icons.tag,
                                            text: 'Kode: ${item.itemCode}'),
                                      if (item.width != null)
                                        CustomDetailChip(
                                            icon: Icons.straighten,
                                            text: 'Lebar: ${item.width} cm'),
                                      if (item.height != null)
                                        CustomDetailChip(
                                            icon: Icons.height,
                                            text: 'Tinggi: ${item.height} cm'),
                                      CustomDetailChip(
                                          icon: Icons.format_list_numbered,
                                          text: 'Jumlah: ${item.quantity}',
                                          isHighlighted: true),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _items.isEmpty
                        ? null
                        : () {
                            // Simpan semua item ke database atau API
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: AppColors.primaryColor,
                    ),
                    icon: const Icon(Icons.save, size: 20),
                    label: Text(
                      'Buat Barang Masuk',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.primaryWhiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

// Helper Widget for Detail Chips
}
