import 'package:archive_secure/data/categories/bloc/category_bloc.dart';
import 'package:archive_secure/data/categories/bloc/category_event.dart';
import 'package:archive_secure/data/categories/bloc/category_state.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:archive_secure/navigation/route.dart';
import 'package:archive_secure/presentation/screens/widgets/categories_header.dart';
import 'package:archive_secure/presentation/screens/widgets/category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(LoadCategories());
  }

  Future<void> _onRefresh() async {
    final bloc = context.read<CategoryBloc>();
    bloc.add(LoadCategories());
    await bloc.stream.firstWhere(
      (state) => state is CategoriesLoaded || state is CategoryFailure,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            children: [
              CategoriesHeader(
                onAddTap: () => _openForm(context),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return const Center(
                          child: CircularProgressIndicator());
                    }
                    if (state is CategoryFailure) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(state.error,
                                style: TextStyle(color: cs.error)),
                            const SizedBox(height: 8),
                                TextButton(
                              onPressed: _onRefresh,
                              child: Text(loc.retry),
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is CategoriesLoaded) {
                      return RefreshIndicator(
                        onRefresh: _onRefresh,
                        child: CategoryList(
                          categories: state.categories,
                          onEdit: (cat) => _openForm(context, category: cat),
                        ),
                      );
                    }
                    return const Center(
                        child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openForm(BuildContext context, {category}) async {
    final bloc = context.read<CategoryBloc>();
    final result = await Navigator.pushNamed(
      context,
      categoryFormPage,
      arguments: category,
    );
    if (result == null) return;
    final data = result as Map<String, dynamic>;
    if (category != null) {
      bloc.add(UpdateCategorySubmitted(
        id: category.id,
        name: data['name'],
        color: data['color'],
        icon: data['icon'],
      ));
    } else {
      bloc.add(CreateCategorySubmitted(
        name: data['name'],
        color: data['color'],
        icon: data['icon'],
      ));
    }
  }
}
