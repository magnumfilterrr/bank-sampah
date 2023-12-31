// ignore_for_file: public_member_api_docs, sort_constructors_fir

import 'package:json_annotation/json_annotation.dart';
import 'package:loginandsignup/data/model/Riwayat/riwayat_response.dart';
import 'package:loginandsignup/data/model/home/home_profile_response.dart';
import 'package:loginandsignup/domain/model/data/home/home_data.dart';
import 'package:loginandsignup/domain/model/data/home/riwayat_data.dart';

import '../../../domain/model/data/home/home_profile_data.dart';

part 'home_remote_response.g.dart';

abstract class HomeRemoteResponseMapper {
  HomeData toHomeData();
}

@JsonSerializable()
class HomeRemoteResponse implements HomeRemoteResponseMapper {
  HomeProfileResponse? profile;
  List<RiwayatCollectionResponse>? riwayat;
  HomeRemoteResponse({
    this.profile,
    this.riwayat,
  });

  factory HomeRemoteResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeRemoteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeRemoteResponseToJson(this);

  @override
  HomeData toHomeData() {
    List<RiwayatData> riwayatDataList =
        riwayat?.map((response) => response.toRiwayatData()).toList() ??
            List.empty();
    return HomeData(
        profile?.toHomeProfileData() ??
            HomeProfileData(" ", " ", 0, " ", " ", " "),
        riwayatDataList);
  }
}
