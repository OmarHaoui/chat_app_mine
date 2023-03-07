String timePassed(latestTime, String timeString) {
  DateTime now = DateTime.now();
  if (latestTime != null) {
    Duration difference = now.difference(latestTime);
    if (difference.inSeconds < 60) {
      timeString = "${difference.inSeconds} seconds ago";
    } else if (difference.inMinutes < 60) {
      timeString = "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      timeString = "${difference.inHours} hours ago";
    } else {
      timeString = "${difference.inDays} days ago";
    }
  }
  return timeString;
}
