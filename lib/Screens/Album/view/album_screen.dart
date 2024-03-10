import 'package:cached_network_image/cached_network_image.dart';
import 'package:compasia/Screens/Album/album.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  void initState() {
    context.read<GetAlbumCubit>().getAlbum(page);
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();
  int page = 1;

  List<AlbumList> albumList = [];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => AddAlbumCubit(),
                    child: AlbumAdd(),
                  ),
                ),
              )
              .then((value) => context.read<GetAlbumCubit>().getAlbum(0));
        },
        child: Icon(Icons.add),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(10),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text('Album List'),
            if (albumList.length != 0)
              Expanded(
                child: LazyLoadScrollView(
                  scrollOffset: 50,
                  onEndOfPage: () async {
                    setState(() {
                      page++;
                    });
                    await context.read<GetAlbumCubit>().getAlbum(page);
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: albumList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Slidable(
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  // An action can be bigger than the others.
                                  onPressed: (_) {
                                    Navigator.of(context)
                                        .push(
                                          MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  EditAlbumCubit(),
                                              child: AlbumEdit(
                                                id: '${albumList[index].id}',
                                              ),
                                            ),
                                          ),
                                        )
                                        .then(
                                          (value) => context
                                              .read<GetAlbumCubit>()
                                              .getAlbum(0),
                                        );
                                  },
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),
                                SlidableAction(
                                  onPressed: (context) async {
                                    await context
                                        .read<GetAlbumCubit>()
                                        .deleteAlbum('${albumList[index].id}');

                                    Fluttertoast.showToast(
                                      msg: "Album Deleted",
                                    );
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.save,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: albumList[index].thumbnailUrl,
                                    height: 75,
                                  ),
                                  SizedBox(height: 10),
                                  Text(albumList[index].title),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      );
                    },
                  ),
                ),
              ),
            BlocConsumer<GetAlbumCubit, GetAlbumState>(
              listener: (context, state) {
                if (state is GetAlbumLoaded) {
                  setState(() {
                    albumList.addAll(state.album);
                  });
                }
              },
              builder: (context, state) {
                if (state is GetAlbumLoading) {
                  return SpinKitRing(
                    color: Colors.red,
                    size: 25,
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
