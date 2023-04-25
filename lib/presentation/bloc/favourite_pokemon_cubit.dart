import 'package:new_pokemon_app/presentation/bloc/pokemon_state.dart';
import 'package:new_pokemon_app/data/model/pokemon.dart';
import 'package:new_pokemon_app/repository/favourite_pokemon_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritePokemonCubit extends Cubit<BlocState<List<Pokemon>>> {
  final FavouritePokemonRepository pokemonRepository;

  FavouritePokemonCubit({required this.pokemonRepository})
      : super(BlocState.initial(const []));

  void getFavouritePokemons() async {
    emit(state.copyWith(status: PageStatusType.loading));
    pokemonRepository.getAllPokemons().listen(
      (pokemonsFailure) {
        pokemonsFailure.fold(
          (failure) => emit(
            state.copyWith(
              status: PageStatusType.error,
              error: failure.message,
            ),
          ),
          (pokemons) {
            emit(
              state.copyWith(
                status: PageStatusType.ready,
                data: pokemons,
              ),
            );
          },
        );
      },
    );
  }

  void addPokemon(Pokemon pokemon) async {
    final failureOrSuccess = await pokemonRepository.savePokemon(pokemon);
    if (failureOrSuccess.isLeft()) {
      emit(
        state.copyWith(
          status: PageStatusType.error,
          error: failureOrSuccess.getLeft().message,
        ),
      );
    }
  }

  void removePokemon(int id) async {
    final failureOrSuccess = await pokemonRepository.deletePokemon(id);
    if (failureOrSuccess.isLeft()) {
      emit(
        state.copyWith(
          status: PageStatusType.error,
          error: failureOrSuccess.getLeft().message,
        ),
      );
    }
  }
}
