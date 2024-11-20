import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/weather/viewmodel/weather_viewmodel.dart';
import 'package:meteo_app_notification/weather/data/models/search_city_model.dart';

class CustomSearchInput extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(SearchCityModel)? onCitySelected;
  final VoidCallback? onLeadingIconTap;

  const CustomSearchInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.onCitySelected,
    this.onLeadingIconTap,
  });

  @override
  _CustomSearchInputState createState() => _CustomSearchInputState();
}

class _CustomSearchInputState extends ConsumerState<CustomSearchInput> {
  Timer? _debounce;
  List<SearchCityModel> _searchResults = [];
  bool _isLoading = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
    _focusNode = FocusNode();
  }

  void _onTextChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final query = widget.controller.text.trim();
      if (query.isNotEmpty) {
        setState(() {
          _isLoading = true;
        });
        try {
          final results = await ref
              .read(weatherViewModelProvider.notifier)
              .searchCities(query);

          setState(() {
            _searchResults = results;
            _isLoading = false;
          });
        } catch (e) {
          setState(() {
            _searchResults = [];
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _searchResults = [];
        });
      }
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _debounce?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              if (widget.onLeadingIconTap != null)
                GestureDetector(
                  onTap: widget.onLeadingIconTap,
                  child: Icon(
                    Icons.location_on_rounded,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.8),
                  ),
                ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.8),
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Center(child: CircularProgressIndicator()),
          ),
        if (_searchResults.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final city = _searchResults[index];
                String title = '';
                final name = city.name;
                final region = city.region;
                final country = city.country;

                title = [
                  if (name.isNotEmpty) name,
                  if (region.isNotEmpty) region,
                  if (country.isNotEmpty) country,
                ].join(', ');
                return ListTile(
                  title: Text(
                    title,
                  ),
                  onTap: () {
                    widget.onCitySelected?.call(city);
                    setState(() {
                      _searchResults = [];
                      widget.controller.clear();
                      _focusNode.unfocus();
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
