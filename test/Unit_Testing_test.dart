import 'package:test/test.dart';
import 'package:split/Screens/Groups/Create Groups.dart';



void main() {
  test('test calculator', () {
    double total = 1000.00;
    int members = 1;
    double amount = calculate(total, members);
    expect(amount, equals(1000.00));
  });


  test('test calculator1 - 4 members', () {
    double total = 1000.00;
    int members = 4;
    double amount = calculate(total, members);
    expect(amount, equals(250.00));
  });

  test('test calculator1 - 3 members', () {
    double total = 25.00;
    int members = 4;
    double amount = calculate(total, members);
    expect(amount, equals(6.25));
  });

  test('test calculator1 - 100 members', () {
    double total = 150.00;
    int members = 100;
    double amount = calculate(total, members);
    print(amount);
    expect(amount, equals(1.5));
  });
//ask about this case
  test('test calculator1 - 2 members/ 0 total', () {
    double total = 0.0;
    int members = 2;
    double amount = calculate(total, members);
    print(amount);
    expect(amount, equals(0));
  });

  //ask about this case
  test('test calculator1 - 0 members', () {
    double total = 150.00;
    int members = 0;
    double amount = calculate(total, members);
    print(amount);
    expect(amount, equals(150.00));
  });


  test('test_addnames', () {
    String name = "bill";
    List<String> list = [];
    addnames(list, name);
    name = "jon";
    addnames(list, name);
    expect(list, equals(['bill', 'jon']));
  });

  test('test_addnames-empty', () {
    String name = "";
    List<String> list = [];
    addnames(list, name);
    expect(list, equals([]));
  });

  test('test_addnames-empty, then add name', () {
    String name = "";
    List<String> list = [];
    addnames(list, name);
    name = "jon";
    addnames(list, name);
    expect(list, equals(['jon']));
  });


  test('test_addnames_10', () {
    String name = "Bill";
    List<String> list = [];
    addnames(list, name);
    name = "Jon";
    addnames(list, name);
    name = "Bob";
    addnames(list, name);
    name = "Tony";
    addnames(list, name);
    name = "Dylan";
    addnames(list, name);
    name = "Wataru";
    addnames(list, name);
    name = "Alex";
    addnames(list, name);
    name = "Javier";
    addnames(list, name);
    name = "Kevin";
    addnames(list, name);
    name = "Marco";
    addnames(list, name);
    expect(list, equals(['Bill', 'Jon', 'Bob', 'Tony', 'Dylan', 'Wataru', 'Alex', 'Javier', 'Kevin', 'Marco']));
  });
}


