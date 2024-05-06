import 'dart:async';

class TimerController {
  Timer? _timer;
  Function? onTick;
  double progress = 0.0;
  final int duration; // Duration in seconds for each question

  TimerController({required this.duration, this.onTick});

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer?.cancel(); // Cancel any existing timer
    progress = 0.0; // Reset progress

    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (progress >= 1) {
        // Timer is complete
        _timer?.cancel();
        if (onTick != null) {
          onTick!(true); // Inform listener that timer is done
        }
      } else {
        progress += 1 / duration; // Increment the progress
        if (onTick != null) {
          onTick!(false); // Inform listener that timer ticked
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
