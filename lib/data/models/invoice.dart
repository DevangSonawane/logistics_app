import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice.freezed.dart';
part 'invoice.g.dart';

enum InvoiceStatus { draft, sent, partPaid, paid, overdue }

/// Customer invoice with e-invoice IRN chip. Money in integer rupees.
@freezed
abstract class Invoice with _$Invoice {
  const factory Invoice({
    required String id,
    required String no,
    required String customerId,
    required String customerName,
    required int amount,
    required int gst,
    @Default(InvoiceStatus.sent) InvoiceStatus status,
    required DateTime dueDate,
    String? irn,
    @Default(0) int paidAmount,
  }) = _Invoice;

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);
}

/// Receipt against invoices (permission-gated).
@freezed
abstract class Receipt with _$Receipt {
  const factory Receipt({
    required String id,
    required String customerId,
    @Default([]) List<String> invoiceIds,
    required int amount,
    required String mode,
    String? utr,
    @Default(0) int tds,
    String? shortPayReason,
    required DateTime at,
  }) = _Receipt;

  factory Receipt.fromJson(Map<String, dynamic> json) =>
      _$ReceiptFromJson(json);
}
