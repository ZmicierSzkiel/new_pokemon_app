import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:new_pokemon_app/config/constants.dart';

import 'package:new_pokemon_app/core/app.dart';
import 'package:new_pokemon_app/core/managers/http_manager.dart';

import 'package:new_pokemon_app/data/model/pokemon.dart';
import 'package:new_pokemon_app/data/pokemon_local_database.dart';
import 'package:new_pokemon_app/data/pokemon_remote_datasource.dart';

import 'package:new_pokemon_app/repository/favourite_pokemon_repository.dart';
import 'package:new_pokemon_app/repository/pokemon_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PokemonAdapter());
  Hive.registerAdapter(PokemonNameAndUrlDateAdapter());
  Hive.registerAdapter(PokemonTypeAdapter());

  final favouriteDb = await Hive.openBox<Pokemon>(LocalDbKeys.favouriteDb);
  final dio = Dio();
  final http = HttpManager(dio: dio);

  final pokemonRepository = PokemonRepository(
    PokeAppRemoteDataSource(http),
  );

  final favouritePokemonRepository = FavouritePokemonRepository(
    PokeAppLocalDataSource(favouriteDb),
  );

  runApp(
    PokeApp(
      pokemonRepository: pokemonRepository,
      favouritePokemonRepository: favouritePokemonRepository,
    ),
  );
}
