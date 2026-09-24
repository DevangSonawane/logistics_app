import '../models/exception.dart';

/// Ops exceptions feed: list, resolve with note, escalate severity.
abstract class ExceptionRepository {
  Future<List<ExceptionItem>> list();
  Future<ExceptionItem> resolve(String id, String note);
  Future<ExceptionItem> escalate(String id);
}
