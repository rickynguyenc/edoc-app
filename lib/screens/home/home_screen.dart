import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:edoc_tabcom/core/utils/env.dart';
import 'package:edoc_tabcom/core/utils/widgets/appbar_template_widget.dart';
import 'package:edoc_tabcom/core/utils/widgets/loading_mark.dart';
import 'package:edoc_tabcom/core/utils/widgets/search_widget.dart';
import 'package:edoc_tabcom/core/utils/widgets/shimmer_loading/common_simmer.dart';
import 'package:edoc_tabcom/models/home_model.dart';
import 'package:edoc_tabcom/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  Widget _customPopupItemBuilder(BuildContext context, CategoryTreeResonpse item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.label ?? ''),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final publicList = ref.watch(homeProvider);
    final categoryTree = ref.watch(categoryTreeProvider);
    final categorySelected = useState<CategoryTreeResonpse?>(null);
    final _userEditTextController = useTextEditingController();
    final filterTab = useState(0);
    final isLoading = useState(true);
    final _scrollCtrl = useScrollController();
    useEffect(() {
      Future.wait([ref.read(homeProvider.notifier).getPublicList(), ref.read(categoryTreeProvider.notifier).getCategoryTree()]).then((value) {
        isLoading.value = false;
      });
      return null;
    }, []);
    return LayoutEdoc(
      bodyWidget: Column(
        children: [
          Container(
            height: 46,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 16, bottom: 16),
            padding: EdgeInsets.only(left: 16, right: 16),
            child: DropdownSearch<CategoryTreeResonpse>(
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  prefixIcon: Container(
                    padding: EdgeInsets.only(left: 40, right: 8),
                    child: SvgPicture.asset(
                      'assets/icons/sorting_icon.svg',
                      height: 20,
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 20, minHeight: 20),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'Lọc theo danh mục',
                  filled: true,
                  fillColor: const Color(0xFFEC1C23),
                  hintStyle: const TextStyle(
                    color: Colors.white,
                    backgroundColor: Color(0xFFEC1C23),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  // border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(45),
                  ),
                ),
              ),
              filterFn: (item, filter) {
                return item.label!.toLowerCase().contains(filter.toLowerCase());
              },
              selectedItem: categorySelected.value,
              onChanged: (value) {
                categorySelected.value = value;
              },
              dropdownBuilder: categorySelected.value != null
                  ? (context, item) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item!.label ?? '',
                          style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5, fontWeight: FontWeight.w500),
                        ),
                      );
                    }
                  : null,
              clearButtonProps: ClearButtonProps(
                icon: const Icon(
                  Icons.clear,
                ),
                color: Colors.white,
                iconSize: 24,
                isVisible: categorySelected.value != null,
                onPressed: () {
                  categorySelected.value = null;
                },
              ),
              dropdownButtonProps: const DropdownButtonProps(
                isVisible: false,
                icon: Icon(Icons.keyboard_arrow_down_outlined),
                iconSize: 24,
                color: Colors.white,
              ),
              items: categoryTree,
              compareFn: (i, s) => (i.label ?? '') == (s.label ?? ''),
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                showSearchBox: true,
                searchDelay: const Duration(milliseconds: 100),
                loadingBuilder: (context, item) => const Loading(),
                itemBuilder: _customPopupItemBuilder,
                emptyBuilder: (context, searchEntry) {
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: const Text(
                      'Không có dữ liệu',
                      style: TextStyle(color: Color(0xff797882), fontSize: 16, height: 1.5, fontWeight: FontWeight.w400),
                    ),
                  );
                },
                searchFieldProps: TextFieldProps(
                  controller: _userEditTextController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 12, top: 0, bottom: 0, right: 12),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xffE4E4E6)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xffE4E4E6)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xffE4E4E6)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Color(0xff797882),
                      ),
                      onPressed: () {
                        _userEditTextController.clear();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: SearchBarWidget(
              textSearch: '',
              hintText: 'Tìm kiếm tài liệu',
              onChanged: (value) {
                // filterLstProduct.value = lstProduct.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
              },
              onSubmit: (value) {},
            ),
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              SizedBox(width: 16),
              InkWell(
                onTap: () {
                  filterTab.value = 0;
                },
                child: Material(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: ShapeDecoration(
                      color: filterTab.value == 0 ? Color(0xFFFEE2E2) : Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: filterTab.value == 0 ? Color(0xFFF6979A) : Color(0xFF42526D)),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Text(
                      'Tài liệu mới nhất',
                      style: TextStyle(
                        color: filterTab.value == 0 ? Color(0xFFEF4444) : Color(0xFF42526D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.07,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              InkWell(
                onTap: () {
                  filterTab.value = 1;
                },
                child: Material(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: ShapeDecoration(
                      color: filterTab.value == 1 ? Color(0xFFFEE2E2) : Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: filterTab.value == 1 ? Color(0xFFF6979A) : Color(0xFF42526D)),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Text(
                      'Lượt xem nhiều nhất',
                      style: TextStyle(
                        color: filterTab.value == 1 ? Color(0xFFEF4444) : Color(0xFF42526D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.07,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              InkWell(
                onTap: () {
                  filterTab.value = 2;
                },
                child: Material(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: ShapeDecoration(
                      color: filterTab.value == 2 ? Color(0xFFFEE2E2) : Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: filterTab.value == 2 ? Color(0xFFF6979A) : Color(0xFF42526D)),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Text(
                      'Nhiều lượt thích nhất',
                      style: TextStyle(
                        color: filterTab.value == 2 ? Color(0xFFEF4444) : Color(0xFF42526D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.07,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
            ]),
          ),
          Expanded(
            child: isLoading.value
                ? CommonSimmer()
                : publicList.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Image(
                              image: AssetImage('assets/images/no_data.png'),
                              width: 200,
                              height: 200,
                            ),
                          ),
                          Text(
                            'Không tìm thấy kết quả nào',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF212121),
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Chúng tôi không thể tìm thấy những gì bạn tìm kiếm hãy thử tìm lại với từ khóa khác',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF646568),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    : Scrollbar(
                        controller: _scrollCtrl,
                        child: SingleChildScrollView(
                          controller: _scrollCtrl,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  top: 12,
                                ),
                                color: Color(0xffF7F7F7),
                                child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // This creates 2 elements in a row
                                    childAspectRatio: 0.6,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                  ),
                                  itemCount: publicList.length, // Replace with your list of games
                                  itemBuilder: (BuildContext context, int index) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          // height: 48,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(5.89),
                                            // color: Colors.blueGrey,
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              AspectRatio(
                                                aspectRatio: 1,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Image.network(
                                                    '${Environment.apiUrl}/${publicList[index].avatarUrl ?? ''}',
                                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                      return Image(
                                                        image: AssetImage('assets/images/banner_home.png'),
                                                      );
                                                    },
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.all(12),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        publicList[index].fileName ?? '',
                                                        maxLines: 3,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10.09,
                                                          fontWeight: FontWeight.w400,
                                                          letterSpacing: -0.25,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 48.41,
                                                            padding: const EdgeInsets.symmetric(horizontal: 4.20),
                                                            decoration: BoxDecoration(color: Color(0xFFFCAC12)),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  'Giảm 30%',
                                                                  style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 8.41,
                                                                    fontWeight: FontWeight.w500,
                                                                    letterSpacing: -0.21,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 6,
                                                          ),
                                                          Container(
                                                            height: 12.61,
                                                            padding: const EdgeInsets.symmetric(horizontal: 4.20),
                                                            decoration: ShapeDecoration(
                                                              shape: RoundedRectangleBorder(
                                                                side: BorderSide(width: 0.84, color: Color(0xFFFD3C4A)),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'Mua kèm Deal sốc',
                                                              style: TextStyle(
                                                                color: Color(0xFFFD3C4A),
                                                                fontSize: 8.41,
                                                                fontWeight: FontWeight.w500,
                                                                letterSpacing: -0.21,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: '450.000',
                                                              style: TextStyle(
                                                                color: Color(0xFF90909F),
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w400,
                                                                decoration: TextDecoration.lineThrough,
                                                                letterSpacing: -0.35,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: 'đ  ',
                                                              style: TextStyle(
                                                                color: Color(0xFF90909F),
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w400,
                                                                letterSpacing: -0.35,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: '200.000đ',
                                                              style: TextStyle(
                                                                color: Color(0xFF055FA7),
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w500,
                                                                letterSpacing: -0.35,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 24)
                              // Lst  product
                              // ...lstProduct.map((e) => ProductElement()).toList(),
                            ],
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
