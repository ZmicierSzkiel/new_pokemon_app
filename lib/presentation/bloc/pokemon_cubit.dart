import 'package:new_pokemon_app/data/model/pokemon.dart';
import 'package:new_pokemon_app/presentation/bloc/pokemon_state.dart';
import 'package:new_pokemon_app/repository/pokemon_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonCubit extends Cubit<BlocState<List<Pokemon>>> {
  final PokemonRepository pokemonRepository;
  PokemonCubit({required this.pokemonRepository})
      : super(BlocState.initial(const []));

  int _offset = 0;

  void getPokemons(
      {PageStatusType bootstrapStatus = PageStatusType.loading}) async {
    emit(state.copyWith(status: bootstrapStatus));
    final pokemonsFailure = await pokemonRepository.getAllPokemons(_offset);
    pokemonsFailure.fold(
      (failure) => emit(
        state.copyWith(
          error: failure.message,
          status: PageStatusType.error,
        ),
      ),
      (pokemons) {
        emit(
          state.copyWith(
            data: state.data.followedBy(pokemons).toList(),
            status: PageStatusType.ready,
          ),
        );
      },
    );
  }

  void getMorePokemons() async {
    if (!state.isLoading) {
      _offset += 20;
      getPokemons(bootstrapStatus: PageStatusType.loadingMore);
    }
  }

  void getPokemon(int id) async {
    emit(
      state.copyWith(status: PageStatusType.loading),
    );
    final pokemonsFailure = await pokemonRepository.getPokemon(id);
    pokemonsFailure.fold(
      (failure) => emit(
        state.copyWith(
          error: failure.message,
          status: PageStatusType.error,
        ),
      ),
      (pokemon) {
        emit(
          state.copyWith(
            status: PageStatusType.ready,
            data: state.data
                .map((item) => item.id == pokemon.id ? pokemon : item)
                .toList(),
          ),
        );
      },
    );
  }
}
