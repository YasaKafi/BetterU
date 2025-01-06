import 'package:flutter/material.dart';

import '../../../../common/theme.dart';

class HistoryActivities extends StatefulWidget {
  const HistoryActivities({super.key});

  @override
  State<HistoryActivities> createState() => _HistoryActivitiesState();
}

class _HistoryActivitiesState extends State<HistoryActivities> {
  String? selectedFilterDate;

  final List<String> filterDate = ['3 Hari', '7 Hari', '14 Hari', '30 Hari'];

  Widget buildCustomDropdown({
    required List<String> options,
    required String hintText,
    String? selectedValue,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(12),
      ),
      width: MediaQuery.of(context).size.width * 0.25,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: baseColor,
          value: selectedValue,
          borderRadius: BorderRadius.circular(12),
          isExpanded: true,
          hint: Text(hintText,
              style: txtSecondaryTitle.copyWith(
                  fontWeight: FontWeight.w600, color: blackColor)),
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: txtSecondaryTitle.copyWith(
                      fontWeight: FontWeight.w600, color: blackColor)),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              onChanged(value);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryColor2,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      'Riwayat Kegiatan',
                      style: txtSecondaryHeader.copyWith(
                          fontWeight: FontWeight.w700, color: blackColor),
                    ),
                    SizedBox(width: 40),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // History Activities
              Container(
                width: screenWidth,
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    buildCustomDropdown(
                        options: filterDate,
                        hintText: 'Filter',
                        selectedValue: selectedFilterDate,
                        onChanged: (value) {
                          setState(() {
                            selectedFilterDate = value;
                          });
                        }),

                    SizedBox(height: 30),

                    // History Activities List

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
