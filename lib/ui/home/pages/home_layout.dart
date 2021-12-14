import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infogames/ui/home/bloc/home_bloc.dart';
import 'package:infogames/ui/home/widgets/category/category_list.dart';
import 'package:infogames/ui/home/widgets/games_by_category/bloc/games_by_category_bloc.dart';
import 'package:infogames/ui/widgets/container_body.dart';
import 'package:infogames/ui/home/widgets/header_title/header_title.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderTitle(),
              SizedBox(height: 40.0),
              ContainerBody(
                children: [
                  CategoryList(
                    callback: (int categoryId) {
                      context.read<GamesByCategoryBloc>().add(
                            GetGamesByCategory(
                              idSelected: categoryId,
                              games: state.games.results ?? [],
                            ),
                          );
                    },
                  ),
                  BlocBuilder<GamesByCategoryBloc, GamesByCategoryState>(
                    builder: (context, state) {
                      print('games lenght ------> ${state.games.length}');
                      return Flexible(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.orange,
                              child: Column(
                                children: [
                                  Image.network(
                                      state.games[index].backgroundImage ??
                                          'No data'),
                                  Text(state.games[index].name ?? ''),
                                  Text(state.games[index].platforms?[1].platform
                                          ?.name ??
                                      ''),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(height: 16.0),
                          itemCount: state.games.length,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}