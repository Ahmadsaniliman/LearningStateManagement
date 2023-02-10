import 'package:uuid/uuid.dart';

class BreadCrumb {
  final String name;
  bool isActive;
  final String id;

  BreadCrumb({
    required this.name,
    required this.isActive,
  }) : id = const Uuid().v4();

  void activate() {
    isActive = true;
  }

  @override
  bool operator ==(covariant BreadCrumb other) => id == other.id;

  @override
  int get hashCode => id.hashCode;

  String get title => name + (isActive ? ' >' : '');
//   String get title => isActive ? '$name + >' : '';
}
