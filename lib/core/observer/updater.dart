import 'package:iscad/core/observer/observer.dart';

class QuntityUpdater {
  static final QuntityUpdater instance = QuntityUpdater._();

  QuntityUpdater._();

  final List<QuntityObserver> _observers = [];

  void attachObserver(QuntityObserver observer) {
    _observers.add(observer);
  }

  void deAttachObserver(QuntityObserver observer) {
    _observers.remove(observer);
  }

  void notifyQuntityUpdate(int quntity, String id) {
    for (var observer in _observers) {
      if (observer.updatequntity != null) {
        observer.updatequntity!(quntity, id);
      }
    }
  }
}
