import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/events_content.dart';

abstract interface class EventsRepository {
  Future<Either<Failure, EventsContent>> fetch();
}
