// create_incoming_item_page.dart
import 'package:flutter/material.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/common/widgets/custom_information_textfield.dart';
import 'package:mobile_alumunium/common/widgets/custom_leading_appbar.dart';
import 'package:mobile_alumunium/common/widgets/custom_textfield.dart';
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
  final List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  late final TextEditingController _itemNameController;
  late final TextEditingController _itemCodeController;
  late final TextEditingController _quantityController;

  final dropdownItemController = serviceLocator<DropdownItemController>();
  DropdownItemEntity? selectedItem;

  @override
  void initState() {
    _itemNameController = TextEditingController();
    _itemCodeController = TextEditingController();
    _quantityController = TextEditingController();
    dropdownItemController.getDataDropdownItem('', 1);
    super.initState();
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemCodeController.dispose();
    _quantityController.dispose();
    dropdownItemController.resetState();
    super.dispose();
  }

  void _onItemSelected(DropdownItemEntity? item) {
    setState(() {
      selectedItem = item;
      if (item != null) {
        _itemNameController.text = item.itemName;
        _itemCodeController.text = item.itemCode.toString();
      } else {
        _itemNameController.clear();
        _itemCodeController.clear();
      }
    });
  }

  void _resetForm() {
    setState(() {
      selectedItem = null;
      _itemNameController.clear();
      _itemCodeController.clear();
      _quantityController.clear();
      dropdownItemController.resetState();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          Column(
            children: [
              CustomInformationTextfield(
                message:
                    'Jika barang yang masuk sudah ada maka silahkan pilih dengan dropdown',
              ),
              const SizedBox(height: 20),
              PaginatedDropdown(
                controller: dropdownItemController,
                onSelected: _onItemSelected,
                hintText: 'Pilih Barang',
                labelText: 'Barang yang Sudah Ada',
                selectedValue: selectedItem,
              ),
              const SizedBox(height: 20),

              // Manual input for new items
              CustomTextfield(
                hintText: 'Masukkan nama barang baru',
                labelText: 'Nama Barang',
                formKey: formKeys[0],
                textEditingController: _itemNameController,
                enabled: selectedItem == null,
              ),

              const SizedBox(height: 20),
              CustomTextfield(
                hintText: selectedItem != null
                    ? 'Kode barang terisi otomatis'
                    : 'Masukkan kode barang baru',
                labelText: 'Kode Barang',
                formKey: formKeys[1],
                textEditingController: _itemCodeController,
                enabled: selectedItem == null,
              ),
            ],
          ),
          const SizedBox(height: 25),
          CustomTextfield(
            hintText: 'Masukkan jumlah stock',
            labelText: 'Jumlah Stock',
            formKey: formKeys[2],
            textEditingController: _quantityController,
            // keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'SIMPAN DATA',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
