// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreditCardModelAdapter extends TypeAdapter<CreditCardModel> {
  @override
  final int typeId = 2;

  @override
  CreditCardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreditCardModel(
      id: fields[0] as int,
      name: fields[1] as String,
      institution: fields[2] as InstitutionModel,
      cardType: fields[3] as InstitutionModel,
      number: fields[4] as String,
      expenses: (fields[5] as List).cast<CreditCardTransactionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CreditCardModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.institution)
      ..writeByte(3)
      ..write(obj.cardType)
      ..writeByte(4)
      ..write(obj.number)
      ..writeByte(5)
      ..write(obj.expenses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreditCardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
