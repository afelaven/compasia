import 'package:bloc/bloc.dart';
import 'package:compasia/Screens/Album/album.dart';
import 'package:meta/meta.dart';

part 'add_album_state.dart';

class AddAlbumCubit extends Cubit<AddAlbumState> {
  AddAlbumCubit() : super(AddAlbumInitial());

  Future<void> addAlbum(String title) async {
    emit(AddAlbumLoading());
    await Future.delayed(Duration(seconds: 2));

    await AlbumRepo.submitAlbum(title);
    emit(AddAlbumFinish());
  }
}
