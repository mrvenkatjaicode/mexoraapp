import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mexoraapp/presentaion/home/bloc/home_event.dart';
import 'package:mexoraapp/presentaion/home/bloc/home_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<OnSelectProductNameEvent>(selectproductnamefunction);
    on<AddToFavEvent>(addtofavfunction);
    on<StoreInSharePreferencesEvent>(storefav);
    on<LoadFromSharePreferencesEvent>(getfav);
  }

  selectproductnamefunction(
    OnSelectProductNameEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeLoadingState());
    emit(ProductNameSelectedState(productIndex: event.index));
  }

  addtofavfunction(AddToFavEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    emit(AddedToFavState(item: event.item));
  }

  storefav(StoreInSharePreferencesEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    final prefs = await SharedPreferences.getInstance();

    // Step 1: Load existing list from SharedPreferences
    String? jsonString = prefs.getString('fav');
    List<Map<String, dynamic>> favList = [];

    if (jsonString != null) {
      List<dynamic> decodedList = jsonDecode(jsonString);
      favList = decodedList.cast<Map<String, dynamic>>();
    }

    // Step 2: Add new item to the list
    favList.add(event.item); // Make sure event.item is Map<String, dynamic>

    // Step 3: Save updated list back to SharedPreferences
    String updatedJson = jsonEncode(favList);
    await prefs.setString('fav', updatedJson);

    emit(StoreInSharePreferencesSuccessState(item: favList));
  }

  getfav(LoadFromSharePreferencesEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('fav');

    if (jsonString != null) {
      List<dynamic> decodedList = jsonDecode(jsonString);
      List<Map<String, dynamic>> itemList = decodedList
          .cast<Map<String, dynamic>>();
      emit(LoadFromSharePreferencesSuccessState(item: itemList));
    } else {
      emit(LoadFromSharePreferencesSuccessState(item: []));
    }
  }
}
//  Future<void> saveItemToPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     String jsonString = jsonEncode(item);
//     await prefs.setString('selected_item', jsonString);
//   }

//   Future<Map<String, dynamic>?> loadItemFromPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? jsonString = prefs.getString('selected_item');
//     if (jsonString != null) {
//       return jsonDecode(jsonString);
//     }
//     return null;
//   }
