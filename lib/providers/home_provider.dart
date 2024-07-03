import 'package:edoc_tabcom/core/utils/extension/object.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/home_model.dart';
import '../services/home_service.dart';

final homeProvider = StateNotifierProvider<HomeProvider, List<DocumentItem>>((ref) {
  return HomeProvider(ref);
});

class HomeProvider extends StateNotifier<List<DocumentItem>> {
  final Ref ref;
  HomeProvider(this.ref) : super([]);
  late final _homeService = ref.read(homeServiceProvider);
  Future<List<DocumentItem>> getPublicList() async {
    try {
      final param = PageLink();
      final result = await _homeService.getPublicList(param.toJson());
      state = result.items ?? [];
      return state;
    } catch (e) {
      return [];
    }
  }
}

final categoryTreeProvider = StateNotifierProvider<CategoryTreeNotifier, List<CategoryTreeResonpse>>((ref) {
  return CategoryTreeNotifier(ref);
});

class CategoryTreeNotifier extends StateNotifier<List<CategoryTreeResonpse>> {
  final Ref ref;
  CategoryTreeNotifier(this.ref) : super([]);
  late final _homeService = ref.read(homeServiceProvider);
  Future<List<CategoryTreeResonpse>> getCategoryTree() async {
    try {
      final result = await _homeService.getCategoryTree();
      state = result;
      return state;
    } catch (e) {
      return [];
    }
  }
}
