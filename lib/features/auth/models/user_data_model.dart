import 'package:u_connect/core/enums/dropdown_enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data_model.g.dart';

class LoginUserData {
  String email = "";
  String passWord = "";
}

class SignUpUserData extends LoginUserData {
  String name = "";
}

@JsonSerializable(
  includeIfNull: false,
)
class UserDataModel {
  final String? avatar;
  final String? bio;
  final String? description;
  final PronounTypeEnum? proNoun;
  final String? customPronoun;

  final String name;
  final String? emailId;
  @JsonKey(name: 'followers')
  final List<String> userFollowersIdList;
  @JsonKey(name: 'following')
  final List<String> userFollowingList;
  

  const UserDataModel(
      {this.avatar,
      this.bio,
      this.description,
      this.name = '',
      this.userFollowersIdList = const [],
      this.userFollowingList = const [],
      this.emailId,
      this.proNoun,
      this.customPronoun});
  UserDataModel copyWith(
      {String? avatar,
      String? bio,
      String? description,
      String? name,
      String? emailId,
      List<String>? userFollowersIdList,
      List<String>? userFollowingList,
      PronounTypeEnum? proNoun,
      String? customPronoun}) {
    return UserDataModel(
        avatar: avatar ?? this.avatar,
        bio: bio ?? this.bio,
        description: description ?? this.description,
        name: name ?? this.name,
        userFollowersIdList: userFollowersIdList ?? this.userFollowersIdList,
        userFollowingList: userFollowingList ?? this.userFollowingList,
        emailId: emailId ?? this.emailId,
        proNoun: proNoun ?? this.proNoun,
        customPronoun: customPronoun ?? this.customPronoun);
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);

  String? get selectedPronounName =>
      (proNoun?.isCustom ?? false) ? customPronoun : proNoun?.name;
}
