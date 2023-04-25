import 'package:new_pokemon_app/config/constants.dart';

import 'package:new_pokemon_app/data/model/pokemon.dart';

import 'package:new_pokemon_app/presentation/bloc/favourite_pokemon_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FloatingButton extends StatelessWidget {
  final bool isPokemonMarkedAsFavourite;
  final Pokemon pokemon;
  const FloatingButton(this.pokemon,
      {this.isPokemonMarkedAsFavourite = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        if (isPokemonMarkedAsFavourite) {
          context.read<FavouritePokemonCubit>().removePokemon(pokemon.id);
        } else {
          context.read<FavouritePokemonCubit>().addPokemon(pokemon);
        }
      },
      backgroundColor: isPokemonMarkedAsFavourite
          ? const Color.fromARGB(0, 213, 222, 255)
          : AppColours.primaryColour,
      label: isPokemonMarkedAsFavourite
          ? const Text(
              'Remove from favourites',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColours.primaryColour,
              ),
            )
          : const Text(
              'Mark as favourite',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
    );
  }
}
