import 'package:auto_route/auto_route.dart';
import 'package:edoc_tabcom/core/app_route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LayoutEdoc extends HookConsumerWidget {
  final Widget bodyWidget;
  const LayoutEdoc({required this.bodyWidget, super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 68,
        backgroundColor: Colors.white,
        title: Container(
          height: 32,
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 16),
          child: SvgPicture.asset(
            'assets/icons/logo.svg',
          ),
        ),
        // automaticallyImplyLeading: false,
        leading: Container(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              context.router.push(PersonalViewRoute());
            },
            child: Material(
              child: Container(
                width: 32,
                height: 32,
                child: CircleAvatar(
                  // radius: 16,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                ),
              ),
            ),
          ),
        ),

        actions: [
          Container(
            alignment: Alignment.center,
            // width: 32,
            child: ElevatedButton(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 16,
              ),
              onPressed: () {
                // context.router.push(AddViewRoute());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffEC1C23),
                fixedSize: const Size(32, 32),
                minimumSize: const Size(32, 32),
                padding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
      body: bodyWidget,
    );
  }
}
