import 'package:flutter/cupertino.dart';

enum PagesId { dashboard, products }

@immutable
class PageItem {
  final PagesId id;
  final String title;
  final String appBarTitle;
  final IconData icon;

  const PageItem({
    required this.id,
    required this.title,
    required this.appBarTitle,
    required this.icon
  });

  PageItem copyWith({
    PagesId? id,
    String? title,
    String? appBarTitle,
    IconData? icon,
  }) {
    return PageItem(
      id: id ?? this.id,
      title: title ?? this.title, 
      appBarTitle: appBarTitle ?? this.appBarTitle,
      icon: icon ?? this.icon
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PageItem &&
      id == id &&
      title == title &&
      appBarTitle == appBarTitle &&
      icon == icon;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ appBarTitle.hashCode ^ icon.hashCode;

}