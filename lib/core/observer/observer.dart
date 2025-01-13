import 'package:iscad/core/observer/updater.dart';

class PostObserver {
  final Function(int quntity)? updatequntity;

  PostObserver({required this.updatequntity}) {
    PostUpdater.instance.attachObserver(this);
  }

  dispose() {
    PostUpdater.instance.deAttachObserver(this);
  }
}
