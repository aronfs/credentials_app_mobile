import 'package:archive_secure/data/credentials/bloc/credential_bloc.dart';
import 'package:archive_secure/data/credentials/bloc/credential_event.dart';
import 'package:archive_secure/data/credentials/bloc/credential_state.dart';
import 'package:archive_secure/data/credentials/domain/entity/credential.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:archive_secure/navigation/route.dart';
import 'package:archive_secure/presentation/screens/pin_entry_page.dart';
import 'package:archive_secure/presentation/screens/widgets/credential_filter_tabs.dart';
import 'package:archive_secure/presentation/screens/widgets/credential_list.dart';
import 'package:archive_secure/presentation/screens/widgets/credentials_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CredentialPage extends StatefulWidget {
  const CredentialPage({super.key});

  @override
  State<CredentialPage> createState() => _CredentialPageState();
}

class _CredentialPageState extends State<CredentialPage> {
  final Map<String, String> _revealedPasswords = {};

  @override
  void initState() {
    super.initState();
    context.read<CredentialBloc>().add(const LoadCredentials());
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(context),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            children: [
              CredentialsSearchField(
                onSearch: (query) {
                  if (query.isEmpty) {
                    context.read<CredentialBloc>().add(const LoadCredentials());
                  } else {
                    context.read<CredentialBloc>().add(
                      SearchCredentialsEvent(query: query),
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              CredentialFilterTabs(
                onCategoryTap: () {
                  _revealedPasswords.clear();
                  context.read<CredentialBloc>().add(const LoadCredentials());
                },
                onFavoriteTap: () {
                  _revealedPasswords.clear();
                  context.read<CredentialBloc>().add(
                    const LoadCredentials(favorite: true),
                  );
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocConsumer<CredentialBloc, CredentialState>(
                  listener: (context, state) {
                    if (state is PasswordLoaded) {
                      setState(() {
                        _revealedPasswords[state.credentialId] = state.password;
                      });
                    }
                    if (state is CredentialFailure) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  builder: (context, state) {
                    if (state is CredentialLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is CredentialsLoaded) {
                      return CredentialList(
                        credentials: state.credentials,
                        revealedPasswords: _revealedPasswords,
                        onEdit: (cred) => _openForm(context, credential: cred),
                        onViewPassword: (cred) {
                          _requirePinBeforeView(context, cred);
                        },
                        onHidePassword: (id) {
                          setState(() => _revealedPasswords.remove(id));
                        },
                        onToggleFavorite: (id) {
                          context.read<CredentialBloc>().add(
                            ToggleFavoriteEvent(id: id),
                          );
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _requirePinBeforeView(
    BuildContext context,
    Credential cred,
  ) async {
    final loc = AppLocalizations.of(context)!;
    final verified = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => PinEntryPage(
          title: loc.credentialViewPassword,
          subtitle: loc.pinEntrySubtitle,
          purpose: PinEntryPurpose.revealCredentialPassword,
          credentialId: cred.id,
        ),
      ),
    );
    if (verified == true && context.mounted) {
      context.read<CredentialBloc>().add(ViewCredentialPassword(id: cred.id));
    }
  }

  void _openForm(BuildContext context, {credential}) async {
    final bloc = context.read<CredentialBloc>();
    final result = await Navigator.pushNamed(
      context,
      credentialFormPage,
      arguments: credential,
    );
    if (result == null) return;
    final data = result as Map<String, dynamic>;
    _revealedPasswords.clear();
    if (credential != null) {
      bloc.add(
        UpdateCredentialSubmitted(
          id: credential.id,
          serviceName: data['serviceName'],
          loginEmail: data['loginEmail'],
          username: data['username'],
          password: data['password'],
          categoryId: data['categoryId'],
          notes: data['notes'],
          tags: (data['tags'] as List<dynamic>?)?.cast<String>(),
        ),
      );
    } else {
      bloc.add(
        CreateCredentialSubmitted(
          serviceName: data['serviceName'],
          loginEmail: data['loginEmail'],
          username: data['username'],
          password: data['password'] ?? '',
          categoryId: data['categoryId'],
          notes: data['notes'],
          tags: (data['tags'] as List<dynamic>?)?.cast<String>(),
        ),
      );
    }
  }
}
