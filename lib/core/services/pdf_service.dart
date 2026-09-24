import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../data/models/driver.dart';

/// Local PDF generation for LR / quote / receipt / payslip previews.
/// The shared PDF viewer page (Phase 6) renders these via `printing`.
class PdfService {
  /// Branded salary-slip PDF for the driver earnings tab.
  Future<Uint8List> payslip({
    required String driverName,
    required SalarySlip slip,
  }) async {
    final pw.Document doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Shree Ganesh Roadlines Pvt Ltd',
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text('Salary Slip - ${slip.month}'),
            pw.SizedBox(height: 16),
            pw.Text('Driver: $driverName'),
            pw.SizedBox(height: 8),
            pw.Divider(),
            pw.SizedBox(height: 8),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Net payable'),
                pw.Text(
                  'Rs.${slip.amount}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    return doc.save();
  }

  /// Generic two-column statement (ledgers, memos, briefs) for Share PDF.
  Future<Uint8List> statement({
    required String title,
    required List<(String, String)> rows,
  }) async {
    final pw.Document doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Shree Ganesh Roadlines Pvt Ltd',
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(title),
            pw.SizedBox(height: 16),
            for (final (left, right) in rows) ...[
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [pw.Text(left), pw.Text(right)],
              ),
              pw.SizedBox(height: 6),
            ],
          ],
        ),
      ),
    );
    return doc.save();
  }
}
