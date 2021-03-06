import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komisains_app/modules/youtube_channel/bloc/youtube_channel_bloc.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

class VideoPreview extends StatefulWidget {
  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late PageController pageController;
  double pageOffset = 0;
  late YoutubeChannelBloc youtubeChannelBloc;

  @override
  void initState() {
    youtubeChannelBloc = context.read<YoutubeChannelBloc>();
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page!);
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  void didChangeDependencies() {
    youtubeChannelBloc.add(FetchYoutubeVideo());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<YoutubeChannelBloc, YoutubeChannelState>(
      builder: (context, state) {
        if (state is YoutubeChannelStateLoad) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is YoutubeChannelStateLoaded) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: PageView.builder(
              controller: pageController,
              itemBuilder: (context, index) {
                return SlidingCard(
                  name: state.datum[index].title,
                  assetName: state.datum[index].thumbnail,
                  url: state.datum[index].url,
                  offset: pageOffset - index,
                );
              },
              itemCount: state.datum.length < 7 ? state.datum.length : 6,
            ),
          );
        } else {
          return Center(
            child: Text('Error'),
          );
        }
      },
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String name;
  final String url;
  final String assetName;
  final double offset;

  const SlidingCard({
    required this.name,
    required this.url,
    required this.assetName,
    required this.offset,
  });

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: InkWell(
        onTap: () => _launchURL(url),
        child: Card(
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                child: Image.network(
                  assetName,
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.8,
                  alignment: Alignment(-offset.abs(), 0),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: CardContent(
                  name: name,
                  offset: gauss,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final double offset;

  const CardContent({required this.name, required this.offset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(8 * offset, 0),
            child: AutoSizeText(name, style: const TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
