import 'package:compasia/Screens/Album/album.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AlbumEdit extends StatefulWidget {
  final String id;

  const AlbumEdit({super.key, required this.id});

  @override
  State<AlbumEdit> createState() => _AlbumEditState();
}

class _AlbumEditState extends State<AlbumEdit> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 45, vertical: 25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Edit Album',
                  ),
                ),
                SizedBox(height: 25),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Title';
                    } else {
                      return null;
                    }
                  },
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Title',
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: width * 0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<EditAlbumCubit>()
                              .editAlbum(titleController.text, widget.id);
                        }
                      },
                      child: BlocConsumer<EditAlbumCubit, EditAlbumState>(
                        listener: (context, state) {
                          if (state is EditAlbumFinish) {
                            Fluttertoast.showToast(
                                msg: 'Successfully edited Album');
                            Navigator.of(context).pop();
                          }
                        },
                        builder: (context, state) {
                          if (state is EditAlbumLoading) {
                            return SpinKitRing(
                              color: Colors.white,
                              size: 14,
                              lineWidth: 2,
                            );
                          } else {
                            return Text('Submit');
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
