import 'package:equatable/equatable.dart';

abstract class CredentialEvent extends Equatable {
  const CredentialEvent();

  @override
  List<Object?> get props => [];
}

class LoadCredentials extends CredentialEvent {
  final String? categoryId;
  final bool? favorite;

  const LoadCredentials({this.categoryId, this.favorite});

  @override
  List<Object?> get props => [categoryId, favorite];
}

class SearchCredentialsEvent extends CredentialEvent {
  final String query;

  const SearchCredentialsEvent({required this.query});

  @override
  List<Object?> get props => [query];
}

class CreateCredentialSubmitted extends CredentialEvent {
  final String serviceName;
  final String? loginEmail;
  final String? username;
  final String password;
  final String? categoryId;
  final String? notes;
  final List<String>? tags;
  final int? strength;

  const CreateCredentialSubmitted({
    required this.serviceName,
    this.loginEmail,
    this.username,
    required this.password,
    this.categoryId,
    this.notes,
    this.tags,
    this.strength,
  });

  @override
  List<Object?> get props => [
        serviceName,
        loginEmail,
        username,
        password,
        categoryId,
        notes,
        tags,
        strength,
      ];
}

class UpdateCredentialSubmitted extends CredentialEvent {
  final String id;
  final String? serviceName;
  final String? loginEmail;
  final String? username;
  final String? password;
  final String? categoryId;
  final String? notes;
  final List<String>? tags;
  final int? strength;

  const UpdateCredentialSubmitted({
    required this.id,
    this.serviceName,
    this.loginEmail,
    this.username,
    this.password,
    this.categoryId,
    this.notes,
    this.tags,
    this.strength,
  });

  @override
  List<Object?> get props => [
        id,
        serviceName,
        loginEmail,
        username,
        password,
        categoryId,
        notes,
        tags,
        strength,
      ];
}

class ToggleFavoriteEvent extends CredentialEvent {
  final String id;

  const ToggleFavoriteEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteCredentialEvent extends CredentialEvent {
  final String id;

  const DeleteCredentialEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class ViewCredentialPassword extends CredentialEvent {
  final String id;

  const ViewCredentialPassword({required this.id});

  @override
  List<Object?> get props => [id];
}
