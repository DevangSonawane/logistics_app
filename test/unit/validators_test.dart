import 'package:flutter_test/flutter_test.dart';
import 'package:roadops/core/utils/validators.dart';

void main() {
  group('phone', () {
    test('accepts valid 10-digit numbers starting 6-9', () {
      expect(Validators.isPhoneValid('9000000001'), isTrue);
      expect(Validators.isPhoneValid('6123456789'), isTrue);
    });

    test('rejects bad numbers', () {
      expect(Validators.isPhoneValid('1234567890'), isFalse);
      expect(Validators.isPhoneValid('900000001'), isFalse);
      expect(Validators.isPhoneValid('90000000011'), isFalse);
      expect(Validators.isPhoneValid('90000000ab'), isFalse);
      expect(Validators.isPhoneValid(''), isFalse);
    });
  });

  group('otp', () {
    test('accepts exactly 6 digits', () {
      expect(Validators.isOtpValid('123456'), isTrue);
      expect(Validators.isOtpValid('12345'), isFalse);
      expect(Validators.isOtpValid('1234567'), isFalse);
      expect(Validators.isOtpValid('abcdef'), isFalse);
    });
  });

  group('gstin', () {
    test('accepts valid 15-char GSTIN', () {
      expect(Validators.isGstinValid('27AAKCS1234F1Z5'), isTrue);
      expect(Validators.isGstinValid('27aakcs1234f1z5'), isTrue);
    });

    test('rejects malformed GSTIN', () {
      expect(Validators.isGstinValid('27AAKCS1234F1'), isFalse);
      expect(Validators.isGstinValid(''), isFalse);
    });
  });

  group('pan', () {
    test('accepts valid PAN', () {
      expect(Validators.isPanValid('AAKCS1234F'), isTrue);
      expect(Validators.isPanValid('aakcs1234f'), isTrue);
      expect(Validators.isPanValid('AAKCS123F'), isFalse);
    });
  });

  group('vehicle number', () {
    test('accepts Indian registration formats', () {
      expect(Validators.isVehicleNoValid('MH12AB1234'), isTrue);
      expect(Validators.isVehicleNoValid('MH 12 AB 1234'), isTrue);
      expect(Validators.isVehicleNoValid('KA01GH3456'), isTrue);
    });

    test('rejects bad formats', () {
      expect(Validators.isVehicleNoValid('1234'), isFalse);
      expect(Validators.isVehicleNoValid(''), isFalse);
    });
  });
}
