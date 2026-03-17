// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Track _$TrackFromJson(Map<String, dynamic> json) => _Track(
      id: (json['id'] as num).toInt(),
      audio: json['audio'] as String,
      name: json['name'] as String,
      artistName: json['artist_name'] as String,
    );

Map<String, dynamic> _$TrackToJson(_Track instance) => <String, dynamic>{
      'id': instance.id,
      'audio': instance.audio,
      'name': instance.name,
      'artist_name': instance.artistName,
    };
