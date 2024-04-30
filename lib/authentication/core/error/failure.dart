import 'package:equatable/equatable.dart';
import 'package:restaurant/authentication/core/service/remote/error_message_remote.dart';

abstract class Failure extends Equatable {
  final ErrorMessageModel errorMessageModel;
  const Failure(this.errorMessageModel);

  @override
  List<Object> get props => [errorMessageModel];
}