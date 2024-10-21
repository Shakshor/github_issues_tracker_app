// AsyncNotifier Provider for Posts
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repository/lines_repository/lines_repo.dart';

final linesNotifierProvider = AsyncNotifierProvider<LinesNotifier, dynamic>(() {
  return LinesNotifier();
});

class LinesNotifier extends AsyncNotifier<dynamic>{
  late final LinesRepo _repository;

  @override
  FutureOr build() async {
    _repository = ref.read(linesRepoProvider); // Dependency injection
    return await _repository.fetchLines();
  }
}