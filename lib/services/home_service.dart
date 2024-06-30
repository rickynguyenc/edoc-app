import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/http.dart';

import '../core/app_dio.dart';
import '../models/home_model.dart';
part 'home_service.g.dart';

final homeServiceProvider = Provider<HomeService>((ref) {
  return HomeService(ref);
});

@RestApi()
abstract class HomeService {
  factory HomeService(Ref ref) => _HomeService(ref.read(dioProvider));
  @GET('/api/app/global-lookup-table/category-tree')
  Future<List<CategoryTreeResonpse>> getCategoryTree();
  @GET('/api/app/app-file/pulic-list')
  Future<PublicListResonpse> getPublicList(@Queries() Map<String, dynamic> data);

  ///PageLink
}
