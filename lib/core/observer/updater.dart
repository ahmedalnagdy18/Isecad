import 'package:iscad/core/observer/observer.dart';

class PostUpdater {
  static final PostUpdater instance = PostUpdater._();

  PostUpdater._();

  final List<PostObserver> _observers = [];

  void attachObserver(PostObserver observer) {
    _observers.add(observer);
  }

  void deAttachObserver(PostObserver observer) {
    _observers.remove(observer);
  }

  void notifyLikeUpdate(int quntity, String id) {
    for (var observer in _observers) {
      if (observer.updatequntity != null) {
        observer.updatequntity!(quntity, id);
      }
    }
  }
}
