import 'package:auto_route/auto_route.dart';
import 'package:edoc_tabcom/providers/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:edoc_tabcom/core/app_route/app_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class TabScreen extends HookConsumerWidget {
  const TabScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(accountProvider.notifier).getUserInfor();
      return null;
    }, []);
    return AutoTabsScaffold(
      routes: [HomeRoute(), MyDocumentRoute(), NotificationProductRoute(), SystemManagementListRoute(), MyAccountTabRoute()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xffEC1C23),
          unselectedItemColor: Color(0xff616161),
          selectedLabelStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Color(0xffEC1C23),
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Color(0xff616161),
          ),
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/fi_home.svg',
                  colorFilter: ColorFilter.mode(
                    tabsRouter.activeIndex == 0 ? Color(0xffEC1C23) : const Color(0xff616161),
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Trang chủ'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/u_file-info-alt.svg',
                  colorFilter: ColorFilter.mode(
                    tabsRouter.activeIndex == 1 ? Color(0xffEC1C23) : const Color(0xff616161),
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Tài liệu của tôi'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/notification.svg',
                  colorFilter: ColorFilter.mode(
                    tabsRouter.activeIndex == 2 ? Color(0xffEC1C23) : const Color(0xff616161),
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Thông báo'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/u_setting.svg',
                  colorFilter: ColorFilter.mode(
                    tabsRouter.activeIndex == 3 ? Color(0xffEC1C23) : const Color(0xff616161),
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Quản trị'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/u_user.svg',
                  colorFilter: ColorFilter.mode(
                    tabsRouter.activeIndex == 4 ? Color(0xffEC1C23) : const Color(0xff616161),
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Tài khoản'),
          ],
        );
      },
    );
  }
}
