import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:komisains_app/modules/info_training/models/training_information_item.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoTraining extends StatefulWidget {
  @override
  _InfoTrainingState createState() => _InfoTrainingState();
}

class _InfoTrainingState extends State<InfoTraining> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<TrainingInfoProvider>(context).getPickup().then((_) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    final info =
        Provider.of<TrainingInfoProvider>(context, listen: false).items;
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: info[index],
          child: InkWell(
            onTap: () => _launchURL(info[index].url),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.11,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        child: Image.network(
                          info[index].thumbnail,
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.width * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.44,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              info[index].title,
                              maxLines: 4,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff3BBC86),
                              ),
                            ),
                            AutoSizeText(
                              '${DateFormat.yMMMd('en_US').format(info[index].dateStart)} s/d ${DateFormat.yMMMd('en_US').format(info[index].dateEnd)}',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: <Widget>[
                                Wrap(
                                  spacing: 7.0,
                                  runSpacing: 3.0,
                                  children: <Widget>[
                                    Chip(
                                      backgroundColor: const Color(0xffB5EFD7),
                                      label: Text(
                                        info[index].province,
                                        style: const TextStyle(
                                            color: const Color(0xff3BBC86),
                                            fontSize: 10),
                                      ),
                                    ),
                                    Chip(
                                      backgroundColor: const Color(0xffEFB5B5),
                                      label: Text(
                                        '${info[index].dateStart.difference(DateTime.now()).inDays} Hari Lagi',
                                        // DateFormat.yMMMd('id_ID').format(info[index].dateStart).difference(DateFormat.yMMMd('id_ID').format(info[index].dateEnd)).inDays,
                                        style: const TextStyle(
                                            color: const Color(0xffED455D),
                                            fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: info.length,
    );
  }
}
