

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spring/models/tool_model.dart';

class FavoriteToolsNotifier extends StateNotifier<List<Tool>>{
  FavoriteToolsNotifier(): super([]);

  bool toggleToolFavoriteStuts(Tool tool){
    final isExisting =state.contains(tool);
    if(isExisting){
      state=state.where((element) => element.id!= tool.id).toList();
      return false;
    }else{
      state=[...state,tool];
      return true;
    }
  }
}
final favoriteToolProviders=StateNotifierProvider<FavoriteToolsNotifier,List<Tool>>((ref) => FavoriteToolsNotifier());