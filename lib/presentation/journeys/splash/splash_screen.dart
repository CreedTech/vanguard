import 'package:flutter/material.dart';
import 'package:vanguard/presentation/themes/theme_color.dart';

import '../../../common/constants/route_constants.dart';
import '../../../common/constants/size_constants.dart';
import '../../../common/extensions/size_extensions.dart';
import '../../widgets/logo.dart';

// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Center(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(top: Sizes.dimen_32.h),
//               child: Logo(
//                 key: const ValueKey('logo_key'),
//                 height: Sizes.dimen_12.h,
//               ),
//             ),
//             Expanded(
//               child: LoginForm(
//                 key: const ValueKey('login_form_key'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 2000),
          () => Navigator.of(context).pushNamedAndRemoveUntil(
            RouteList.home,
            (route) => false,
      ),
    );
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Guide.isDark(context) ? colorsBlack : colorWhite,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(Sizes.dimen_32),
                  child: Image.asset(
                    'assets/icons/app_logo.png',
                    width: Sizes.dimen_300,
                    height: Sizes.dimen_300,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("An Application Made With"),
                          // .normalSized(12)
                          // .colors(Guide.isDark(context)
                          // ? darkThemeText
                          // : colorTextGray
                // ),
                      const Icon(
                        Icons.favorite,
                        color: AppColor.primaryColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

