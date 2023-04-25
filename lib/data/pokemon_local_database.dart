import 'dart:async';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:new_pokemon_app/data/model/pokemon.dart';
import 'package:new_pokemon_app/core/errors/exception.dart';

abstract class IPokeAppLocalDataSource {
  Stream<List<Pokemon>> getAllPokemons();
  Future<void> savePokemon(Pokemon pokemon);
  Future<void> deletePokemon(int id);
}

class PokeAppLocalDataSource implements IPokeAppLocalDataSource {
  final Box<Pokemon> box;
  PokeAppLocalDataSource(this.box) : assert(box.isOpen);

  @override
  Stream<List<Pokemon>> getAllPokemons() async* {
    try {
      yield box.values.toList();
      await for (final _ in box.watch()) {
        yield box.values.toList();
      }
    } catch (e) {
      throw CacheGetException('$e');
    }
  }

  @override
  Future<void> savePokemon(Pokemon pokemon) async {
    try {
      unawaited(box.put(pokemon.id, pokemon));
    } catch (e) {
      throw CachePutException('$e');
    }
  }

  @override
  Future<void> deletePokemon(int id) async {
    try {
      unawaited(box.delete(id));
    } catch (e) {
      throw CachePutException('$e');
    }
  }
}
