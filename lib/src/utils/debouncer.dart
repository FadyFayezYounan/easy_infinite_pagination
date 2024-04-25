import 'dart:async' show Timer;
import 'dart:ui';

/// `Debouncer` is a utility class provided by the package. It's used to delay
/// execution of a function. This is useful in situations where the function
/// is called multiple times in a short period of time and we want to execute
/// the function only once after the delay has passed.
class Debouncer {
  /// The delay after the last invocation of the callback function before it is executed.
  final Duration _delay;

  /// A timer that is used to delay the execution of the callback function.
  Timer? _timer;

  /// Creates a new debouncer with the specified delay.
  ///
  /// The [delay] parameter specifies the duration to wait before executing the callback function.
  Debouncer(this._delay);

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
