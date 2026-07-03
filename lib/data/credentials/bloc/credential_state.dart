import 'package:archive_secure/data/credentials/domain/entity/credential.dart';
import 'package:equatable/equatable.dart';

abstract class CredentialState extends Equatable {
  const CredentialState();

  @override
  List<Object?> get props => [];
}

class CredentialInitial extends CredentialState {}

class CredentialLoading extends CredentialState {}

class CredentialsLoaded extends CredentialState {
  final List<Credential> credentials;

  const CredentialsLoaded(this.credentials);

  @override
  List<Object?> get props => [credentials];
}

class CredentialSuccess extends CredentialState {
  final String message;

  const CredentialSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CredentialFailure extends CredentialState {
  final String error;

  const CredentialFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class PasswordLoaded extends CredentialState {
  final String credentialId;
  final String serviceName;
  final String password;

  const PasswordLoaded({
    required this.credentialId,
    required this.serviceName,
    required this.password,
  });

  @override
  List<Object?> get props => [credentialId, serviceName, password];
}
