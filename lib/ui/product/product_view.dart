import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';

import '../../models/models.dart';
import '../../localizations/localizations.dart';
import '../../routing/routing.dart';
import '../ui.dart';
import '../../constants/constants.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  static MaterialPage page() {
    return MaterialPage(
      name: AppLinkLocationKeys.productView,
      key: const ValueKey(AppLinkLocationKeys.productView),
      child: const ProductView(),
    );
  }

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductViewModel>.reactive(
      viewModelBuilder: () => ProductViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            Scaffold(
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
                          _HeaderRow(viewModel: viewModel),

                          const Divider(
                            height: ProductSpacing.dividerHeight,
                            thickness: ProductSpacing.dividerThicknessPrimary,
                            color: ProductColors.dividerPrimary,
                          ),

                          Expanded(
                            child: ListView.separated(
                              itemCount: viewModel.productStateManager.products.length,
                              separatorBuilder: (context, index) => const Divider(
                                height: ProductSpacing.dividerHeight,
                                thickness: ProductSpacing.dividerThicknessSecondary,
                                color: ProductColors.dividerSecondary,
                              ),
                              itemBuilder: (context, index) {
                                final p = viewModel.productStateManager.products[index];
                                return _ProductRow(
                                  product: p,
                                  onEdit: () => viewModel.goToDetail(id: p.id),
                                  onDelete: () async {
                                    final confirmed = await showDialog<bool>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (_) => const DeleteConfirmation(),
                                    );

                                    if (confirmed == true) {
                                      viewModel.doDelete(p.id!);
                                    }
                                  },
                                );
                              },
                            ),
                          ),

                          if (viewModel.canLoadMore)
                            TextButton(
                              onPressed: viewModel.isBusy ? null : () => viewModel.doLoadMore(),
                              child: Text(LocaleKeys.buttons_loadMore.tr()),
                            ),

                          Padding(
                            padding: const EdgeInsets.all(ProductSpacing.bottomAreaPadding),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: () => viewModel.goToDetail(id: null),
                                child: Text(LocaleKeys.buttons_create.tr()),
                              ),
                            ),
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

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({required this.viewModel});

  final ProductViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
        );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ProductSpacing.rowPaddingHorizontal,
        vertical: ProductSpacing.rowPaddingVertical,
      ),
      child: Row(
        children: [
          _cell(LocaleKeys.productInfo_productId.tr(), flex: 5, style: style),
          _cell(LocaleKeys.productInfo_productName.tr(), flex: 2, style: style),
          _cell(LocaleKeys.productInfo_productDescription.tr(), flex: 3, style: style),
          _cell(LocaleKeys.productInfo_productPrice.tr(), flex: 2, style: style),
          _cell(LocaleKeys.productInfo_productStock.tr(), flex: 2, style: style),
          _cell(LocaleKeys.productInfo_productWaranty.tr(), flex: 2, style: style),
          _cell(LocaleKeys.productInfo_productCreatedDate.tr(), flex: 3, style: style),
          _cell(LocaleKeys.productInfo_productLastUpdate.tr(), flex: 3, style: style),
          SizedBox(
            width: ProductSearchFieldSize.width,
            height: ProductSearchFieldSize.height,
            child: TextField(
              controller: viewModel.searchController,
              onChanged: viewModel.onSearchChanged,
              decoration: InputDecoration(
                hintText: LocaleKeys.buttons_search.tr(),
                prefixIcon: const Icon(
                  Icons.search,
                  size: ProductSearchFieldSize.iconSize,
                ),
                border: const OutlineInputBorder(),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: ProductSearchFieldSize.contentPaddingVertical,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cell(String text, {required int flex, TextStyle? style}) {
    return Expanded(
      flex: flex,
      child: Text(text, style: style, overflow: TextOverflow.ellipsis),
    );
  }
}

class _ProductRow extends StatelessWidget {
  const _ProductRow({
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  final ProductPayload product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ProductSpacing.rowPaddingHorizontal,
        vertical: ProductSpacing.rowPaddingVertical,
      ),
      child: Row(
        children: [
          _cell(product.id, flex: 5, style: textStyle),
          _cell(product.name, flex: 2, style: textStyle),
          _cell(product.description, flex: 3, style: textStyle),
          _cell(product.price, flex: 2, style: textStyle),
          _cell(product.stock, flex: 2, style: textStyle),
          _cell('${product.warrantyInMonths} ${LocaleKeys.productInfo_months.tr()}', flex: 2, style: textStyle),
          _cell('${product.createdDate!.year}-${product.createdDate!.month}-${product.createdDate!.day}', flex: 3, style: textStyle),
          _cell('${product.updatedDate!.year}-${product.updatedDate!.month}-${product.updatedDate!.day}', flex: 3, style: textStyle),

          TextButton(onPressed: onEdit, child: Text(LocaleKeys.buttons_edit.tr())),
          const Text(ProductText.actionSeparator),
          TextButton(onPressed: onDelete, child: Text(LocaleKeys.buttons_delete.tr())),
        ],
      ),
    );
  }

  Widget _cell(Object? value, {required int flex, TextStyle? style}) {
    return Expanded(
      flex: flex,
      child: Text(value.toString(), style: style, overflow: TextOverflow.ellipsis),
    );
  }
}

class DeleteConfirmation extends StatelessWidget {
  const DeleteConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(LocaleKeys.buttons_deleteProduct.tr()),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(LocaleKeys.buttons_cancel.tr()),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(LocaleKeys.buttons_delete.tr()),
        ),
      ],
    );
  }
}
