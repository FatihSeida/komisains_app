import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komisains_app/modules/structure/models/structures.dart';
import 'package:provider/provider.dart';

class PersonaliaScreen extends StatelessWidget {
  static const routeName = '/personalia-screen';
  @override
  Widget build(BuildContext context) {
    Provider.of<StructureProvider>(context).getPickup();
    final dataProfile =
        Provider.of<StructureProvider>(context, listen: false).items;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: const Color(0xff3BBC86),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(10.0),
                itemCount: dataProfile.length,
                itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                  value: dataProfile[i],
                  child: PersonaliaItem(),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonaliaItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final personalia = Provider.of<Structure>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.network(
          personalia.thumbnail,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          title: Text(
            personalia.name,
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            personalia.position,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
