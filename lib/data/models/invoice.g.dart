// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Invoice _$InvoiceFromJson(Map<String, dynamic> json) => _Invoice(
      id: json['id'] as String,
      no: json['no'] as String,
      customerId: json['customerId'] as String,
      customerName: json['customerName'] as String,
      amount: (json['amount'] as num).toInt(),
      gst: (json['gst'] as num).toInt(),
      status: $enumDecodeNullable(_$InvoiceStatusEnumMap, json['status']) ??
          InvoiceStatus.sent,
      dueDate: DateTime.parse(json['dueDate'] as String),
      irn: json['irn'] as String?,
      paidAmount: (json['paidAmount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$InvoiceToJson(_Invoice instance) => <String, dynamic>{
      'id': instance.id,
      'no': instance.no,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'amount': instance.amount,
      'gst': instance.gst,
      'status': _$InvoiceStatusEnumMap[instance.status]!,
      'dueDate': instance.dueDate.toIso8601String(),
      'irn': instance.irn,
      'paidAmount': instance.paidAmount,
    };

const _$InvoiceStatusEnumMap = {
  InvoiceStatus.draft: 'draft',
  InvoiceStatus.sent: 'sent',
  InvoiceStatus.partPaid: 'partPaid',
  InvoiceStatus.paid: 'paid',
  InvoiceStatus.overdue: 'overdue',
};

_Receipt _$ReceiptFromJson(Map<String, dynamic> json) => _Receipt(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      invoiceIds: (json['invoiceIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      amount: (json['amount'] as num).toInt(),
      mode: json['mode'] as String,
      utr: json['utr'] as String?,
      tds: (json['tds'] as num?)?.toInt() ?? 0,
      shortPayReason: json['shortPayReason'] as String?,
      at: DateTime.parse(json['at'] as String),
    );

Map<String, dynamic> _$ReceiptToJson(_Receipt instance) => <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'invoiceIds': instance.invoiceIds,
      'amount': instance.amount,
      'mode': instance.mode,
      'utr': instance.utr,
      'tds': instance.tds,
      'shortPayReason': instance.shortPayReason,
      'at': instance.at.toIso8601String(),
    };
