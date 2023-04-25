import 'package:new_pokemon_app/config/constants.dart';
import 'package:new_pokemon_app/config/theme.dart';

import 'package:new_pokemon_app/core/widgets/gap.dart';
import 'package:new_pokemon_app/core/widgets/image.dart';

import 'package:new_pokemon_app/data/model/pokemon.dart';

import 'package:new_pokemon_app/generator/assets.gen.dart';

import 'package:new_pokemon_app/presentation/bloc/favourite_pokemon_cubit.dart';
import 'package:new_pokemon_app/presentation/bloc/pokemon_state.dart';
import 'package:new_pokemon_app/presentation/pokemon/all_pokemons_tab.dart';
import 'package:new_pokemon_app/presentation/pokemon/favourite_pokemons_tab.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({Key? key}) : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: LocalImage(
            Assets.images.appIcon.path,
            height: 32,
          ),
        ),
        body: Column(children: const [
          _TabBarHeader(),
          Expanded(
            child: TabBarView(children: [
              AllPokemonsTab(),
              FavouritePokemonsTab(),
            ]),
          )
        ]),
      ),
    );
  }
}

class _TabBarHeader extends StatelessWidget {
  const _TabBarHeader({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: ColoredBox(
        color: Colors.white,
        child: TabBar(
          unselectedLabelColor: const Color(0xff6B6B6B),
          labelColor: const Color(0xff161A33),
          indicatorColor: AppColours.primaryColour,
          labelPadding: const EdgeInsets.symmetric(vertical: Insets.xs),
          indicatorWeight: 3,
          tabs: [
            const Tab(
              child: Text(
                'All Pokemons',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            Tab(
              child:
                  BlocBuilder<FavouritePokemonCubit, BlocState<List<Pokemon>>>(
                builder: (context, state) {
                  final count = state.data.length;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Favourites',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      if (count != 0) ...[
                        const WidthGap(Insets.xs),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColours.primaryColour,
                          ),
                          padding: const EdgeInsets.all(Insets.xs),
                          child: Text(
                            '$count',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        )
                      ]
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
