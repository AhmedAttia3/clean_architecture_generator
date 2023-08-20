import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/domain/entities/address_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';

class UserEntity {
final int id;
final String name;
final AddressEntity? address;
final double wallet;
final List<dynamic> items;
final List<OtpEntity> otp;
const UserEntity({
required this.id,
required this.name,
required this.address,
required this.wallet,
required this.items,
required this.otp,
 });

}

