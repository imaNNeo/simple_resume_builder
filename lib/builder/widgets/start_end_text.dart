import 'package:pdf/widgets.dart' as pw;

class StartEndText extends pw.StatelessWidget {
  final String start;
  final String end;
  final pw.TextStyle textStyle;
  final bool showDuration;

  static const _monthNames = {
    'Jan': 1,
    'Feb': 2,
    'Mar': 3,
    'Apr': 4,
    'May': 5,
    'Jun': 6,
    'Jul': 7,
    'Aug': 8,
    'Sep': 9,
    'Oct': 10,
    'Nov': 11,
    'Dec': 12
  };

  StartEndText({
    required this.start,
    required this.end,
    required this.textStyle,
    this.showDuration = true,
  });

  DateTime _parseDate(String date) {
    if (date == 'Present') {
      return DateTime.now();
    }
    final parts = date.split(' ');
    final month = _monthNames[parts[0]]!;
    final year = int.parse(parts[1]);
    return DateTime(year, month);
  }

  String _formatDiff(DateTime start, DateTime end) {
    int years = _addOneMonth(end).year - start.year;
    int months = _addOneMonth(end).month - start.month;

    // Adjust years and months if necessary
    if (months < 0) {
      years--;
      months += 12; // Borrowing 12 months from a year
    }

    // Format the string based on years and months
    if (years > 0 && months > 0) {
      return '$years years $months months';
    } else if (years > 0) {
      return years == 1 ? '1 year' : '$years years';
    } else if (months > 0) {
      return months == 1 ? '1 month' : '$months months';
    } else {
      return '0 months';
    }
  }

  DateTime _addOneMonth(DateTime original) {
    // Check if adding a month rolls over to next year
    int newMonth = original.month + 1;
    int newYear = original.year;
    if (newMonth > 12) {
      newMonth = 1;
      newYear++;
    }

    // Attempt to keep the same day of the month
    int newDay = original.day;
    int maxDays = _daysInMonth(newYear, newMonth);
    if (newDay > maxDays) {
      newDay = maxDays;
    }

    return DateTime(newYear, newMonth, newDay);
  }

  int _daysInMonth(int year, int month) {
    // Handle February in a leap year
    if (month == 2) {
      bool isLeapYear = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
      return isLeapYear ? 29 : 28;
    }

    // All other months
    const monthLengths = [31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return monthLengths[month - 1];
  }

  @override
  pw.Widget build(pw.Context context) {
    String text = '$start - $end';
    if (showDuration) {
      text += ' (${_formatDiff(_parseDate(start), _parseDate(end))})';
    }
    return pw.Text(
      text,
      style: textStyle,
    );
  }
}
