import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';

import '../../models/models.dart';
import '../../localizations/localizations.dart';
import '../ui.dart';
import '../../routing/routing.dart';
import '../../constants/constants.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key, required this.id});

  final String? id;

  static MaterialPage page({required String? id}) {
    final name = (id == null || id.isEmpty)
        ? AppLinkLocationKeys.productCreateView
        : '/product/$id/edit';

    return MaterialPage(
      name: name,
      key: ValueKey(name),
      child: ProductDetailView(id: id),
    );
  }

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  late final TextEditingController _id = TextEditingController();
  late final TextEditingController _name = TextEditingController();
  late final TextEditingController _description = TextEditingController();
  late final TextEditingController _price = TextEditingController();
  late final TextEditingController _availableStock = TextEditingController();
  late final TextEditingController _warrantyInMonths = TextEditingController();
  late final TextEditingController _createdDate = TextEditingController();
  late final TextEditingController _updatedDate = TextEditingController();

  bool _isAvailable = true;

  // Not UI constants — OK to keep here
  final List<bool> _availabilityOptions = const <bool>[true, false];

  bool get _isEditMode => widget.id != null && widget.id!.isNotEmpty;

  @override
  void dispose() {
    _id.dispose();
    _name.dispose();
    _description.dispose();
    _price.dispose();
    _availableStock.dispose();
    _warrantyInMonths.dispose();
    _createdDate.dispose();
    _updatedDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDetailViewModel>.reactive(
      viewModelBuilder: () => ProductDetailViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.loadDetail(widget.id);
      },
      builder: (context, viewModel, child) {
        final p = viewModel.productStateManager.product;

        if (p != null) {
          _id.text = p.id ?? '';
          _name.text = p.name ?? '';
          _description.text = p.description ?? '';
          _price.text = p.price.toString();
          _availableStock.text = p.stock.toString();
          _warrantyInMonths.text = p.warrantyInMonths.toString();
          _createdDate.text = p.createdDate.toString();
          _updatedDate.text = p.updatedDate.toString();
        }

        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(),
              backgroundColor: ProductColors.pageBackground,
              body: SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(ProductSpacing.pagePadding),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ProductColors.containerBorderColor,
                          width: ProductSpacing.containerBorderWidth,
                        ),
                        color: ProductColors.containerBackground,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.productInfo_productDetail.tr(),
                            style: const TextStyle(
                              fontSize: ProductTextSize.detailTitle,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Divider(
                            height: ProductSpacing.dividerHeight,
                            thickness: ProductSpacing.dividerThicknessPrimary,
                            color: ProductColors.dividerPrimary,
                          ),

                          if (_isEditMode)
                            TextField(
                              controller: _id,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: LocaleKeys.productInfo_productId.tr(),
                              ),
                            ),

                          TextField(
                            controller: _name,
                            decoration: InputDecoration(
                              labelText: LocaleKeys.productInfo_productName.tr(),
                            ),
                          ),

                          TextField(
                            controller: _description,
                            decoration: InputDecoration(
                              labelText: LocaleKeys.productInfo_productDescription.tr(),
                            ),
                          ),

                          TextField(
                            controller: _price,
                            decoration: InputDecoration(
                              labelText: LocaleKeys.productInfo_productPrice.tr(),
                            ),
                          ),

                          DropdownButton<bool>(
                            value: _isAvailable,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: ProductDropdownStyle.elevation,
                            style: const TextStyle(color: ProductColors.dropdownText),
                            underline: Container(
                              height: ProductDropdownStyle.underlineHeight,
                              color: ProductColors.dropdownUnderline,
                            ),
                            onChanged: (bool? value) {
                              if (value == null) return;
                              setState(() => _isAvailable = value);
                            },
                            items: _availabilityOptions
                                .map<DropdownMenuItem<bool>>((bool value) {
                              return DropdownMenuItem<bool>(
                                value: value,
                                child: Text(
                                  value
                                      ? LocaleKeys.productInfo_available.tr()
                                      : LocaleKeys.productInfo_unavailable.tr(),
                                ),
                              );
                            }).toList(),
                          ),

                          const Divider(
                            height: ProductSpacing.sectionDividerHeight,
                            thickness: ProductSpacing.sectionDividerThickness,
                            color: ProductColors.dividerPrimary,
                          ),

                          TextField(
                            controller: _warrantyInMonths,
                            decoration: InputDecoration(
                              labelText: LocaleKeys.productInfo_productWaranty.tr(),
                            ),
                          ),

                          if (_isEditMode)
                            TextField(
                              controller: _createdDate,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: LocaleKeys.productInfo_productCreatedDate.tr(),
                              ),
                            ),

                          if (_isEditMode)
                            DatePickerExample(
                              initialDate: DateTime.tryParse(_updatedDate.text),
                              onDateSelected: (date) {
                                setState(() {
                                  _updatedDate.text =
                                      DateFormat(ProductDatePicker.displayFormat).format(date);
                                });
                              },
                            ),

                          if (_isEditMode)
                            const Divider(
                              height: ProductSpacing.sectionDividerHeight,
                              thickness: ProductSpacing.sectionDividerThickness,
                              color: ProductColors.dividerPrimary,
                            ),

                          const SizedBox(height: ProductSpacing.gapLarge),

                          ElevatedButton(
                            onPressed: () async {
                              final updated = ProductPayload(
                                id: _id.text.trim(),
                                name: _name.text.trim(),
                                description: _description.text.trim(),
                                price: double.tryParse(_price.text.trim()) ?? 0.0,
                                stock: _isAvailable,
                                warrantyInMonths:
                                    int.tryParse(_warrantyInMonths.text.trim()) ?? 0,
                                createdDate: DateTime.tryParse(_createdDate.text.trim()),
                                updatedDate: DateTime.tryParse(_updatedDate.text.trim()),
                              );
                              await viewModel.doSave(updated, widget.id);
                            },
                            child: Text(LocaleKeys.buttons_save.tr()),
                          ),

                          const SizedBox(height: ProductSpacing.gapMedium),

                          ElevatedButton(
                            onPressed: viewModel.doCancel,
                            child: Text(LocaleKeys.buttons_cancel.tr()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (viewModel.isBusy) const Center(child: CircularProgressIndicator()),
          ],
        );
      },
    );
  }
}

class DatePickerExample extends StatefulWidget {
  const DatePickerExample({
    super.key,
    required this.onDateSelected,
    this.initialDate,
  });

  final ValueChanged<DateTime> onDateSelected;
  final DateTime? initialDate;

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(ProductDatePicker.firstYear),
      lastDate: DateTime(ProductDatePicker.lastYear),
    );

    if (pickedDate == null) return;

    setState(() => selectedDate = pickedDate);
    widget.onDateSelected(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    final dateText = selectedDate != null
        ? DateFormat(ProductDatePicker.displayFormat).format(selectedDate!)
        : LocaleKeys.productInfo_noDateSelected.tr();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(dateText),
        OutlinedButton(
          onPressed: _selectDate,
          child: Text(LocaleKeys.buttons_selectUpdatedDate.tr()),
        ),
      ],
    );
  }
}
