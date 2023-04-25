import 'package:new_pokemon_app/config/constants.dart';
import 'package:new_pokemon_app/config/theme.dart';

import 'package:new_pokemon_app/core/widgets/loading_indicator.dart';

import 'package:new_pokemon_app/data/model/pokemon.dart';

import 'package:new_pokemon_app/presentation/bloc/pokemon_cubit.dart';
import 'package:new_pokemon_app/presentation/bloc/pokemon_state.dart';
import 'package:new_pokemon_app/presentation/pokemon/widgets/pokemon_grid_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllPokemonsTab extends StatefulWidget {
  const AllPokemonsTab({Key? key}) : super(key: key);

  @override
  State<AllPokemonsTab> createState() => _AllPokemonsTabState();
}

class _AllPokemonsTabState extends State<AllPokemonsTab> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() => paginate());
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void paginate() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent + 100) {
      context.read<PokemonCubit>().getMorePokemons();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonCubit, BlocState<List<Pokemon>>>(
        builder: (context, state) {
      final pokemons = state.data;
      if (pokemons.isNotEmpty) {
        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: MaxGridExtent,
                    mainAxisSpacing: Insets.sm,
                    crossAxisSpacing: Insets.sm),
                itemBuilder: (context, index) => PokemonGridItem(
                  pokemons[index],
                ),
                key: const PageStorageKey('all_pokemons_tab'),
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(Insets.sm),
                itemCount: pokemons.length,
              ),
            ),
            if (state.isLoadingMore)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: LoadingIndicator(),
              ),
          ],
        );
      }
      if (state.isError) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.getError(),
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: () => context.read<PokemonCubit>().getPokemons(),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        AppColours.primaryColour)),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }
      return const LoadingIndicator();
    });
  }
}
