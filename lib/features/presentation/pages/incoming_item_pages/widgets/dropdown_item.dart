import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/status_enum/state_enum.dart';
import 'package:mobile_alumunium/features/domain/entities/item/dropdown_item.dart';
import 'package:mobile_alumunium/features/presentation/getx/item/dropdown_item_controller.dart';

class PaginatedDropdown extends StatefulWidget {
  final DropdownItemController controller;
  final Function(DropdownItemEntity?) onSelected;
  final String hintText;
  final String labelText;
  final DropdownItemEntity? selectedValue;

  const PaginatedDropdown({
    super.key,
    required this.controller,
    required this.onSelected,
    required this.hintText,
    required this.labelText,
    this.selectedValue,
  });

  @override
  State<PaginatedDropdown> createState() => _PaginatedDropdownState();
}

class _PaginatedDropdownState extends State<PaginatedDropdown> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;
  final ScrollController _scrollController = ScrollController();
  Timer? _searchDebounce; // Tambahkan debounce timer

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    _scrollController.addListener(_onScroll);
    // Initial load
    widget.controller.getDataDropdownItem('', 1);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    _removeDropdown();
    super.dispose();
  }

  void _handleSearch(String value) {
    _searchDebounce?.cancel(); // Cancel previous timer

    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      if (value != widget.controller.searchQuery.value) {
        widget.controller.setSearchQuery(value);
        widget.controller.getDataDropdownItem(value, 1, reset: true);
      }
    });
  }

  void _onFocusChange() {
    // if (!_focusNode.hasFocus && _searchController.text.isNotEmpty) {
    //   widget.controller.searchQuery.value = _searchController.text;
    //   widget.controller.getDataDropdownItem(
    //       _searchController.text, widget.controller.currentPage.value,
    //       reset: false);
    // }
    if (!_focusNode.hasFocus) {
      // Kirim pencarian terakhir saat kehilangan fokus
      _handleSearch(_searchController.text);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        widget.controller.hasMore.value &&
        !widget.controller.isLoading.value) {
      widget.controller.getDataDropdownItem(widget.controller.searchQuery.value,
          widget.controller.currentPage.value);
    }
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _removeDropdown();
    } else {
      _showDropdown();
    }
  }

  void _showDropdown() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 300),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Search field
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Cari...',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: _handleSearch,
                    ),
                  ),

                  // Dropdown items
                  Expanded(
                    child: Obx(() {
                      if (widget.controller.state == RequestState.loading &&
                          widget.controller.dropdownItemList.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (widget.controller.state == RequestState.error) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              widget.controller.message.value,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }

                      return NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollNotification.metrics.pixels ==
                                  scrollNotification.metrics.maxScrollExtent &&
                              widget.controller.hasMore.value &&
                              !widget.controller.isLoading.value) {
                            widget.controller.getDataDropdownItem(
                                widget.controller.searchQuery.value,
                                widget.controller.currentPage.value);
                          }
                          return false;
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          controller: _scrollController,
                          itemCount: widget.controller.dropdownItemList.length +
                              (widget.controller.isLoading.value &&
                                      widget.controller.dropdownItemList
                                          .isNotEmpty
                                  ? 1
                                  : 0),
                          itemBuilder: (context, index) {
                            if (index >=
                                widget.controller.dropdownItemList.length) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            final item =
                                widget.controller.dropdownItemList[index];
                            return InkWell(
                              onTap: () {
                                widget.onSelected(item);
                                _removeDropdown();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                child:
                                    Text('${item.itemName} (${item.itemCode})'),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _isDropdownOpen = true;
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isDropdownOpen = false;
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: InkWell(
            onTap: _toggleDropdown,
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: widget.labelText,
                hintText: widget.hintText,
                border: const OutlineInputBorder(),
                errorText: widget.controller.state == RequestState.error
                    ? widget.controller.message.value
                    : null,
                suffixIcon: const Icon(Icons.arrow_drop_down),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.selectedValue != null
                          ? '${widget.selectedValue!.itemName} (${widget.selectedValue!.itemCode})'
                          : widget.hintText,
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.selectedValue != null
                            ? Colors.black
                            : Theme.of(context).hintColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
