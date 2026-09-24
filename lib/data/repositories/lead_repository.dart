import '../models/lead.dart';

/// Sales pipeline: leads, quotes, visits.
abstract class LeadRepository {
  Future<List<Lead>> leads();
  Future<Lead> add(Lead lead);
  Future<Lead> setStage(String id, LeadStage stage);
  Future<List<Visit>> visits();
  Future<Visit> checkIn(Visit visit);
  Future<Visit> checkOut(String id, String outcome);
  Future<List<SalesTarget>> targets();
}
