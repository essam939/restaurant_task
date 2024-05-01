import 'package:equatable/equatable.dart';

class ProductsRequest extends Equatable{
  final int branchId;
  final int categoryId;
  const ProductsRequest({required this.branchId,required this.categoryId});
  Map<String, dynamic> toJson() {
    return {'branch_id': branchId,'category_id': categoryId};
  }

  @override
  List<Object?> get props => [branchId, categoryId];
}