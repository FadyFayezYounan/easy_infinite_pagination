import 'dart:async' show Timer;
import 'dart:ui';

/// A class that debounces the execution of a callback function.
///
/// This is useful for cases where you want to delay the execution of a function
/// until a certain amount of time has passed since the last time it was called.
class Debouncer {
  /// The delay after the last invocation of the callback function before it is executed.
  final Duration _delay;

  /// A timer that is used to delay the execution of the callback function.
  Timer? _timer;

  /// Creates a new debouncer with the specified delay.
  ///
  /// The [delay] parameter specifies the duration to wait before executing the callback function.
  Debouncer(this._delay);

  /// Creates a new debouncer with a zero delay.
  ///
  /// This is useful for cases where you want to execute the callback function immediately.
  Debouncer.zero() : _delay = Duration.zero;

  /// Executes the callback function after the specified delay.
  ///
  /// If the debouncer has a non-zero delay, the callback function will be executed after the specified delay has passed
  /// since the last time it was called.
  /// If the debouncer has a zero delay, the callback function will be executed immediately.
  void run(VoidCallback computation) {
    if (_delay == Duration.zero) {
      // If the delay is zero, execute the callback function immediately.
      computation();
    } else {
      // If the delay is non-zero, cancel the previous timer and create a new one.
      _timer?.cancel();
      _timer = Timer(_delay, computation);
    }
  }

  /// Cancels the timer that is used to delay the execution of the callback function.
  ///
  /// This method should be called when the debouncer is no longer needed to prevent memory leaks.
  void dispose() {
    _timer?.cancel();
  }
}
