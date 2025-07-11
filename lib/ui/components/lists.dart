import 'package:flutter/material.dart';

import 'loadings.dart';
import 'placeholders.dart';

/// This is a custom list view for standardized UX.
/// Includes:
/// 1. On refresh to be used to recall the API.
/// 2. Loading handler.
/// 3. Error handler & placeholder.
class VList extends StatelessWidget {
  final bool loading;
  final String errorMsg;
  final int length;
  final Widget? emptyPlaceHolder;
  final Future<void> Function() onRefresh;
  final double? height;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final ScrollController? controller;
  final Axis scrollDirection;
  final Widget? separator;
  final Widget Function(BuildContext c, int i) itemBuilder;

  const VList({
    required this.loading,
    required this.length,
    required this.itemBuilder,
    required this.onRefresh,

    /// Error message should not be hardcoded except empty string
    required this.errorMsg,
    this.emptyPlaceHolder,
    this.height,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.separator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) return const VLoading();
    if (errorMsg.isNotEmpty) return VError(errorMsg);
    if (length == 0) return Center(child: emptyPlaceHolder ?? const NoData());
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        scrollDirection: scrollDirection,
        controller: controller,
        shrinkWrap: shrinkWrap,
        physics: physics,
        padding: padding ?? const EdgeInsets.all(16.0),
        itemCount: length,
        separatorBuilder: (c, i) => separator ?? Divider(height: height),
        itemBuilder: itemBuilder,
      ),
    );
  }
}

/// This is a custom list view for standardized pagination UX.
/// Includes:
/// 1. [onRefresh] to be used to recall the API.
/// 2. Loading handler.
/// 3. Error handler & placeholder.
/// 4. [onNext] to handle user has scrolled to the max.
class VPaginatedList extends StatelessWidget {
  final bool loading;
  final int page;
  final String errorMsg;
  final int length;
  final Widget? emptyPlaceHolder;
  final Future<void> Function() onRefresh;
  final Widget Function(BuildContext c, int i) itemBuilder;
  final double? height;
  final EdgeInsets? padding;
  final Function onNext;
  final Color? dividerColor;
  final Axis scrollDirection;
  final Widget? separator;
  final Widget? loadingPlaceholder;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;

  const VPaginatedList({
    super.key,
    required this.loading,
    required this.page,
    required this.length,
    required this.itemBuilder,
    required this.onNext,
    required this.onRefresh,
    this.height,
    this.padding,
    required this.errorMsg,
    this.emptyPlaceHolder,
    this.dividerColor,
    this.scrollDirection = Axis.vertical,
    this.separator,
    this.loadingPlaceholder,
    this.scrollController,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    if (loading && page == 1) {
      return loadingPlaceholder ?? const VLoading();
    }
    if (errorMsg.isNotEmpty && page == 1) {
      return VError(errorMsg);
    }
    if (length == 0) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: emptyPlaceHolder ?? const NoData(),
        ),
      );
    }
    return Stack(
      children: [
        NotificationListener(
          /// Refresh indicator is supposed to be within Stack to make it work
          /// for both iOS and Android
          child: RefreshIndicator(
            onRefresh: onRefresh, // must return async
            child: ListView.separated(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: physics,
              controller: scrollController,
              scrollDirection: scrollDirection,
              padding: padding ?? const EdgeInsets.all(16.0),
              itemCount: length,
              separatorBuilder: (c, i) =>
                  separator ??
                  Divider(
                    height: height,
                    color: dividerColor,
                  ),
              itemBuilder: itemBuilder,
            ),
          ),
          onNotification: (ScrollUpdateNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              onNext();
            }
            return true;
          },
        ),
        if (loading && page > 1) const NextPageLoading(),
      ],
    );
  }
}
