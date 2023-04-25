import 'package:new_pokemon_app/config/constants.dart';
import 'package:new_pokemon_app/config/theme.dart';

import 'package:new_pokemon_app/repository/favourite_pokemon_repository.dart';
import 'package:new_pokemon_app/repository/pokemon_repository.dart';

import 'package:new_pokemon_app/presentation/bloc/favourite_pokemon_cubit.dart';
import 'package:new_pokemon_app/presentation/bloc/pokemon_cubit.dart';
import 'package:new_pokemon_app/presentation/app_scaffold.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokeApp extends StatelessWidget {
  final PokemonRepository pokemonRepository;
  final FavouritePokemonRepository favouritePokemonRepository;

  const PokeApp({
    required this.pokemonRepository,
    required this.favouritePokemonRepository,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PokemonCubit(
            pokemonRepository: pokemonRepository,
          )..getPokemons(),
        ),
        BlocProvider(
          create: (context) => FavouritePokemonCubit(
            pokemonRepository: favouritePokemonRepository,
          )..getFavouritePokemons(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppName,
        theme: lightThemeData,
        home: const AppScaffoldPage(),
      ),
    );
  }
}
