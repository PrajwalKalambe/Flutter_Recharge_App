import 'package:equatable/equatable.dart';

class RechargeOption extends Equatable {
  final String id;
  final String name;
  final String icon;
  final String description;

  const RechargeOption({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });

  @override
  List<Object> get props => [id, name, icon, description];

  factory RechargeOption.fromJson(Map<String, dynamic> json) {
    return RechargeOption(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'description': description,
    };
  }
}