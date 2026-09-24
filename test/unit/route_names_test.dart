import 'package:flutter_test/flutter_test.dart';
import 'package:roadops/core/router/route_names.dart';
import 'package:roadops/data/models/app_user.dart';

void main() {
  test('each role maps to its home', () {
    expect(RouteNames.homeFor(AppRole.driver), '/driver/home');
    expect(RouteNames.homeFor(AppRole.owner), '/owner/home');
    expect(RouteNames.homeFor(AppRole.ops), '/ops/home');
    expect(RouteNames.homeFor(AppRole.sales), '/sales/home');
    expect(RouteNames.homeFor(AppRole.supervisor), '/supervisor/home');
    expect(RouteNames.homeFor(AppRole.accountant), '/accountant/home');
  });

  test('role segment detected from path', () {
    expect(RouteNames.roleForPath('/driver/home'), AppRole.driver);
    expect(RouteNames.roleForPath('/owner/accounts'), AppRole.owner);
    expect(RouteNames.roleForPath('/login'), isNull);
    expect(RouteNames.roleForPath('/403'), isNull);
  });
}
