import 'package:archive_secure/data/credentials/bloc/credential_event.dart';
import 'package:archive_secure/data/credentials/bloc/credential_state.dart';
import 'package:archive_secure/data/credentials/domain/usecase/create_credential.dart';
import 'package:archive_secure/data/credentials/domain/usecase/delete_credential.dart';
import 'package:archive_secure/data/credentials/domain/usecase/get_credential_password.dart';
import 'package:archive_secure/data/credentials/domain/usecase/get_credentials.dart';
import 'package:archive_secure/data/credentials/domain/usecase/search_credentials.dart';
import 'package:archive_secure/data/credentials/domain/usecase/toggle_favorite.dart';
import 'package:archive_secure/data/credentials/domain/usecase/update_credential.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CredentialBloc extends Bloc<CredentialEvent, CredentialState> {
  CredentialBloc({
    required this._getCredentials,
    required this._searchCredentials,
    required this._createCredential,
    required this._updateCredential,
    required this._toggleFavorite,
    required this._deleteCredential,
    required this._getCredentialPassword,
  }) : super(CredentialInitial()) {
    on<LoadCredentials>(_onLoadCredentials);
    on<SearchCredentialsEvent>(_onSearchCredentials);
    on<CreateCredentialSubmitted>(_onCreateCredential);
    on<UpdateCredentialSubmitted>(_onUpdateCredential);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<DeleteCredentialEvent>(_onDeleteCredential);
    on<ViewCredentialPassword>(_onViewCredentialPassword);
  }

  final GetCredentials _getCredentials;
  final SearchCredentials _searchCredentials;
  final CreateCredential _createCredential;
  final UpdateCredential _updateCredential;
  final ToggleFavorite _toggleFavorite;
  final DeleteCredential _deleteCredential;
  final GetCredentialPassword _getCredentialPassword;

  Future<void> _onLoadCredentials(
    LoadCredentials event,
    Emitter<CredentialState> emit,
  ) async {
    emit(CredentialLoading());
    try {
      final credentials = await _getCredentials.call(
        categoryId: event.categoryId,
        favorite: event.favorite,
      );
      emit(CredentialsLoaded(credentials));
    } catch (e) {
      emit(CredentialFailure(_formatError(e)));
    }
  }

  Future<void> _onSearchCredentials(
    SearchCredentialsEvent event,
    Emitter<CredentialState> emit,
  ) async {
    emit(CredentialLoading());
    try {
      final credentials = await _searchCredentials.call(event.query);
      emit(CredentialsLoaded(credentials));
    } catch (e) {
      emit(CredentialFailure(_formatError(e)));
    }
  }

  Future<void> _onCreateCredential(
    CreateCredentialSubmitted event,
    Emitter<CredentialState> emit,
  ) async {
    emit(CredentialLoading());
    try {
      await _createCredential.call(
        serviceName: event.serviceName,
        loginEmail: event.loginEmail,
        username: event.username,
        password: event.password,
        categoryId: event.categoryId,
        notes: event.notes,
        tags: event.tags,
        strength: event.strength,
      );
      final credentials = await _getCredentials.call();
      emit(CredentialsLoaded(credentials));
    } catch (e) {
      emit(CredentialFailure(_formatError(e)));
    }
  }

  Future<void> _onUpdateCredential(
    UpdateCredentialSubmitted event,
    Emitter<CredentialState> emit,
  ) async {
    emit(CredentialLoading());
    try {
      await _updateCredential.call(
        event.id,
        serviceName: event.serviceName,
        loginEmail: event.loginEmail,
        username: event.username,
        password: event.password,
        categoryId: event.categoryId,
        notes: event.notes,
        tags: event.tags,
        strength: event.strength,
      );
      final credentials = await _getCredentials.call();
      emit(CredentialsLoaded(credentials));
    } catch (e) {
      emit(CredentialFailure(_formatError(e)));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<CredentialState> emit,
  ) async {
    try {
      await _toggleFavorite.call(event.id);
      final credentials = await _getCredentials.call();
      emit(CredentialsLoaded(credentials));
    } catch (e) {
      emit(CredentialFailure(_formatError(e)));
    }
  }

  Future<void> _onDeleteCredential(
    DeleteCredentialEvent event,
    Emitter<CredentialState> emit,
  ) async {
    emit(CredentialLoading());
    try {
      await _deleteCredential.call(event.id);
      final credentials = await _getCredentials.call();
      emit(CredentialsLoaded(credentials));
    } catch (e) {
      emit(CredentialFailure(_formatError(e)));
    }
  }

  Future<void> _onViewCredentialPassword(
    ViewCredentialPassword event,
    Emitter<CredentialState> emit,
  ) async {
    final previous = state;
    try {
      final result = await _getCredentialPassword.call(event.id);
      emit(PasswordLoaded(
        credentialId: result.credential.id,
        serviceName: result.credential.serviceName,
        password: result.password,
      ));
      if (previous is CredentialsLoaded) {
        emit(previous);
      }
    } catch (e) {
      if (previous is CredentialsLoaded) {
        emit(previous);
      }
      emit(CredentialFailure(_formatError(e)));
    }
  }

  String _formatError(Object e) {
    final message = e.toString();
    if (message.contains('403')) return 'No tienes permiso para esta acción';
    if (message.contains('404')) return 'Credencial no encontrada';
    if (message.contains('400') || message.contains('422')) {
      return 'Datos inválidos. Verifique la información.';
    }
    if (message.contains('SocketException') ||
        message.contains('Connection refused')) {
      return 'No se pudo conectar con el servidor';
    }
    return 'Error al procesar la solicitud. Intente de nuevo.';
  }
}
