import 'package:bloc/bloc.dart';
import 'form_state.dart';

class TextFieldCubit extends Cubit<FormState> {
  TextFieldCubit() : super(FormState.pure(''));

  void setTxt(String txt) {
    final dirt = FormState.dirty(txt);
    emit(dirt);
  }
}
