import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../models/parking_spot.dart';
import '../../models/parking_slot.dart';
import '../payment/payment_screen.dart';

/// Select booking time screen with calendar, time pickers, duration chips
/// Matches reference: select_booking_time/screen.png
const List<String> _popularDurations = [
  '1 hr',
  '2 hrs',
  '4 hrs',
  '6 hrs',
  '12 hrs',
  '1 day',
];

class SelectBookingTimeScreen extends StatefulWidget {
  final ParkingSpot spot;
  final ParkingSlot selectedSlot;

  const SelectBookingTimeScreen({
    super.key,
    required this.spot,
    required this.selectedSlot,
  });

  @override
  State<SelectBookingTimeScreen> createState() =>
      _SelectBookingTimeScreenState();
}

class _SelectBookingTimeScreenState extends State<SelectBookingTimeScreen> {
  // Calendar state
  late DateTime _currentMonth;
  late int _selectedDay;
  int _selectedDurationIndex = 1; // Default to 2 hrs

  // Time state
  late TimeOfDay _startTimeTod;
  late TimeOfDay _endTimeTod;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _currentMonth = DateTime(now.year, now.month);
    _selectedDay = now.day;
    _startTimeTod = TimeOfDay(hour: (now.hour + 1) % 24, minute: 0);
    _endTimeTod = TimeOfDay(hour: (now.hour + 3) % 24, minute: 0);
  }

  double _calculateDurationInHours() {
    final double start = _startTimeTod.hour + _startTimeTod.minute / 60.0;
    double end = _endTimeTod.hour + _endTimeTod.minute / 60.0;

    if (end <= start) {
      // Assume next day if end is before/equal start
      end += 24.0;
    }

    return end - start;
  }

  void _updateEndTimeFromDuration(double hours) {
    final startTimeInMinutes = _startTimeTod.hour * 60 + _startTimeTod.minute;
    final endTimeInMinutes = (startTimeInMinutes + (hours * 60)).toInt();

    setState(() {
      _endTimeTod = TimeOfDay(
        hour: (endTimeInMinutes ~/ 60) % 24,
        minute: endTimeInMinutes % 60,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final spot = widget.spot;

    final selectedDuration = _calculateDurationInHours();
    final calculatedPrice = spot.pricePerHour * selectedDuration;
    final estimatedPrice = calculatedPrice < 10.0 ? 10.0 : calculatedPrice;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 20, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back,
                          color: AppColors.textPrimary, size: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      AppStrings.selectBookingTime,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48), // Balance the back button
                ],
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // SELECT DATE section
                    _buildSectionLabel(AppStrings.selectDate),
                    const SizedBox(height: 8),

                    // Month navigation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentMonth = DateTime(
                                _currentMonth.year,
                                _currentMonth.month - 1,
                              );
                            });
                          },
                          child: const Icon(Icons.chevron_left,
                              color: AppColors.primary),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _getMonthYear(),
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentMonth = DateTime(
                                _currentMonth.year,
                                _currentMonth.month + 1,
                              );
                            });
                          },
                          child: const Icon(Icons.chevron_right,
                              color: AppColors.primary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Day headers
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:
                          ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN']
                              .map((d) => SizedBox(
                                    width: 40,
                                    child: Text(
                                      d,
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textHint,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ))
                              .toList(),
                    ),
                    const SizedBox(height: 8),

                    // Calendar grid
                    _buildCalendarGrid(),
                    const SizedBox(height: 28),

                    // SET TIME section
                    _buildSectionLabel(AppStrings.setTime),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        // Start time
                        Expanded(
                          child: _buildTimeSelector(
                            label: AppStrings.startTime,
                            value: _startTimeTod.format(context),
                            onTap: () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: _startTimeTod,
                              );
                              if (time != null) {
                                setState(() {
                                  _startTimeTod = time;
                                  _selectedDurationIndex = -1; // Deselect popular durations
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        // End time
                        Expanded(
                          child: _buildTimeSelector(
                            label: AppStrings.endTime,
                            value: _endTimeTod.format(context),
                            onTap: () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: _endTimeTod,
                              );
                              if (time != null) {
                                setState(() {
                                  _endTimeTod = time;
                                  _selectedDurationIndex = -1; // Deselect popular durations
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // POPULAR DURATIONS
                    _buildSectionLabel(AppStrings.popularDurations),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 44,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _popularDurations.length,
                        itemBuilder: (context, index) {
                          final isSelected = _selectedDurationIndex == index;
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedDurationIndex = index;
                                  final durationValues = [1.0, 2.0, 4.0, 6.0, 12.0, 24.0];
                                  _updateEndTimeFromDuration(durationValues[index]);
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.cardBorder,
                                  ),
                                ),
                                child: Text(
                                  _popularDurations[index],
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Location preview card
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xFFE0F2F1),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          children: [
                            // Map bg
                            CustomPaint(
                              size: const Size(double.infinity, 100),
                              painter: _MiniMapPainter(),
                            ),
                            // Location info overlay
                            Positioned(
                              bottom: 12,
                              left: 12,
                              child: Row(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Text('P',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'LOCATION',
                                        style: GoogleFonts.poppins(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      Text(
                                        spot.name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Duration + Price summary
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.totalDuration,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${selectedDuration.floor()} hours ${( (selectedDuration - selectedDuration.floor()) * 60).toInt()} mins',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              AppStrings.estimatedPrice,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\u20B9${estimatedPrice.toStringAsFixed(2)}',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Continue to Payment button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PaymentScreen(
                                spot: spot,
                                selectedSlot: widget.selectedSlot,
                                duration: selectedDuration,
                                totalPrice: estimatedPrice,
                                startTime: DateTime(
                                  _currentMonth.year,
                                  _currentMonth.month,
                                  _selectedDay,
                                  _startTimeTod.hour,
                                  _startTimeTod.minute,
                                ),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.continueToPayment,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward, size: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Free cancellation note
                    Center(
                      child: Text(
                        AppStrings.freeCancellation,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.textHint,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildTimeSelector({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppColors.textHint,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.cardBorder),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down,
                    color: AppColors.primary, size: 22),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getMonthYear() {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${months[_currentMonth.month - 1]} ${_currentMonth.year}';
  }

  Widget _buildCalendarGrid() {
    // Get first day of month and total days
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    // Monday = 1, Sunday = 7
    final startWeekday = firstDay.weekday; // 1=Mon

    final List<Widget> rows = [];
    List<Widget> currentRow = [];

    // Empty cells before first day
    for (int i = 1; i < startWeekday; i++) {
      currentRow.add(const SizedBox(width: 40, height: 40));
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final isSelected = day == _selectedDay;
      currentRow.add(
        GestureDetector(
          onTap: () => setState(() => _selectedDay = day),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$day',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ),
      );

      if ((startWeekday - 1 + day) % 7 == 0 || day == daysInMonth) {
        // Fill remaining cells in last row
        while (currentRow.length < 7) {
          currentRow.add(const SizedBox(width: 40, height: 40));
        }
        rows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: currentRow,
          ),
        );
        currentRow = [];
      }
    }

    return Column(children: rows);
  }
}

/// Mini map painter for location preview
class _MiniMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFF80CBC4);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final roadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(0, size.height * 0.5),
        Offset(size.width, size.height * 0.5), roadPaint);
    canvas.drawLine(Offset(size.width * 0.3, 0),
        Offset(size.width * 0.3, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.7, 0),
        Offset(size.width * 0.7, size.height), roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
