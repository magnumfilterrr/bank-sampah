// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loginandsignup/presention/pages/bank_sampah/add_item_model.dart';
import 'package:loginandsignup/presention/pages/bank_sampah/cubit/bank_sampah_cubit.dart';
import 'package:loginandsignup/presention/pages/detail_riwayat/cubit/detal_history_cubit.dart';

import 'package:loginandsignup/presention/pages/home/cubit/home_cubit.dart';
import 'package:loginandsignup/presention/pages/layanan/cubit/layanan_cubit.dart';

import 'package:loginandsignup/presention/pages/login/login_screen.dart';
import 'package:loginandsignup/presention/pages/navigasibar.dart';
// import 'package:loginandsignup/pages/pages.dart';
import 'package:loginandsignup/presention/pages/pages.dart';
import 'package:loginandsignup/presention/pages/penjemputan/new_inquiry_model.dart';
import 'package:loginandsignup/presention/pages/riwayat/cubit/history_cubit.dart';
import '../pages/autentikasi/autentikasi.dart';
import '../pages/profile/userModel.dart';
import 'route.dart';
// import 'package:loginandsignup/presention/pages/pembayaran/cubit/pilih_pembayaran_cubit.dart';

GoRouter appRouter(String path) {
  return GoRouter(initialLocation: "/$path", routes: [
    GoRoute(
      path: "/Splash_Screen",
      name: "splash",
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: "/login",
      name: "login",
      builder: (context, state) => const LoginScreen(),
      // redirect: (context, state) async {
      //   final isAuth = context.read<AuthCubit>().checkToken();
      //   if (await isAuth) {
      //     return '/HomeScreen';
      //   } else {
      //     return '/';
      //   }
      // },
    ),
    // GoRoute(
    //   path: "/NavigasiBar",
    //   name: 'navbar',
    //   builder: (context, state) => const NavigasiBar(),
    // ),

    GoRoute(
      path: "/AutentikasiScreen",
      name: "auten",
      builder: (context, state) => const AutentikasiScreen(),
    ),
    GoRoute(
      path: "/SuccesScreen",
      name: "succes",
      builder: (context, state) => const SuccesScreen(),
    ),

    GoRoute(
      path: "/RegisterScreen",
      name: "resgis",
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
        path: "/NavigasiBar",
        name: Routes.NavigasiBar,
        builder: (context, state) {
          BlocProvider.of<HomeCubit>(context).fecthHome();
          BlocProvider.of<HistoryCubit>(context).fecthHistory();
          return const NavigasiBar(
            indexScreen: 0,
          );
        },
        routes: [
          GoRoute(
              path: "HomeScreen",
              name: Routes.HomeScreen,
              builder: (context, state) {
                return const NavigasiBar(
                  indexScreen: 0,
                );
              },
              routes: [
                GoRoute(
                    path: "LayananScreen",
                    name: Routes.LayananScreen,
                    builder: (context, state) {
                      BlocProvider.of<LayananCubit>(context).fecthLayanan();
                      return const LayananScreen();
                    }),
                GoRoute(
                  path: "BankSampahScreen",
                  name: Routes.BankSampahScreen,
                  builder: (context, state) {
                    BlocProvider.of<BankSampahCubit>(context).fecthBankSampah();

                    return const BankSampahScreen();
                  },
                ),
              ]),
          GoRoute(
            path: "Profile",
            name: Routes.Profile,
            builder: (context, state) {
              return const NavigasiBar(
                indexScreen: 1,
              );
            },
            routes: [
              GoRoute(
                path: "ChangeProfile",
                name: Routes.ChangeProfile,
                builder: (context, state) {
                  final _userModel = state.extra as UserModel;
                  return ChangeProfile(profileData: _userModel);
                },
              ),
            ],
          ),
        ]),
    GoRoute(
      path: "/LupaPassword",
      name: "lupa",
      builder: (context, state) => const LupaPassword(),
    ),
    GoRoute(
      path: "/ConfigPass",
      name: "configpass",
      builder: (context, state) => const ConfigPass(),
    ),
    GoRoute(
      path: "/SuccesPass",
      name: "succespass",
      builder: (context, state) => const SuccesPass(),
    ),
    // GoRoute(
    //   path: "/LayananScreen",
    //   name: "layananscreen",
    //   builder: (context, state) => const SuccesPass(),
    // ),

    GoRoute(
      path: "/TukarPoint1",
      name: "point1",
      builder: (context, state) {
        // BlocProvider.of<TukarpointCubit>(context).fecthTukarPoint();
        return const TukarPoint1();
      },
    ),
    GoRoute(
        path: "/PenjemputanScreen",
        name: "penjemputan",
        builder: (context, state) {
          final _addInquiry = state.extra as NewInquiryModel;

          return PenjemputanScreen(
            addInquiry: _addInquiry,
          );
        }),
    GoRoute(
      path: "/SampahPenjemputan",
      name: "sampahpenjemputan",
      builder: (context, state) {
        final addItemModel = state.extra as AddItemModel;
        return SampahPenjemputan(addItem: addItemModel);
      },
    ),
    GoRoute(
      path: "/SuccessPenjemputan",
      name: Routes.SuccesPenjemputan,
      builder: (context, state) => const SuccessPenjemputan(),
    ),
    GoRoute(
      path: "/DetailRiwayat",
      name: Routes.DetailRiwayat,
      builder: (context, state) {
        context.read<DetalHistoryCubit>().btn("");
        return const DetailRiwayat(
          date: Routes.DetailRiwayat,
        );
      },
    ),
    GoRoute(
        path: "/riwayatScreen",
        name: Routes.RiwayatScreen,
        builder: (context, state) {
          BlocProvider.of<HistoryCubit>(context).fecthHistory();
          return const RiwayatScreen();
        }),
    GoRoute(
      path: "/ArticleScreen",
      name: "article",
      builder: (context, state) => const ArticleScreen(),
    ),
    GoRoute(
      path: "/DetailArticle",
      name: "detailarticle",
      builder: (context, state) => const DetailArticle(),
    ),

    GoRoute(
      path: "/KonfirmasiPembayaran",
      name: "KonfirmasiPembayaranScreen",
      builder: (context, state) => const KonfirmasiPembayaranScreen(),
    ),
    GoRoute(
      path: "/PilihPembayaran",
      name: "PilihPembayaranScreen",
      builder: (context, state) => const PilihPembayaranScreen(),
    ),
    GoRoute(
      path: "/UbahPasswordScreen",
      name: "ubahPasswordScreen",
      builder: (context, state) => const UbahPasswordScreen(),
    ),
  ]);
}
