import 'package:iscad/core/observer/updater.dart';

class QuntityObserver {
  final Function(int quntity, String id)? updatequntity;

  QuntityObserver({required this.updatequntity}) {
    QuntityUpdater.instance.attachObserver(this);
  }

  dispose() {
    QuntityUpdater.instance.deAttachObserver(this);
  }
}
