import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mexoraapp/presentaion/home/bloc/home_bloc.dart';
import 'package:mexoraapp/presentaion/home/bloc/home_event.dart';
import 'package:mexoraapp/presentaion/home/bloc/home_state.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  static List<Map<String, dynamic>> item = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is LoadFromSharePreferencesSuccessState) {
            item = state.item;
          }
        },
        builder: (context, state) {
          if (state is HomeInitialState) {
            context.read<HomeBloc>().add(LoadFromSharePreferencesEvent());
          }
          return item.isNotEmpty
              ? ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(item[index]['image']),
                      ),
                      title: Text(item[index]['name'] ?? 'Favorite Item'),
                      subtitle: Text('\$${item[index]['price'] ?? '0.00'}'),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'No Favorites Yet',
                    style: TextStyle(fontSize: 24, color: Colors.grey[700]),
                  ),
                );
        },
      ),
    );
  }
}
