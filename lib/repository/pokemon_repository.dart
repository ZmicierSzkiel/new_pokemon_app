import 'package:new_pokemon_app/core/errors/failure.dart';
import 'package:new_pokemon_app/core/utils/both.dart';
import 'package:new_pokemon_app/data/model/pokemon.dart';
import 'package:new_pokemon_app/data/pokemon_remote_datasource.dart';

class PokemonRepository {
  final IPokeAppRemoteDataSource pokemonRemoteDataSource;
  PokemonRepository(this.pokemonRemoteDataSource);

  Future<Both<Failure, List<Pokemon>>> getAllPokemons(int offset) =>
      runGuard(() async {
        final pokemonList =
            await pokemonRemoteDataSource.getAllPokemons(offset);
        return pokemonList;
      });

  Future<Both<Failure, Pokemon>> getPokemon(int id) => runGuard(() async {
        final pokemon = await pokemonRemoteDataSource.getPokemon(id);
        return pokemon;
      });
}
