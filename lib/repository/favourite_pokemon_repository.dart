import 'package:new_pokemon_app/core/errors/failure.dart';
import 'package:new_pokemon_app/core/utils/both.dart';
import 'package:new_pokemon_app/data/model/pokemon.dart';
import 'package:new_pokemon_app/data/pokemon_local_database.dart';

class FavouritePokemonRepository {
  final IPokeAppLocalDataSource pokeAppLocalDataSource;
  FavouritePokemonRepository(this.pokeAppLocalDataSource);

  Stream<Both<Failure, List<Pokemon>>> getAllPokemons() async* {
    yield* runSGuard(() => pokeAppLocalDataSource.getAllPokemons());
  }

  Future<Both<Failure, void>> savePokemon(Pokemon pokemon) =>
      runGuard(() async {
        await pokeAppLocalDataSource.savePokemon(pokemon);
        return;
      });

  Future<Both<Failure, void>> deletePokemon(int id) => runGuard(() async {
        await pokeAppLocalDataSource.deletePokemon(id);
        return;
      });
}
