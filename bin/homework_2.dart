import 'dart:async';

// Հեշտ
// Խնդիր 1
void manageCart() {
List<String> cartItems = ['Կաթ', 'Հաց', 'Ձու'];

cartItems.add('Պանիր');
cartItems.insert(1, 'Կարագ');
cartItems.removeAt(2);
cartItems[0] = 'Թեյ';

if (cartItems.isNotEmpty) {
String startingProduct = cartItems.first;
String endingProduct = cartItems.last;

print('First product: $startingProduct');
print('Latest product: $endingProduct');
}

bool hasNoProducts = cartItems.isEmpty;
print('List is empty. $hasNoProducts');

print('Final shopping list: $cartItems');
}

// Խնդիր 2
class Book {
String title;
String author;
int pages;

Book({
required this.title,
required this.author,
required this.pages,
});

String getBookDetails() {
return '$title by $author, $pages pages';
}
}

// Խնդիր 3
Future<int> fetchAfterDelay(int number) async {
await Future.delayed(const Duration(milliseconds: 100));
return number;
}

Future<int> addDelayedNumbers(int first, int second) async {
int firstResult = await fetchAfterDelay(first);
int secondResult = await fetchAfterDelay(second);

return firstResult + secondResult;
}

// Միջին
// Խնդիր 1
abstract class Vehicle {
double fuelConsumption();
}

class Car extends Vehicle {
double litersPer100Km;

Car(this.litersPer100Km);

@override
double fuelConsumption() {
return litersPer100Km;
}
}

class Motorcycle extends Vehicle {
double litersPer100Km;

Motorcycle(this.litersPer100Km);

@override
double fuelConsumption() {
return litersPer100Km;
}
}

double calculateFuelUsage(
List<Vehicle> vehicleList,
double distanceKm,
) {
double fuelUsed = 0.0;

for (var vehicle in vehicleList) {
fuelUsed += vehicle.fuelConsumption() * distanceKm / 100;
}

return fuelUsed;
}

// Խնդիր 2
class Product {
String name;
String category;
double price;

Product({
required this.name,
required this.category,
required this.price,
});
}

Map<String, double> calculateCategoryTotals(
List<Product> productList,
) {
Map<String, double> categoryTotals = {};

for (var item in productList) {
categoryTotals[item.category] =
(categoryTotals[item.category] ?? 0.0) + item.price;
}

return categoryTotals;
}

// Խնդիր 3
Future<int> retrievePositiveNumber(int number) async {
if (number <= 0) {
throw Exception('Value must be positive');
}

await Future.delayed(const Duration(milliseconds: 100));
return number;
}

Future<int> getNumberOrDefault(int input) async {
try {
return await retrievePositiveNumber(input);
} catch (error) {
return 0;
}
}

// Բարդ
// Խնդիր 1
abstract class Payment {
double calculateFee(double amount);
}

class CardPayment extends Payment {
@override
double calculateFee(double amount) {
return amount * 0.02;
}
}

class CashPayment extends Payment {
@override
double calculateFee(double amount) {
return 0.0;
}
}

class CryptoPayment extends Payment {
@override
double calculateFee(double amount) {
return amount * 0.05;
}
}

double getFinalAmount(Payment method, double price) {
return price + method.calculateFee(price);
}

// Խնդիր 2
List<int> findMatchingIndices(
List<int> values,
int targetSum,
) {
Map<int, int> previousIndices = {};

for (int index = 0; index < values.length; index++) {
int neededNumber = targetSum - values[index];

if (previousIndices.containsKey(neededNumber)) {
return [previousIndices[neededNumber]!, index];
}

previousIndices[values[index]] = index;
}

return [];
}

// Խնդիր 3
Future<String> executeDelayedTask(
String taskName,
int delayMs,
) async {
await Future.delayed(Duration(milliseconds: delayMs));
return 'Task $taskName completed';
}

Future<List<String>> executeAllTasks() async {
return await Future.wait([
executeDelayedTask('A', 100),
executeDelayedTask('B', 50),
executeDelayedTask('C', 150),
]);
}

void main() async {
print('--- ՀԵՇՏ ---');

manageCart();

var novel = Book(
title: '1984',
author: 'Poxos Poxosyan',
pages: 328,
);

print(novel.getBookDetails());

int sumResult = await addDelayedNumbers(10, 20);
print('Sum: $sumResult');

print('\n--- ՄԻՋԻՆ ---');

List<Vehicle> garage = [
Car(8.5),
Motorcycle(4.0),
];

print(
'Total consumption (200km): '
'${calculateFuelUsage(garage, 200)}',
);

List<Product> inventory = [
Product(name: 'Apple', category: 'Foo d', price: 2.5),
Product(name: 'Bread', category: 'Food', price: 1.5),
Product(name: 'Phone', category: 'Tech', price: 500.0),
];

print('Total by category: ${calculateCategoryTotals(inventory)}');

print(
'Safe get number (positive): '
'${await getNumberOrDefault(5)}',
);

print(
'Safe get number (negative): '
'${await getNumberOrDefault(-3)}',
);

print('\n--- ԲԱՐԴ ---');

Payment selectedMethod = CardPayment();

print('Total payment amount: ${getFinalAmount(selectedMethod, 100.0)}');

print(
'Find pair indices: '
'${findMatchingIndices([2, 7, 11, 15], 9)}',
);

print('Running asynchronous tasks...');

List<String> completedTasks = await executeAllTasks();
print('Task results: $completedTasks');
}
