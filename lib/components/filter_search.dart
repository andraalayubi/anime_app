import 'package:flutter/material.dart';

class AnimeFilter extends StatefulWidget {
  final Function(String? status, String? type, String? rating) onFilterChanged;

  const AnimeFilter({
    Key? key,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  _AnimeFilterState createState() => _AnimeFilterState();
}

class _AnimeFilterState extends State<AnimeFilter> {
  String? _selectedStatus;
  String? _selectedType;
  String? _selectedRating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildDropdownButton(
            'Status',
            ['Airing', 'Complete', 'Upcoming'],
            _selectedStatus,
            (value) {
              setState(() {
                _selectedStatus = value;
              });
              widget.onFilterChanged(_selectedStatus, _selectedType, _selectedRating);
            },
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: _buildDropdownButton(
            'Type',
            ['TV', 'Movie', 'OVA', 'Special', 'ONA', 'Music', 'PV', 'TV_special'],
            _selectedType,
            (value) {
              setState(() {
                _selectedType = value;
              });
              widget.onFilterChanged(_selectedStatus, _selectedType, _selectedRating);
            },
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: _buildDropdownButton(
            'Rating',
            ['G', 'PG', 'PG13', 'R', 'R17', 'RX'],
            _selectedRating,
            (value) {
              setState(() {
                _selectedRating = value;
              });
              widget.onFilterChanged(_selectedStatus, _selectedType, _selectedRating);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownButton(
    String label,
    List<String> items,
    String? selectedValue,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButton<String?>(
      value: selectedValue,
      hint: Text(label),
      onChanged: onChanged,
      items: items
          .map<DropdownMenuItem<String?>>((String value) {
            return DropdownMenuItem<String?>(
              value: value,
              child: Text(
                      value,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16.0,
                      ),
                    ),
            );
          })
          .toList(),
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 16.0,
      ),
      dropdownColor: Theme.of(context).colorScheme.primary,
      elevation: 8,
      underline: Container(
        height: 2,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}