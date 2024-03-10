import 'package:compasia/Screens/Album/album.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AlbumAdd extends StatefulWidget {
  const AlbumAdd({super.key});

  @override
  State<AlbumAdd> createState() => _AlbumAddState();
}

class _AlbumAddState extends State<AlbumAdd> {
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
                    'Add Album',
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
                              .read<AddAlbumCubit>()
                              .addAlbum(titleController.text);
                        }
                      },
                      child: BlocConsumer<AddAlbumCubit, AddAlbumState>(
                        listener: (context, state) {
                          if (state is AddAlbumFinish) {
                            Fluttertoast.showToast(
                                msg: 'Successfully Added new Album');
                            Navigator.of(context).pop();
                          }
                        },
                        builder: (context, state) {
                          if (state is AddAlbumLoading) {
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
