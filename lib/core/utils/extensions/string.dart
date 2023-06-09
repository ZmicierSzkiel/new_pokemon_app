extension StringExtension on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';

  String toTitleCase() => split(' ').map((item) => item.capitalize()).join(' ');

  int toInt() {
    try {
      return int.parse(this);
    } catch (e) {
      return -1;
    }
  }
}
