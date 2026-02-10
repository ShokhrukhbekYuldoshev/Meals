import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals/features/meals/presentation/bloc/meals_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MealDetailsPage extends StatefulWidget {
  final String id;

  const MealDetailsPage({super.key, required this.id});

  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends State<MealDetailsPage> {
  bool get isDesktop => MediaQuery.of(context).size.width >= 1000;

  @override
  void initState() {
    super.initState();
    context.read<MealsBloc>().add(GetMealById(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (context, state) {
        if (state is MealLoaded) {
          final meal = state.meal;

          return Scaffold(
            body: CustomScrollView(
              slivers: [
                _buildSliverHeader(meal),
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: isDesktop
                            ? _buildDesktopContent(meal)
                            : _buildMobileContent(meal),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is MealsError) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text(state.message)),
          );
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  // ================= HEADER =================

  SliverAppBar _buildSliverHeader(dynamic meal) {
    return SliverAppBar(
      expandedHeight: 360,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(meal.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        background: Hero(
          tag: meal.id,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(meal.thumbnail ?? '', fit: BoxFit.cover),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black54],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= CONTENT =================

  Widget _buildMobileContent(dynamic meal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuickInfo(meal),
        const SizedBox(height: 32),
        _buildIngredients(meal),
        const SizedBox(height: 32),
        _buildInstructions(meal),
        _buildYoutubeButton(meal),
      ],
    );
  }

  Widget _buildDesktopContent(dynamic meal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuickInfo(meal),
        const SizedBox(height: 32),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildIngredients(meal)),
            const SizedBox(width: 32),
            Expanded(child: _buildInstructions(meal)),
          ],
        ),
        _buildYoutubeButton(meal),
      ],
    );
  }

  // ================= QUICK INFO =================

  Widget _buildQuickInfo(dynamic meal) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.35,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _infoItem(Icons.restaurant, meal.category ?? "Meal"),
          _infoItem(Icons.public, meal.area ?? "World"),
          _infoItem(Icons.list_alt, "${meal.ingredients.length} ingredients"),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  // ================= INGREDIENTS =================

  Widget _buildIngredients(dynamic meal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Ingredients"),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: meal.ingredients.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 4,
          ),
          itemBuilder: (context, index) {
            final ingredient = meal.ingredients[index];
            final measure = index < meal.measures.length
                ? meal.measures[index]
                : "";

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(ingredient, overflow: TextOverflow.ellipsis),
                  ),
                  Text(
                    measure,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // ================= INSTRUCTIONS =================

  Widget _buildInstructions(dynamic meal) {
    final steps = meal.instructions!
        .split('.')
        .where((String s) => s.trim().length > 5)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Instructions"),
        const SizedBox(height: 12),
        ...steps.asMap().entries.map((entry) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      "${entry.key + 1}",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      entry.value.trim(),
                      style: const TextStyle(height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  // ================= YOUTUBE =================

  Widget _buildYoutubeButton(dynamic meal) {
    if (meal.youtube == null || meal.youtube!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: OutlinedButton.icon(
          onPressed: () => launchUrlString(meal.youtube!),
          icon: const Icon(Icons.play_arrow),
          label: const Text("Watch Video Recipe"),
        ),
      ),
    );
  }

  // ================= SHARED =================

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
