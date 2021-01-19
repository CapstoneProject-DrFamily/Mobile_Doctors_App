import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/enums/ViewState.dart';
import 'package:mobile_doctors_apps/service_locator.dart';
import 'package:scoped_model/scoped_model.dart';

class BaseView<T extends BaseModel> extends StatelessWidget {
  final ScopedModelDescendantBuilder<T> _builder;

  BaseView({ScopedModelDescendantBuilder<T> builder}) : _builder = builder;
  @override
  Widget build(BuildContext context) {
    return ScopedModel<T>(
      model: locator<T>(),
      child: ScopedModelDescendant<T>(
        builder: _builder,
      ),
    );
  }
}

class BaseModel extends Model {
  ViewState _state;
  ViewState get state => _state;

  void setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }
}
