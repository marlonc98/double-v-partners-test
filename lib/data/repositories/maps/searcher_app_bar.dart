import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearcherAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(String) onSearch;
  final String? defaultSearch;
  final String title;
  final bool waitSearch;

  const SearcherAppBar(
      {super.key,
      required this.title,
      this.defaultSearch,
      required this.onSearch,
      this.waitSearch = false});

  @override
  SearcherAppBarState createState() => SearcherAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SearcherAppBarState extends State<SearcherAppBar> {
  bool searching = false;
  final TextEditingController _textController = TextEditingController();
  Timer? _debounce;

  void _onKeyDownSearch(String? val) {
    if (widget.waitSearch) {
      if (val == null) {
        return;
      }
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () async {
        await widget.onSearch.call(val);
      });
    } else {
      widget.onSearch.call(val ?? "");
    }
  }

  void toogleSearch(bool value) {
    setState(() {
      searching = value;
    });
  }

  @override
  void initState() {
    _textController.text = widget.defaultSearch ?? "";
    searching = widget.defaultSearch != null;
    super.initState();
  }

  @override
  SliverAppBar build(BuildContext context) {
    return SliverAppBar(
        floating: true,
        snap: true,
        title: searching
            ? Row(
                children: [
                  Expanded(
                      child: CupertinoSearchTextField(
                    padding: const EdgeInsets.all(12),
                    controller: _textController,
                    onChanged: _onKeyDownSearch,
                    onSubmitted: widget.onSearch,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  )),
                  IconButton(
                      onPressed: () => toogleSearch(false),
                      icon: const Icon(Icons.close))
                ],
              )
            : Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                      onPressed: () => toogleSearch(true),
                      icon: const Icon(Icons.search))
                ],
              ));
  }
}
