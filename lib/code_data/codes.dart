class Code {
  // ignore: constant_identifier_names
  static const List<String> Codes = [
    '''abstract class Drinkable {
  void pour();
}

class Beer implements Drinkable {
  void pour() {
    print("Pouring a delicious beer!");
  }
}

class Coffee implements Drinkable {
  void pour() {
    print("Pouring a refreshing coffee!");
  }
}

abstract class DrinkFactory {
  Drinkable createDrink();
}

class Pub implements DrinkFactory {
  Drinkable createDrink() {
    return Beer();
  }
}

class CoffeeShop implements DrinkFactory {
  Drinkable createDrink() {
    return Coffee();
  }
}

void main() {
  var mood = "sleepy";
  DrinkFactory destination;

  switch(mood) {
    case "sleepy": destination = CoffeeShop(); break;
    case "done": destination = Pub(); break;
    default: print("I only have two moods...");
  }

  var myBeverage = destination.createDrink();
  myBeverage.pour();

  /*
     Pouring a refreshing coffee!
  */
}''',
'''const adapteeMessage = 'Adaptee#method was called';

class Adaptee {
  String method() {
    print('Adaptee#method is being called');

    return adapteeMessage;
  }
}

abstract class Target {
  String call();
}

class Adapter implements Target {
  String call() {
    var adaptee = Adaptee();
    print('Adapter#call is being called');

    return adaptee.method();
  }
}

void main() {
  var adapter = Adapter();
  var result = adapter.call();

  assert(result == adapteeMessage);
}''',
'''abstract class Loudspeaker {
  void announce(String message);
}

class LoudspeakerWithMuzak implements Loudspeaker {
  void announce(String message) => print("<soothing muzak playing> message");
}

class LoudspeakerWithAlarm implements Loudspeaker {
  void announce(String message) => print("<BOO-OP BOO-OP> message <BOO-OP>");
}

abstract class Factory {
  Loudspeaker loudspeaker = LoudspeakerWithMuzak();
  void announce(String message) => loudspeaker.announce(message);
}

class CoffeeRoaster extends Factory {
  int _temp = 200;
  bool get isTooHot => _temp >= 225;

  void turnGasValve() {
    loudspeaker.announce("Increasing gas!");
    _temp += 25;
    loudspeaker.announce("Temperature is now at _temp");
  }
}

void main() {
  var roaster = CoffeeRoaster();
  for (var i=0; i < 3; i++) {
    roaster.turnGasValve();
    if (roaster.isTooHot) { roaster.loudspeaker = LoudspeakerWithAlarm(); }
  }

  /*
    <soothing muzak playing> Increasing gas!
    <soothing muzak playing> Temperature is now at 225
    <BOO-OP BOO-OP> Increasing gas! <BOO-OP>
    <BOO-OP BOO-OP> Temperature is now at 250 <BOO-OP>
    <BOO-OP BOO-OP> Increasing gas! <BOO-OP>
    <BOO-OP BOO-OP> Temperature is now at 275 <BOO-OP>
  */
}''',
'''class PizzaBuilder {
  String _crust;
  int _diameter;
  Set<String> _toppings;

  PizzaBuilder(this._diameter);

  String get crust => _crust;
  set crust(String newCrust) {
    _crust = newCrust;
  }

  int get diameter => _diameter;
  set diameter(int newDiameter) {
    _diameter = newDiameter;
  }

  Set<String> get toppings => _toppings;
  set toppings(Set<String> newToppings) {
    _toppings = newToppings;
    _ensureCheese();
  }

  void _ensureCheese() {
    _toppings.add("cheese");
  }

  Pizza build() {
    return Pizza(this);
  }
}

class Pizza {
  String _crust;
  int _diameter;
  Set<String> _toppings;

  Pizza(PizzaBuilder builder) {
    _crust = builder.crust;
    _diameter = builder.diameter;
    _toppings = builder.toppings;
  }

  String get crust => _crust;
  int get diameter => _diameter;
  String get toppings => _stringifiedToppings();
  String _stringifiedToppings() {
    var stringToppings = _toppings.join(", ");
    var lastComma = stringToppings.lastIndexOf(",");
    var replacement = ",".allMatches(stringToppings).length > 1 ? ", and" : " and";

    return stringToppings.replaceRange(lastComma, lastComma + 1, replacement);
  }

  @override
  String toString() {
    return "A delicous _diameter" pizza with _crust crust covered in toppings";
  }
}

void main() {
  // Create a handy PizzaBuilder with an 8" diameter.
  var pizzaBuilder = PizzaBuilder(8);

  // Add some attributes to the builder.
  pizzaBuilder.crust = "deep dish";
  pizzaBuilder.toppings = Set.from(["pepperoni"]);

  // Let's make a pizza!
  var plainPizza = Pizza(pizzaBuilder);
  print("Behold! plainPizza.");
  assert(plainPizza.toString() == "A delicous 8" pizza with deep dish crust covered in pepperoni and cheese");

  // Now to adjust some things for the next pizza...
  pizzaBuilder.crust = "gold plated";
  pizzaBuilder.diameter = 72;
  pizzaBuilder.toppings = Set.from(["anchovies", "caviar", "diamonds"]);

  // The beauty of the build is you can quickly iterate and produce instances of a class.
  // For example, we have an early employee of the latest unicorn in line. So much disposable income!
  // Also note, we use the .build() function of the builder this time.
  var luxuriousPizza = pizzaBuilder.build();
  print("Wow! luxuriousPizza? Someone is rich!");
  assert(luxuriousPizza.toString() == "A delicous 72" pizza with gold plated crust covered in anchovies, caviar, diamonds, and cheese");
}''',
'''enum LogLevel {
  None,
  Info,
  Debug,
  Warning,
  Error,
  FunctionalMessage,
  FunctionalError,
}

abstract class Logger {
  Set<LogLevel> levels;
  Logger _next;

  Logger(this.levels);

  bool get universal => levels.containsAll(LogLevel.values);
  void set next(Logger nextLogger) => _next = nextLogger;

  void addLevel(LogLevel level) => levels.add(level);

  void log(LogLevel level, String msg) {
    if (levels.contains(level) || universal) {
      write_message(msg);
    } 
    _next?.log(level, msg);
  }

  void write_message(String msg);
}

class ConsoleLogger extends Logger {
  ConsoleLogger(Set<LogLevel> levels) : super(levels);
  void write_message(String msg) => print("[Console]: msg");
}

class EmailLogger extends Logger {
  EmailLogger(Set<LogLevel> levels) : super(levels);
  void write_message(String msg) => print("[Email]: msg");
}

class FileLogger extends Logger {
  FileLogger(Set<LogLevel> levels) : super(levels);
  void write_message(String msg) => print("[File]: msg");
}

void main() {
  var logger = ConsoleLogger(Set.from(LogLevel.values));
  var eLog = EmailLogger(Set.from([LogLevel.FunctionalMessage, LogLevel.FunctionalError]));
  var fLog = FileLogger(Set.from([LogLevel.Warning, LogLevel.Error]));

  logger.next = eLog;
  eLog.next = fLog;

  logger.log(LogLevel.Debug, "Some amazingly helpful debug message");
  logger.log(LogLevel.Info, "Pretty important information");

  logger.log(LogLevel.Warning, "This is a warning!");
  logger.log(LogLevel.Error, "AHHHHHHHHH!");

  logger.log(LogLevel.FunctionalError, "This is not a show stopper");
  logger.log(LogLevel.FunctionalMessage, "This is basically just info");

  /*
    [Console]: Some amazingly helpful debug message
    [Console]: Pretty important information
    [Console]: This is a warning!
    [File]: This is a warning!
    [Console]: AHHHHHHHHH!
    [File]: AHHHHHHHHH!
    [Console]: This is not a show stopper
    [Email]: This is not a show stopper
    [Console]: This is basically just info
    [Email]: This is basically just info
  */
}''',
'''abstract class Receiver {
  Set<String> get actions;
}

abstract class Command {
  Receiver receiver;
  String name;

  Command(this.receiver);

  @override
  String toString() => this.name;

  void execute();
}

class Invoker {
  List<String> history = [];
  void execute(Command cmd) {
    cmd.execute();
    history.add("[{DateTime.now()}] Executed cmd");
  }

  @override
  String toString() => history.fold("", (events, event) => events + "eventrn");
}

class TurnOffCommand extends Command {
  String name = "Turn off";
  TurnOffCommand(Light light): super(light);
  void execute() {
    (receiver as Light).turnOff();
  }
}

class TurnOnCommand extends Command {
  String name = "Turn on";
  TurnOnCommand(Light light): super(light);
  void execute() {
    (receiver as Light).turnOn();
  }
}

class Light implements Receiver {
  void turnOff() => print("Light off!");
  void turnOn() => print("Light on!");
  Set<String> get actions => Set.from(["off", "on"]);
}

class LightSwitch {
  Invoker _switch = Invoker();
  Light light;

  LightSwitch(this.light);

  String get history => _switch.toString();

  void perform(String action) {
    if (!light.actions.contains(action)) {
      return print("Uh...wait, wut?");
    }
    switch(action) {
      case "on": return _switch.execute(TurnOnCommand(light));
      case "off": return _switch.execute(TurnOffCommand(light));
    }
  }
}

void main() {
  var myFavoriteLamp = Light();
  var iotLightSwitch = LightSwitch(myFavoriteLamp);

  iotLightSwitch.perform("on");
  iotLightSwitch.perform("off");
  iotLightSwitch.perform("blink");
  iotLightSwitch.perform("on");

  print("rn*** Fancy IoT Switch Logs ***rn{iotLightSwitch.history}");

  /*
    Light on!
    Light off!
    Uh...wait, wut?
    Light on!

    *** Fancy IoT Switch Logs ***
    [2019-06-20 08:00:38.880050] Executed Turn on
    [2019-06-20 08:00:38.883495] Executed Turn off
    [2019-06-20 08:00:38.883702] Executed Turn on
  */
}''',
'''abstract class Thing {
  String name;
  void doSomething();
}

class CompositeThing implements Thing {
  String name;
  Set<Thing> _childThings = Set();

  CompositeThing(this.name);

  void addChild(Thing child) {
    _childThings.add(child);
  }

  void doSomething() {
    print("rn** name is doing something! ** rn");
    _childThings.forEach((thing) => thing.doSomething());
    print("rn** name is all done. ** rn");
  }
}

class LeafThing implements Thing {
  String name;

  LeafThing(this.name);

  void doSomething() {
    print("*  name!");
  }
}

void main() {
  var compositeParent = CompositeThing("Cat in the Hat");
  var compositeChild1 = CompositeThing("Thing 1");
  var compositeChild2 = CompositeThing("Thing 2");

  var leaf1_1 = LeafThing("Frustrate fish");
  var leaf1_2 = LeafThing("Knock down vases");
  var leaf2_1 = LeafThing("Ruin mom's dress");
  var leaf2_2 = LeafThing("Clean up");

  compositeChild1.addChild(leaf1_1);
  compositeChild1.addChild(leaf1_2);
  
  compositeChild2.addChild(leaf2_1);
  compositeChild2.addChild(leaf2_2);

  compositeParent.addChild(compositeChild1);
  compositeParent.addChild(compositeChild2);

  compositeParent.doSomething();

  /*
   ** Cat in the Hat is doing something! **


    ** Thing 1 is doing something! **

    *  Frustrate fish!
    *  Knock down vases!

    ** Thing 1 is all done. **


    ** Thing 2 is doing something! **

    *  Ruin mom's dress!
    *  Clean up!

    ** Thing 2 is all done. **


    ** Cat in the Hat is all done. **
  */
}''',
'''abstract class Beverage {
  double get cost;
  String get ingredients;
}

class Ingredient {
  double cost;
  String name;

  Ingredient(this.name, this.cost);

  @override
  String toString() => name;
}

var coffee = Ingredient("coffee", .25);
var milk = Ingredient("milk", .5);
var sugar = Ingredient("sugar", .1);

class Coffee implements Beverage {
  final Set<Ingredient> _ingredients = {coffee, milk, sugar};

  @override
  double get cost => _ingredients.fold(0, (total, ingredient) => total + ingredient.cost);

  @override
  String get ingredients {
    var stringIngredients = _ingredients.fold<String>("", (total, ingredient) {
      if (_ingredients.last.name == ingredient.name) {
        return total + "and {ingredient.name}";
      }
      return total + "{ingredient.name}, ";
    });

    return stringIngredients;
  }
}

class StarbucksCoffeeDecorator implements Beverage {
  final Beverage _coffee = Coffee();
  
  @override
  double get cost => _coffee.cost * 5;
  
  @override
  String get ingredients => _coffee.ingredients;
}

void main() {
  var coffee = Coffee();
  var starbucksCoffee = StarbucksCoffeeDecorator();

  print("Coffee contains {coffee.ingredients}. It costs {coffee.cost}");
  print("Starbucks coffee contains {starbucksCoffee.ingredients}. It costs {starbucksCoffee.cost}");

  // Coffee contains coffee, milk, and sugar. It costs 0.85
  // Starbucks coffee contains coffee, milk, and sugar. It costs 4.25
}''',
'''class Grinder {
  String _type;

  Grinder(this._type);

  void grind() {
    print("Grinding _type!");
  }
}

class Maker {
  String _type;

  Maker(this._type);

  void fill() {
    print("Filling the _type maker!");
  }

  void retrieve() {
    print("Retrieving the _type!");
  }

  void start() {
    print("Starting the _type maker!");
  }
}

class Imbiber {
  String _beverage;

  Imbiber(this._beverage);

  void drink() {
    print("Mmmmm...drinking _beverage!");
  }
}

class MorningFacade {
  final _coffeeDrinker = Imbiber("coffee");
  final _coffeeGrinder = Grinder("coffee beans");
  final _coffeeMaker = Maker("coffee");

  void prepareCoffee() {
    print("rnPreparing the coffee...");
    _coffeeGrinder.grind();
    _coffeeMaker
        ..fill()
        ..start();
    print("Coffee is brewing!rn");
  }

  void drinkCoffee() {
    print("rnMust...have...coffee...");
    _coffeeMaker.retrieve();
    _coffeeDrinker.drink();
    print("This is damn fine coffee!");
  }
}

void main() {
  var typicalMorning = MorningFacade();

  print("Wake up! Grab a brush and put on a little makeup...");
  print("rnStumble to the kitchen...");

  typicalMorning.prepareCoffee();

  print("Oh my...that smells good...");

  typicalMorning.drinkCoffee();

  print("rnI'm ready to attack the day!");
}''',
'''class Volume {
  final int quantity;
  final String unit;

  Volume(this.quantity, this.unit);
  String toString() => "quantity unit";
}

abstract class Vessel {
  Volume volume;
  String liquid;
}

class Bucket extends Vessel {
  final Volume volume;

  Bucket(int q, String u) : volume = Volume(q, u);
  String toString() => "a volume bucket full of liquid";
}

class Cup extends Vessel {
 final Volume volume;

  Cup(int q, String u) : volume = Volume(q, u);
  String toString() => "a volume cup full of liquid";
}

enum Tiredness {
  rested, sleepy, barelyAlive, hasChildren
}

class CoffeeVesselFactory {
  static Vessel vesselFor(Tiredness howTired) {
    Vessel vessel;
    switch(howTired) {
      case Tiredness.rested: vessel = Cup(100, "milliliter"); break;
      case Tiredness.sleepy:
      case Tiredness.barelyAlive: vessel = Cup(500, "milliliter"); break;
      case Tiredness.hasChildren: vessel = Bucket(5, "liter"); break;
      default: vessel = Cup(200, "milliliter"); break;
    }
    vessel.liquid = "coffee";
    return vessel;
  }
}

void main() {
  var sleepyVessel = CoffeeVesselFactory.vesselFor(Tiredness.sleepy);
  var kidVessel = CoffeeVesselFactory.vesselFor(Tiredness.hasChildren);

  // A sleepy person would like a 500 milliliter cup full of coffee.
  print("A sleepy person would like sleepyVessel.");
  // A person with children NEEDS a 5 liter bucket full of coffee.
  print("A person with children NEEDS kidVessel.");
}''','''import "dart:collection";

class Letter {
  String letter;
  Letter(String l) {
    if (l.length != 1) { throw new Exception("Can only be a single letter"); }
    letter = l;
  }

  @override
  String toString() => letter;
}

class Sentence {
  List<Letter> letters = [];
  void addLetter(Letter letter) => letters.add(letter);

  @override
  String toString() => letters.join("");
}

class LetterFactory {
  Map<String, Letter> letters = {};

  Letter fetchLetter(String l) {
    if (letters.containsKey(l)) { return letters[l]; }
    var letter = Letter(l);
    letters[l] = letter;
    return letter;
  }

  int get lettersCreated => letters.length;
}

class Document {
  LetterFactory letterFactory = LetterFactory();
  int lettersWritten = 0;
  SplayTreeMap<int, Sentence> sentences;

  Document() {
    sentences = new SplayTreeMap<int, Sentence>();
  }

  void export() => sentences.forEach((k, v) => print("v"));

  void write(int sentenceKey, String letterString) {
    if (!sentences.containsKey(sentenceKey)) {
      sentences[sentenceKey] = Sentence();
    }

    var l = letterFactory.fetchLetter(letterString);
    sentences[sentenceKey].addLetter(l);
    lettersWritten++;
  }

  int get lettersCreated => letterFactory.lettersCreated;
}

void main() {
  var doc = Document();

  doc.write(6, "t");
  doc.write(7, "u");
  doc.write(1, "A");
  doc.write(2, "y");
  doc.write(7, "s");
  doc.write(3, "b");
  doc.write(2, "o");
  doc.write(3, "a");
  doc.write(2, "u");
  doc.write(1, "l");
  doc.write(3, "s");
  doc.write(3, "e");
  doc.write(4, "a");
  doc.write(1, "l");
  doc.write(2, "r");
  doc.write(5, "b");
  doc.write(5, "e");
  doc.write(5, "l");
  doc.write(5, "o");
  doc.write(4, "r");
  doc.write(5, "n");
  doc.write(4, "e");
  doc.write(6, "o");
  doc.write(5, "g");

  doc.export();

  print("rnDocument wrote: {doc.lettersWritten}.");
  print("Letters created: {doc.lettersCreated}.");

  /*
    All
    your
    base
    are
    belong
    to
    us

    Document wrote: 24.
    Letters created: 13.
  */
}''',
'''abstract class Expression {
  Number number;
  void interpret(int value);
}

class Add implements Expression {
  Number number;
  Add(this.number);
  void interpret(int value) {
    print("Adding value...");
    number.value += value;
  }
}

class Subtract implements Expression {
  Number number;
  Subtract(this.number);
  void interpret(int value) {
    print("Subtracting value...");
    number.value -= value;
  }
}

class Number {
  int value;
  Number(int value) {
    print("Starting with value...");
    this.value = value;
  }
}

void main() {
  var number = Number(0);
  var adder = Add(number);
  var subtracter = Subtract(number);

  adder.interpret(100);
  subtracter.interpret(60);
  adder.interpret(2);

  assert(number.value == 42);
  print("And the result is {number.value}!");
}''','''// NOTE: See https://api.dartlang.org/stable/2.4.0/dart-core/Iterator-class.html
// for details on Dart's Iterator class.

class RainbowIterator implements Iterator {
  var _colors = ["Red", "Orange", "Yellow", "Green", "Blue", "Indigo", "Violet"];
  var _index = 0;
  String get current => _colors[_index++];
  bool moveNext() => _index < _colors.length;
}

void main() {
  var rainbowColors = RainbowIterator();
  while(rainbowColors.moveNext()) {
    print(rainbowColors.current);
  }

  /*
    Red
    Orange
    Yellow
    Green
    Blue
    Indigo
    Violet
  */
}''',
'''abstract class Stateful {
  String _state;
  String get state => _state;
  void set state(String newState) => _state = newState;
}

class Mediator {
  List<Stateful> _parties;
  Mediator(this._parties);
  void update(String state) {
    for (var party in _parties) {
      party.state = state;
    }
  }
}

class Attendee extends Stateful {
  String name;
  Attendee(this.name);
}

void main() {
  var curly = Attendee("Curly");
  var larry = Attendee("Larry");
  var moe = Attendee("I prefer not to disclose my name");
  var mixer = List<Attendee>.from([curly, larry, moe]);
  var publicAnnouncementSystem = Mediator(mixer);

  publicAnnouncementSystem.update("Do NOT eat the shrip tacos!");

  for (var person in mixer) {
    print("{person.name} heard "{person.state}".");
  }

  /*
    Curly heard "Do NOT eat the shrip tacos!".
    Larry heard "Do NOT eat the shrip tacos!".
    I prefer not to disclose my name heard "Do NOT eat the shrip tacos!".
  */
}''','''class Memento {
  String _state;

  Memento(String s) {
    _state = s;
    print("[Memento] State "s" has been saved!");
  }

  String get state {
    print("[Memento] Providing saved state "_state"...");
    return _state;
  }
}

class Originator {
  String _state;

  // NOTE: This uses the state setter on init to get a handy print
  Originator(String s) {
    state = s;
  }

  String get state => _state;
  void set state(String newState) {
    _state = newState;
    print("[Originator] Set state to newState");
  }

  Memento saveToMemento() {
    print("[Originator] Saving to memento...");
    return Memento(state);
  }

  void restoreFromMemento(Memento m) {
    print("[Originator] Restoring from memento...");
    _state = m.state;
    print("[Originator] Restored to state.");
  }
}

class CareTaker {
  Memento memento;
}

void main() {
  var me = Originator("Returned from store");
  me.state = "Placing car keys down";

  var locationOfKeys = me.saveToMemento();
  var memory = CareTaker();
  memory.memento = locationOfKeys;

  me.state = "Putting away groceries";
  me.state = "Noticed missing pickles";
  me.state = "Looking for car keys...";

  me.restoreFromMemento(memory.memento);
  me.state = "Going back to store for pickles";

  /*
    [Originator] Set state to Returned from store
    [Originator] Set state to Placing car keys down
    [Originator] Saving to memento...
    [Memento] State "Placing car keys down" has been saved!
    [Originator] Set state to Putting away groceries
    [Originator] Set state to Noticed missing pickles
    [Originator] Set state to Looking for car keys...
    [Originator] Restoring from memento...
    [Memento] Providing saved state "Placing car keys down"...
    [Originator] Restored to Placing car keys down.
    [Originator] Set state to Going back to store for pickles
  */
}''',
'''class Notification {
  String message;
  DateTime timestamp;
  Notification(this.message, this.timestamp);
  Notification.forNow(this.message) {
    timestamp = new DateTime.now();
  }
}

class Observable {
  List<Observer> _observers;

  Observable([List<Observer> observers]) {
    _observers = observers ?? [];
  }

  void registerObserver(Observer observer) {
    _observers.add(observer);
  }

  void notify_observers(Notification notification) {
    for (var observer in _observers) {
      observer.notify(notification);
    }
  }
}

class Observer {
  String name;
  
  Observer(this.name);

  void notify(Notification notification) {
    print("[{notification.timestamp.toIso8601String()}] Hey name, {notification.message}!");
  }
}

class CoffeeMaker extends Observable {
  CoffeeMaker([List<Observer> observers]) : super(observers);
  void brew() {
    print("Brewing the coffee...");
    notify_observers(Notification.forNow("coffee's done"));
  }
}

void main() {
  var me = Observer("Tyler");
  var mrCoffee = CoffeeMaker(List.from([me]));
  var myWife = Observer("Kate");
  mrCoffee.registerObserver(myWife);
  mrCoffee.brew();
  /*
    Brewing the coffee...
    [2019-06-18T07:30:04.397518] Hey Tyler, coffee's done!
    [2019-06-18T07:30:04.397518] Hey Kate, coffee's done!
  */
}''','''abstract class Shape {
  int x;
  int y;
  Shape clone();
}

class Rectangle implements Shape {
  int height;
  int width;
  int x;
  int y;

  int _hashCode;
  bool isClone = false;
  String get cloneStatus => isClone ? "is a clone" : "is an original gangster";

  Rectangle(this.height, this.width, this.x, this.y);

  Rectangle.fromSource(Rectangle source) {
    height = source.height;
    width = source.width;
    x = source.x;
    y = source.y;
    _hashCode = source.hashCode;
    isClone = true;
  }

  @override
  Rectangle clone() {
    return Rectangle.fromSource(this);
  }

  @override
  int get hashCode {
    if (_hashCode != null) return _hashCode;
    _hashCode = DateTime.now().millisecondsSinceEpoch;
    return _hashCode;
  }

  @override
  bool operator ==(dynamic other) {
    if (other is! Rectangle) return false;
    Rectangle rect = other;
    return rect.isClone && rect.hashCode == hashCode;
  }
}

void main() {
  var ogRect = Rectangle(0, 0, 100, 100);
  var cloneRect = ogRect.clone();
  var someOtherRect = Rectangle(0, 0, 100, 100);

  print("ogRect {ogRect.cloneStatus}.");
  print("cloneRect {cloneRect.cloneStatus}.");
  print("someOtherRect {someOtherRect.cloneStatus}.");

  String cloneIsClone = ogRect == cloneRect ? "is a clone of" : "is not a clone of";
  print("rncloneRect cloneIsClone ogRect.");

  String someRectIsClone = ogRect == someOtherRect ? "is a clone of" : "is not a clone of";
  print("someOtherRect someRectIsClone ogRect.");

  /*
    ogRect is an original gangster.
    cloneRect is a clone.
    someOtherRect is an original gangster.

    cloneRect is a clone of ogRect.
    someOtherRect is not a clone of ogRect.
  */
}''','''abstract class Subject {
  void someMethod();
}

class ExpensiveClass implements Subject {
  String name;

  ExpensiveClass(this.name);

  void someMethod() {
    print("someMethod of name (an ExpensiveClass) is being called");
  }
}

class Proxy implements Subject {
  String _name;
  ExpensiveClass _sub;

  Proxy(this._name);

  void someMethod() {
    print("someMethod of _name (a Proxy) is being called");
    _subject().someMethod();
  }

  ExpensiveClass _subject() {
    if (_sub != null) return _sub;
    print("Creating an instance of ExpensiveClass for the proxy...");
    _sub = ExpensiveClass(_name);
    return _sub;
  }
}

void main() {
  var proxy = Proxy("yay");
  print("With our handy proxy, we call someMethod...rn");
  proxy.someMethod();
  print("rnNotice that the proxy did not have an instance of ExpensiveClass, so it made one when required.");
  print("Now if we call someMethod again...rn");
  proxy.someMethod();
  print("rnWe reuse the instance we made above!");
}''','''class Me {
  static final Me _singleton = new Me._internal();
  static final String _name = "Tyler";

  factory Me() {
    return _singleton;
  }

  static String get name => _name;
 
  @override
  String toString() => "Hello, my name is name.";

  Me._internal();
}

void main() {
  var tyler = Me();
  var anotherTyler = Me();
  
  print(tyler);
  print(anotherTyler);

  var samenessCheck = identical(tyler, anotherTyler)
      ? "We are both the same {Me.name}."
      : "We are NOT the same. I mean, just look at us.";
  print(samenessCheck);

  /*
    Hello, my name is Tyler.
    Hello, my name is Tyler.
    We are both the same Tyler.
  */
}''','''abstract class State {
  void handler(Stateful context);
  String toString();
}

class StatusOn implements State {
  handler(Stateful context) {
    print("  Handler of StatusOn is being called!");
    context.state = StatusOff();
  }

  @override String toString() {
    return "on";
  }
}

class StatusOff implements State {
  handler(Stateful context) {
    print("  Handler of StatusOff is being called!");
    context.state = StatusOn();
  }

  @override String toString() {
    return "off";
  }
}

class Stateful {
  State _state;

  Stateful(this._state);

  State get state => _state;
  set state(State newState) => _state = newState;

  void touch() {
    print("  Touching the Stateful...");
    _state.handler(this);
  }
}

void main() {
  var lightSwitch = Stateful(StatusOff());
  print("The light switch is {lightSwitch.state}.");
  print("Toggling the light switch...");
  lightSwitch.touch();
  print("The light switch is {lightSwitch.state}.");
}''','''abstract class CoffeeStrategy {
String announce(String roast);
}

class AmericanoStrategy implements CoffeeStrategy {
String announce(String roast) => "an Americano with roast beans";
}

class DripStrategy implements CoffeeStrategy {
String announce(String roast) => "a drip coffee with roast beans";
}

class MochaFrappuccinoStrategy implements CoffeeStrategy {
String announce(String roast) => "a delicious mocha frappuccion with roast beans";
}

class CoffeeDrinker {
CoffeeStrategy preferredDrink;
String name;
CoffeeDrinker(this.name, this.preferredDrink);
}

void main() {
var americano = AmericanoStrategy();
var drip = DripStrategy();
var mocha = MochaFrappuccinoStrategy();

var me = CoffeeDrinker("Tyler", drip);
var europeanBuddy = CoffeeDrinker("Pieter", americano);
var myDaughter = CoffeeDrinker("Joanie", mocha);

final String roastOfTheDay = "Italian";

for (var person in [me, europeanBuddy, myDaughter]) {
  print("Hey {person.name}, whatcha drinkin' over there?");
  print("I'm enjoying {person.preferredDrink.announce(roastOfTheDay)}!rn");
}

/*
  Hey Tyler, whatcha drinkin' over there?
  I'm enjoying a drip coffee with Italian beans!

  Hey Pieter, whatcha drinkin' over there?
  I'm enjoying an Americano with Italian beans!

  Hey Joanie, whatcha drinkin' over there?
  I'm enjoying a delicious mocha frappuccion with Italian beans!
*/
}''','''abstract class Abstract {
  String abstractMethod();
  String hookMethod() => "OMG I am a hook!";
  void templateMethod() {
    print(abstractMethod());
    print(hookMethod());
  }
}

class Concrete extends Abstract {
  String abstractMethod() => "This is a boring example...";
}

class ConcreteOverridingHook extends Abstract {
  String abstractMethod() => "So, so boring...";
  @override
  String hookMethod() => "I'm an overriden hook method!";
}

void main() {
  var con1 = Concrete();
  var con2 = ConcreteOverridingHook();
  con1.templateMethod();
  con2.templateMethod();

  /*
    This is a boring example...
    OMG I am a hook!
    So, so boring...
    I'm an overriden hook method!
  */
}''','''abstract class BodyPart {
  String name;
  void accept(BodyPartVisitor visitor) => visitor.visit(this);
}

abstract class BodyPartVisitor {
  void visit(BodyPart bodyPart);
}

class Face extends BodyPart {
  String name = "Face";
}

class Finger extends BodyPart {
  String name = "Finger";
  Finger(this.name);
}

class Foot extends BodyPart {
  String name = "Foot";
  Foot(this.name);
}

class Body implements BodyPart {
  String name = "Body";
  List<BodyPart> bodyParts;

  Body() {
    bodyParts = List.from([
      Face(), Finger("Index Finger"), Finger("Thumb"),
      Foot("Left Foot"), Foot("Right Foot"), Foot("Third Foot?")
    ]);
  }

  @override
  void accept(BodyPartVisitor visitor) {
    for (var bodyPart in bodyParts) {
      bodyPart.accept(visitor);
    }
    visitor.visit(this);
  }
}

class BodyPartStitchVisitor implements BodyPartVisitor {
  void visit(BodyPart bodyPart) {
    if (bodyPart is Body) { print("Reanimating my {bodyPart.name}."); }
    if (bodyPart is Face) { print("Stitching together my {bodyPart.name}."); }
    if (bodyPart is Finger) { print("Stitching together my {bodyPart.name}."); }
    if (bodyPart is Foot) { print("Gluing on my {bodyPart.name}."); }
  }
}

class BodyPartProdVisitor implements BodyPartVisitor {
void visit(BodyPart bodyPart) {
    if (bodyPart is Body) { print("Poking my {bodyPart.name} with an electrode."); }
    if (bodyPart is Face) { print("Prodding {bodyPart.name}."); }
    if (bodyPart is Finger) { print("Pricking {bodyPart.name}."); }
    if (bodyPart is Foot) { print("Tickling {bodyPart.name}."); }
  }
}

void main() {
  var body = Body();
  body.accept(BodyPartStitchVisitor());
  body.accept(BodyPartProdVisitor());

  /*
    Stitching together my Face.
    Stitching together my Index Finger.
    Stitching together my Thumb.
    Gluing on my Left Foot.
    Gluing on my Right Foot.
    Gluing on my Third Foot?.
    Reanimating my Body.
    Prodding Face.
    Pricking Index Finger.
    Pricking Thumb.
    Tickling Left Foot.
    Tickling Right Foot.
    Tickling Third Foot?.
    Poking my Body with an electrode.
  */
}
''',

  ];
}
