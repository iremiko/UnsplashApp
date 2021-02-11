class ListItem {}

class LoadingItem extends ListItem {}

class LoadingFailed extends ListItem {
  final dynamic error;
  LoadingFailed(this.error);
}