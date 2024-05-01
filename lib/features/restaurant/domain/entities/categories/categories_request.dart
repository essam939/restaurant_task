import 'package:equatable/equatable.dart';

class CategoriesRequest extends Equatable{
  final int branchId;
 const CategoriesRequest({required this.branchId});
  Map<String, dynamic> toJson() {
    return {'branch_id': branchId};
  }

  @override
  List<Object?> get props => [branchId];
}