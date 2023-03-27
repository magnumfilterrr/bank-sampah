import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loginandsignup/data/model/home/home_remote_response.dart';
import 'package:loginandsignup/domain/model/data/home/home_data.dart';
import 'package:loginandsignup/data/repository/home/home_repository_impl.dart';
import 'package:loginandsignup/data/repository/login/login_repository_impl.dart';
import 'package:loginandsignup/presention/navigasiton/route.dart';
import 'package:loginandsignup/presention/pages/bank_sampah/bloc/bank_sampah_bloc.dart';
import 'package:loginandsignup/presention/pages/bank_sampah/bloc/counter.dart';
import 'package:loginandsignup/presention/pages/bank_sampah/radiotile.dart';
import 'package:loginandsignup/presention/pages/home/cubit/home_cubit.dart';
import 'package:loginandsignup/presention/pages/login/cubit/login_cubit.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';
import 'package:loginandsignup/data/utilities/commons.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../model/costum_shapes.dart';

part 'home/home_page.dart';

part 'login/login_screen.dart';
part 'autentikasi/autentikasi.dart';
part 'registrasi/registrasi.dart';
part 'layanan/layanan_screen.dart';
part 'config_pass/config_pass_screen.dart';
part 'success_password/success_pass_screen.dart';
part 'lupa_password/lupa_password.dart';
part 'bank_sampah/bank_sampah_screen.dart';
part 'bank_sampah/bank_sampah_penjemputan.dart';
part 'bank_sampah/success_penjemputan_screen.dart';
part 'penjemputan/penjemputan_screen.dart';
part 'tukar_poin/tukar_poin1.dart';

part 'success_auntentikasi/succes_screen.dart';
part 'splash_screen/splash_screen.dart';
part 'navigasibar.dart';
part 'detail_riwayat/detail_riawayat_screen.dart';
