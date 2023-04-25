import 'package:new_pokemon_app/config/constants.dart';
import 'package:new_pokemon_app/config/theme.dart';

import 'package:new_pokemon_app/data/model/pokemon.dart';
import 'package:new_pokemon_app/presentation/bloc/favourite_pokemon_cubit.dart';

import 'package:new_pokemon_app/presentation/bloc/pokemon_state.dart';
import 'package:new_pokemon_app/presentation/pokemon/widgets/pokemon_grid_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritePokemonsTab extends StatefulWidget {
  const FavouritePokemonsTab({Key? key}) : super(key: key);

  @override
  State<FavouritePokemonsTab> createState() => _FavouritePokemonsTabState();
}

class _FavouritePokemonsTabState extends State<FavouritePokemonsTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouritePokemonCubit, BlocState<List<Pokemon>>>(
      builder: (context, state) {
        final pokemons = state.data;
        if (pokemons.isNotEmpty) {
          return GridView.builder(
            key: const PageStorageKey('favourite_pokemons_tab'),
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(Insets.sm),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: MaxGridExtent,
                mainAxisSpacing: Insets.sm,
                crossAxisSpacing: Insets.sm),
            itemCount: pokemons.length,
            itemBuilder: (context, index) => PokemonGridItem(
              pokemons[index],
            ),
          );
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                'Your favourite pokemons would store here.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
