import 'package:edoc_tabcom/models/account_model.dart';
import 'package:edoc_tabcom/services/account_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final accountProvider = StateNotifierProvider<AccountNotifier, UserInfor>((ref) {
  return AccountNotifier(ref);
});

class AccountNotifier extends StateNotifier<UserInfor> {
  final Ref ref;
  late final AccountService _accountService = ref.read(accountServiceProvider);
  AccountNotifier(this.ref) : super(UserInfor());
  Future<void> getUserInfor() async {
    final response = await _accountService.getUserInfor();
    state = response;
  }
}
