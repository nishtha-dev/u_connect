// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) =>
    UserDataModel(
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      description: json['description'] as String?,
      name: json['name'] as String? ?? '',
      userFollowersIdList: (json['followers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      userFollowingList: (json['following'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      emailId: json['emailId'] as String?,
      proNoun: $enumDecodeNullable(_$PronounTypeEnumEnumMap, json['proNoun']),
      customPronoun: json['customPronoun'] as String?,
    );

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('avatar', instance.avatar);
  writeNotNull('bio', instance.bio);
  writeNotNull('description', instance.description);
  writeNotNull('proNoun', _$PronounTypeEnumEnumMap[instance.proNoun]);
  writeNotNull('customPronoun', instance.customPronoun);
  val['name'] = instance.name;
  writeNotNull('emailId', instance.emailId);
  val['followers'] = instance.userFollowersIdList;
  val['following'] = instance.userFollowingList;
  return val;
}

const _$PronounTypeEnumEnumMap = {
  PronounTypeEnum.sheHer: 'sheHer',
  PronounTypeEnum.heHim: 'heHim',
  PronounTypeEnum.theyThem: 'theyThem',
  PronounTypeEnum.custom: 'custom',
  PronounTypeEnum.none: 'none',
};
