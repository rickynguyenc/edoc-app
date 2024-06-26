import 'package:auto_route/auto_route.dart';
import 'package:edoc_tabcom/core/app_route/app_route.dart';
import 'package:edoc_tabcom/core/utils/env.dart';
import 'package:edoc_tabcom/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class SystemManagementListScreen extends HookConsumerWidget {
  const SystemManagementListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF5F5F5),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 48),
            Container(
              height: 56,
              alignment: Alignment.center,
              child: Text(
                'Quản trị hệ thống',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: Color(0xFFE6F4FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset('assets/icons/u_user.svg', width: 24, height: 24),
                        ),
                        SizedBox(width: 16),
                        Text(
                          'Thông tin tài khoản',
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 24,
                          height: 24,
                          child: IconButton(
                            onPressed: () {
                              // context.router.push(ProfileEditRoute());
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        )
                      ],
                    ),
                    SizedBox(height: 32),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: Color(0xFFE6F4FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset('assets/icons/u_user.svg', width: 24, height: 24),
                        ),
                        SizedBox(width: 16),
                        Text(
                          'Quản lý tài liệu',
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 24,
                          height: 24,
                          child: IconButton(
                            onPressed: () {
                              // context.router.push(ProfileEditRoute());
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        )
                      ],
                    ),
                    SizedBox(height: 32),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: Color(0xFFE6F4FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset('assets/icons/u_user.svg', width: 24, height: 24),
                        ),
                        SizedBox(width: 16),
                        Text(
                          'Quản lý nhóm',
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 24,
                          height: 24,
                          child: IconButton(
                            onPressed: () {
                              // context.router.push(BuyHistoryRoute(isShowBack: true));
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        )
                      ],
                    ),
                    SizedBox(height: 32),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: Color(0xFFE6F4FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset('assets/icons/u_user.svg', width: 24, height: 24),
                        ),
                        SizedBox(width: 16),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Trung tâm trợ giúp',
                            style: TextStyle(
                              color: Color(0xFF212121),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 24,
                          height: 24,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        )
                      ],
                    ),
                    SizedBox(height: 32),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: Color(0xFFE6F4FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset('assets/icons/u_user.svg', width: 24, height: 24),
                        ),
                        SizedBox(width: 16),
                        InkWell(
                          onTap: () {
                            ref.read(authProvider).logout();
                            context.router.replaceAll([LoginRoute()], updateExistingRoutes: true);
                          },
                          child: Text(
                            'Đăng xuất',
                            style: TextStyle(
                              color: Color(0xFF212121),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 24,
                          height: 24,
                          child: IconButton(
                            onPressed: () {
                              ref.read(authProvider).logout();
                              context.router.replaceAll([LoginRoute()], updateExistingRoutes: true);
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        )
                      ],
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
