import 'dart:async';

class TimerController {
  Timer? _timer;
  Function? onTick;
  double progress = 0.0;
  final int duration;

  TimerController({required this.duration, this.onTick});

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer?.cancel();
    progress = 0.0;

    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (progress >= 1) {
        // Timer is complete
        _timer?.cancel();
        if (onTick != null) {
          onTick!(true);
        }
      } else {
        progress += 1 / duration;
        if (onTick != null) {
          onTick!(false);
        }
      }
    });
  }

  void reset() {
    stopTimer();
    startTimer();
  }

  void stopTimer() {
    _timer?.cancel();
  }
}
