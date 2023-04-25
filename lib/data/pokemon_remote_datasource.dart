import 'package:new_pokemon_app/core/managers/http_manager.dart';
import 'package:new_pokemon_app/core/utils/extensions/string.dart';
import 'package:new_pokemon_app/data/model/pokemon.dart';

abstract class IPokeAppRemoteDataSource {
  Future<List<Pokemon>> getAllPokemons(int offset);
  Future<Pokemon> getPokemon(int id);
}

const String baseUrl = 'https://pokeapi.co/api/v2/pokemon';
const int pageLimit = 20;

class PokeAppRemoteDataSource implements IPokeAppRemoteDataSource {
  final HttpManager http;
  PokeAppRemoteDataSource(this.http);

  @override
  Future<List<Pokemon>> getAllPokemons(int offset) async {
    final endpoint = '$baseUrl?offset=$offset&limit=$pageLimit';
    final data = await http.get(endpoint);
    final pokemonList = (data['results'] as List).map(
      (item) {
        List<String> urlPaths = (item['url'] as String).split('/');
        final pokemonId = urlPaths[urlPaths.length - 2];
        return Pokemon.fromMap(item).copyWith(
          id: pokemonId.toInt(),
        );
      },
    ).toList();
    return pokemonList;
  }

  @override
  Future<Pokemon> getPokemon(int id) async {
    final data = await http.get('$baseUrl/$id');
    return Pokemon.fromMap(data);
  }
}
