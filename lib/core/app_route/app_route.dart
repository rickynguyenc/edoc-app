import 'package:auto_route/auto_route.dart';
import 'package:edoc_tabcom/screens/home/home_screen.dart';
import 'package:edoc_tabcom/screens/my_document/my_document_screen.dart';
import 'package:edoc_tabcom/screens/system_management/system_management_list_screen.dart';
import 'package:edoc_tabcom/providers/authentication_provider.dart';
import 'package:edoc_tabcom/screens/authentication/change_password_screen.dart';
import 'package:edoc_tabcom/screens/tab_screen.dart';
import '../../screens/account/personal_view_screen.dart';
import '../../screens/authentication/forget_password_screen.dart';
import '../../screens/authentication/login_screen.dart';
import '../../screens/authentication/otp_confirm_screen.dart';
import '../../screens/authentication/register_screen.dart';
import '../../screens/authentication/reset_password_screen.dart';
import '../../screens/authentication/welcome_screen.dart';
import '../../screens/notification/notification_dashboard_screen.dart';
import '../../screens/account/my_account_tab.dart';
import 'app_route_guard.dart';
part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final AuthProvider _tokenNotifier;
  AppRouter(this._tokenNotifier);
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            page: TabRoute.page,
            guards: [RouteGuard(_tokenNotifier)],
            path: '/',
            children: [
              AutoRoute(page: HomeRoute.page, path: 'home'),
              AutoRoute(page: MyDocumentRoute.page, path: 'my-document'),
              AutoRoute(page: NotificationProductRoute.page, path: 'notification-dashboard'),
              AutoRoute(page: MyAccountTabRoute.page, path: 'account'),
              AutoRoute(page: SystemManagementListRoute.page, path: 'system-management'),
            ]),
        AutoRoute(page: WelcomeRoute.page, path: '/welcome'),
        AutoRoute(page: RegisterRoute.page, path: '/register'),
        AutoRoute(page: OTPConfirmRoute.page, path: '/otp-confirm'),
        AutoRoute(page: ResetPasswordRoute.page, path: '/reset-password'),
        AutoRoute(page: ForgotPasswordRoute.page, path: '/forgot-password'),
        AutoRoute(page: LoginRoute.page, path: '/login'),

        /// routes go here
        RedirectRoute(path: '*', redirectTo: '/'),
      ];
}
