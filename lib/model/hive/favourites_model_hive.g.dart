// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouritesAdapter extends TypeAdapter<Favourites> {
  @override
  final int typeId = 1;

  @override
  Favourites read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favourites(
      isFavourite: fields[0] as bool,
      productId: fields[1] as String,
      updateId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Favourites obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.isFavourite)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.updateId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouritesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
