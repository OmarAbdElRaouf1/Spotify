import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/services/get_it.dart';
import 'package:spotify/core/usecases/song/add_or_remove_favorite_songs.dart';
import 'package:spotify/core/usecases/song/is_favorite_song.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, required this.songId});

  final String songId;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;
  bool _isLoading = true;
  bool _isToggling = false;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  @override
  void didUpdateWidget(covariant FavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.songId != widget.songId) {
      _loadState();
    }
  }

  Future<void> _loadState() async {
    if (widget.songId.isEmpty) {
      setState(() {
        _isFavorite = false;
        _isLoading = false;
      });
      return;
    }

    setState(() => _isLoading = true);
    final isFavorite = await getIt<IsFavoriteSongUseCase>().call(widget.songId);

    if (!mounted) return;
    setState(() {
      _isFavorite = isFavorite;
      _isLoading = false;
    });
  }

  Future<void> _toggleFavorite() async {
    if (_isToggling || widget.songId.isEmpty) return;

    setState(() => _isToggling = true);
    final result = await getIt<AddOrRemoveFavoriteSongsUseCase>().call(
      widget.songId,
    );

    if (!mounted) return;
    result.fold(
      (error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      },
      (isFavorite) {
        setState(() => _isFavorite = isFavorite == true);
      },
    );

    if (mounted) {
      setState(() => _isToggling = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _isLoading || _isToggling ? null : _toggleFavorite,
      icon: SvgPicture.asset(
        _isFavorite
            ? 'assets/vectors/heart.svg'
            : 'assets/vectors/heart_outline.svg',
        colorFilter: _isFavorite
            ? const ColorFilter.mode(Colors.red, BlendMode.srcIn)
            : null,
      ),
    );
  }
}
