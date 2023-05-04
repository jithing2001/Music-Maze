// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistClassAdapter extends TypeAdapter<PlaylistClass> {
  @override
  final int typeId = 1;

  @override
  PlaylistClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaylistClass(
      playlistName: fields[0] as String,
    )..songsId = (fields[1] as List).cast<int>();
  }

  @override
  void write(BinaryWriter writer, PlaylistClass obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.playlistName)
      ..writeByte(1)
      ..write(obj.songsId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}