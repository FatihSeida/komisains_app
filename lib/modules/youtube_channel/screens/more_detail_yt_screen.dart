import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komisains_app/modules/youtube_channel/bloc/youtube_channel_bloc.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreDetailYTScreen extends StatelessWidget {
  static const routeName = '/more-yt';
  const MoreDetailYTScreen({Key? key}) : super(key: key);

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<YoutubeChannelBloc, YoutubeChannelState>(
      builder: (context, state) {
        if (state is YoutubeChannelStateLoad) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is YoutubeChannelStateLoaded) {
          return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: const Color(0xff3BBC86)),
            elevation: 0,
          ),
          body: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () => _launchURL(state.datum[index].url),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 3.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                            child: Image.network(
                              state.datum[index].thumbnail,
                              height:
                                  MediaQuery.of(context).size.height * 0.12,
                              width: MediaQuery.of(context).size.width * 0.35,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  state.datum[index].title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff3BBC86),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: state.datum.length,
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
