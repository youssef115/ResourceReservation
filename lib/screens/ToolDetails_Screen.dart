import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spring/models/tool_model.dart';
import 'package:flutter_spring/providers/favorites_provider.dart';

class ToolDetailScreen extends ConsumerWidget {
  const ToolDetailScreen({super.key, required this.tool});

  final Tool tool;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteTool = ref.watch(favoriteToolProviders);
    bool isExist = favoriteTool.contains(tool);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteToolProviders.notifier)
                  .toggleToolFavoriteStuts(tool);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(wasAdded
                      ? "added to favorites "
                      : "removed from favorites")));
            },
            icon: Icon(
              Icons.star,
              color: isExist ? Colors.yellow : Colors.grey,
            ),
          ),
        ],
        title: Text(
          "${tool.title}",
          style: TextStyle(color: Theme.of(context).colorScheme.background),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Image.network(
                tool.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'description',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                tool.smallDescription,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              ElevatedButton(
                onPressed: () {},
                
                child: const Text("Reserve it now",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.primary),
              )
            ],
          ),
        ),
      ),
    );
  }
}
