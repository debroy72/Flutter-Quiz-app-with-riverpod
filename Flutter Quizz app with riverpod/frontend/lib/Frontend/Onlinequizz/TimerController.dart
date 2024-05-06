import 'dart:async';

class TimerController {
  final int duration;
  Function(bool isDone)? onTick;
  Timer? _timer;
  double _progress = 0.0;

  TimerController({required this.duration, this.onTick});

  double get progress => _progress;

  void startTimer() {
    _progress = 0.0;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _progress += 1 / duration;
      if (_progress >= 1) {
        _timer?.cancel();
        _progress = 1.0;
        if (onTick != null) onTick!(true);
      } else {
        if (onTick != null) onTick!(false);
      }
    });
  }

  void reset() {
    stopTimer();
    _progress = 0.0;
    startTimer();
  }

  void stopTimer() {
    _timer?.cancel();
  }
}