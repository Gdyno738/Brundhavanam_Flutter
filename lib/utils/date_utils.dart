class AppDateUtils {
  static String formatDate(DateTime date) {
    return "${date.day} "
        "${_month(date.month)} "
        "${date.year}";
  }

  static String _month(int month) {
    const months = [
      "Jan","Feb","Mar","Apr","May","Jun",
      "Jul","Aug","Sep","Oct","Nov","Dec"
    ];
    return months[month - 1];
  }
}
