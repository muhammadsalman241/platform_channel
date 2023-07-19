import 'package:flutter/services.dart';

class RandomNumbers {
  static const RANDOM_CHANNEL = "com.your.app/random_num";
  static const METHOD_GENERATE = "generate";

  final MethodChannel channel = const MethodChannel(RANDOM_CHANNEL);

  Future<int?> generate([int? userRange]) async {
    try {
      final result = await channel.invokeMethod(METHOD_GENERATE, <String, dynamic>{
        'range': userRange,
      });
      final res = result as Map;
      print(res);
      return res["ran"];
    } catch(e) {
      print("generate exception: $e");
      rethrow;
    }
  }

}