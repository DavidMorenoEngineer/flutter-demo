import 'package:equatable/equatable.dart';

class ResourceItem extends Equatable {
  const ResourceItem({required this.category, required this.title, this.isTool = false});

  final String category;
  final String title;

  /// Tools open interactively ("Open it"); articles are read ("Read it").
  final bool isTool;

  @override
  List<Object?> get props => [category, title, isTool];
}
