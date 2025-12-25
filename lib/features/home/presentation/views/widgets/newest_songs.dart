import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/features/home/presentation/manger/newest_songs_cubit/newest_songs_cubit.dart';
import 'package:spotify/features/home/presentation/manger/newest_songs_cubit/newest_songs_state.dart';
import 'package:spotify/features/home/presentation/views/widgets/newest_sings_shimmer_loading.dart';
import 'package:spotify/features/home/presentation/views/widgets/newest_songs_list_view.dart';

class NewestSongsBlocBuilder extends StatefulWidget {
  const NewestSongsBlocBuilder({super.key});

  @override
  State<NewestSongsBlocBuilder> createState() => _NewestSongsBlocBuilderState();
}

class _NewestSongsBlocBuilderState extends State<NewestSongsBlocBuilder>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (_) => NewestSongsCubit()..fetchNewestSongs(),
      child: SizedBox(
        height: 100.h,
        child: BlocBuilder<NewestSongsCubit, NewestSongsState>(
          builder: (context, state) {
            if (state is NewestSongsInitial) {
              return const SizedBox();
            }
            if (state is NewestSongsLoading) {
              return NewestSongsShimmerLoading();
            }
            if (state is NewestSongsLoaded) {
              return SongsListView(songs: state.songs);
            } else if (state is NewestSongsError) {
              log(state.message);
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 50, color: Colors.red[300]),
                    SizedBox(height: 8.h),
                    Text(
                      'Something went wrong',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        state.message,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
