import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../routing/routing.dart';
import '../../localizations/localizations.dart';
import '../ui.dart';
import '../../constants/constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static MaterialPage page() {
    return const MaterialPage(
      name: AppLinkLocationKeys.homeView,
      key: ValueKey(AppLinkLocationKeys.homeView),
      child: HomeView(),
    );
  }

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) {
        final total = viewModel.productPageSet?.total;

        return Stack(
          children: [
            Scaffold(
              backgroundColor: HomeColors.background,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (total == null || total == 0)
                      Text(
                        LocaleKeys.homeInfo_noProducts.tr(),
                        style: const TextStyle(fontSize: HomeTextSize.info),
                      )
                    else if (total == 1)
                      Text(
                        '${LocaleKeys.homeInfo_totalProduct.tr()}: $total',
                        style: const TextStyle(fontSize: HomeTextSize.info),
                      )
                    else
                      Text(
                        '${LocaleKeys.homeInfo_totalProducts.tr()}: $total',
                        style: const TextStyle(fontSize: HomeTextSize.info),
                      ),
                  ],
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