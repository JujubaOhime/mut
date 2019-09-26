import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase{

  var _controllerLoading = BehaviorSubject<bool>(seedValue: false);
  Stream<bool> get outLoading => _controllerLoading.stream;


  onClickFacebook(){

  }

  onClickGoogle(){
    
  }

  onClickTelefone() async {
    _controllerLoading.add(!_controllerLoading.value);
    await Future.delayed(Duration(seconds: 2));
    _controllerLoading.add(!_controllerLoading.value);
  }
  @override
  void dispose() {
    _controllerLoading.close();
  }

}