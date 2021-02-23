import 'package:flutter/material.dart';
import '../../core/models/cats.dart';

class AdCategories extends StatefulWidget {
  final Function _callbackMainCats;
  final Function _callbackSubCats;
  final Function _callbackSubSubCats;
  final String existingMainCat;
  final String existingSubCat;
  final String existingSubSubCat;

  AdCategories(
    this._callbackMainCats,
    this._callbackSubCats,
    this._callbackSubSubCats, {
    this.existingMainCat,
    this.existingSubCat,
    this.existingSubSubCat,
  });

  @override
  _AdCategoriesState createState() => _AdCategoriesState();
}

class _AdCategoriesState extends State<AdCategories> {
  String _mainCat;
  String _subCat;
  String _subSubCat;
  List<String> _subCatsList;
  List<String> _subSubCatsList;

  @override
  void initState() {
    super.initState();
    _mainCat = widget.existingMainCat ?? null;
    _subCat = widget.existingSubCat ?? null;
    _subSubCat = widget.existingSubSubCat ?? null;
    if (_mainCat != null) {
      _subCatsList = Cats.getSubCategories(_mainCat);
      _buildSubItems();
    }
    if (_subCat != null) {
      _subSubCatsList = Cats.getSubSubCategories(_mainCat, _subCat);
      _buildSubSubItems();
    }
  }

  List<DropdownMenuItem<String>> _buildList(List<String> items) {
    if (items == null) {
      return [];
    }
    return items
        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
        .toList();
  }

  List<Widget> _buildItems() {
    var _mainCatsList = Cats.mainCategoriesOnly;
    return _buildList(_mainCatsList);
  }

  List<Widget> _buildSubItems() {
    return _buildList(_subCatsList);
  }

  List<Widget> _buildSubSubItems() {
    return _buildList(_subSubCatsList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        DropdownButtonFormField<String>(
          value: _mainCat,
          decoration: InputDecoration(labelText: 'Kies je winkel'),
          isDense: false,
          style: Theme.of(context).textTheme.bodyText2,
          onChanged: (String newValue) {
            var _list = Cats.getSubCategories(newValue);
            setState(() {
              _subCat = null;
              _subSubCat = null;
              _mainCat = newValue;
              _subCatsList = _list;
              _subSubCatsList = null;
            });
            widget._callbackMainCats(newValue);
            widget._callbackSubCats(null);
            widget._callbackSubSubCats(null);
          },
          items: _buildItems(),
        ),
        if (_mainCat != null)
          DropdownButtonFormField<String>(
            value: _subCat,
            isDense: false,
            style: Theme.of(context).textTheme.bodyText2,
            decoration: InputDecoration(labelText: 'Kies een afdeling'),
            onChanged: (String newValue) {
              var _list = Cats.getSubSubCategories(_mainCat, newValue);
              setState(() {
                _subSubCat = null;
                _subCat = newValue;
                _subSubCatsList = _list;
              });
              widget._callbackSubCats(newValue);
              widget._callbackSubSubCats(null);
            },
            items: _buildSubItems(),
          ),
        if (_subSubCatsList != null && _subSubCatsList.length > 0)
          DropdownButtonFormField<String>(
            items: _buildSubSubItems(),
            value: _subSubCat,
            style: Theme.of(context).textTheme.bodyText2,
            isDense: false,
            decoration: InputDecoration(labelText: 'Kies een sectie'),
            onChanged: (String newValue) {
              setState(() {
                _subSubCat = newValue;
              });
              widget._callbackSubSubCats(newValue);
            },
          ),
      ],
    );
  }
}
