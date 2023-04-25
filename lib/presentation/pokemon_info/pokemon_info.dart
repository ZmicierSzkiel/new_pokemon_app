import 'package:new_pokemon_app/config/constants.dart';
import 'package:new_pokemon_app/config/theme.dart';

import 'package:new_pokemon_app/core/utils/extensions/context.dart';
import 'package:new_pokemon_app/core/utils/extensions/string.dart';
import 'package:new_pokemon_app/core/utils/pokemon_types.dart';

import 'package:new_pokemon_app/core/widgets/image.dart';

import 'package:new_pokemon_app/data/model/pokemon.dart';

import 'package:new_pokemon_app/generator/assets.gen.dart';

import 'package:new_pokemon_app/presentation/bloc/pokemon_cubit.dart';
import 'package:new_pokemon_app/presentation/bloc/favourite_pokemon_cubit.dart';

import 'package:new_pokemon_app/presentation/pokemon_info/widgets/floating_button.dart';
import 'package:new_pokemon_app/presentation/pokemon_info/widgets/pokemon_info_header_delegate.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonInfo extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonInfo(this.pokemon, {Key? key}) : super(key: key);

  @override
  State<PokemonInfo> createState() => _PokemonInfoState();
}

class _PokemonInfoState extends State<PokemonInfo> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });
    context.read<PokemonCubit>().getPokemon(widget.pokemon.id);
  }

  bool get isAppBarExpanded {
    return scrollController.hasClients &&
        scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    final bool isMarkedAsFavourite = context
        .watch<FavouritePokemonCubit>()
        .state
        .data
        .any((item) => item.id == widget.pokemon.id);

    final pokemonCubit = context.watch<PokemonCubit>();
    final pokemon = pokemonCubit.state.data.firstWhere(
      (item) => item.id == widget.pokemon.id && item.hasAdditionalInfo,
      orElse: () => widget.pokemon,
    );

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            leading: GestureDetector(
              onTap: () => context.pop(),
              child: const Icon(
                CupertinoIcons.chevron_back,
                color: Colors.black,
              ),
            ),
            pinned: true,
            elevation: 0,
            expandedHeight: 220,
            backgroundColor: isAppBarExpanded
                ? getTypeColor(pokemon.baseType)
                : getTypeColor(pokemon.baseType).withOpacity(0.1),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding:
                  const EdgeInsets.only(left: Insets.md, bottom: Insets.md),
              title: AnimatedPadding(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                padding: EdgeInsets.only(
                  left: isAppBarExpanded ? 32 : 0,
                  bottom: 3,
                ),
                child: Text(
                  pokemon.pokeAppId,
                  style: TextStyle(
                    color: AppColours.textPrimaryColour,
                    fontSize: isAppBarExpanded ? 17 : 32,
                  ),
                ),
              ),
              background: FlexibleBackground(pokemon),
            ),
          ),
          SliverPersistentHeader(
            delegate: PokemonInfoHeaderDelegate(
              pokemon: pokemon,
            ),
            pinned: true,
          ),
        ],
      ),
      floatingActionButton: FloatingButton(
        pokemon,
        isPokemonMarkedAsFavourite: isMarkedAsFavourite,
      ),
    );
  }
}

class FlexibleBackground extends StatelessWidget {
  final Pokemon pokemon;
  const FlexibleBackground(this.pokemon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Positioned(
          bottom: -Insets.md,
          child: Image.asset(
            Assets.images.pokeapp.path,
            fit: BoxFit.contain,
            height: 200,
            color: getTypeColor(pokemon.baseType),
          ),
        ),
        Positioned(
          right: 24,
          child: Hero(
            tag: ValueKey(pokemon.id),
            child: HostedImage(
              pokemon.imageUrl,
              height: 170,
            ),
          ),
        ),
        Positioned(
          left: Insets.md,
          top: kToolbarHeight * 2,
          right: context.getWidth(0.5),
          bottom: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pokemon.name.capitalize(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColours.textPrimaryColour,
                  fontSize: 27,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                pokemon.types
                    .map((item) => item.type.name.capitalize())
                    .join(', '),
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 16),
              ),
            ],
          ),
        )
      ],
    );
  }
}
