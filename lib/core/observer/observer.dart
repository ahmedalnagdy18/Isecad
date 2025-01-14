import 'package:iscad/core/observer/updater.dart';

class PostObserver {
  final Function(int quntity, String id)? updatequntity;

  PostObserver({required this.updatequntity}) {
    PostUpdater.instance.attachObserver(this);
  }

  dispose() {
    PostUpdater.instance.deAttachObserver(this);
  }
}
