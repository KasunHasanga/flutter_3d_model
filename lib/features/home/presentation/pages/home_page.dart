import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:o3d/o3d.dart';

import '../../../../common_widget/app_bar.dart';

import '../../../../config/constants.dart';
import '../../../../config/fonts.dart';
import '../controller/home_page_controller.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late HomePageController homePageController;


  @override
  void initState() {
    if (Get.isRegistered<HomePageController>()) {
      homePageController = Get.find();
    } else {
      homePageController = Get.put(HomePageController());
    }

    super.initState();
  }

  List<String>? availableVariants;
  List<String>? availableAnimations;
  final O3DController controller = O3DController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: MainAppBar(
            title: 'home'.tr,

          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ModelDetail(
                  actions: [
                    FilledButton(
                      onPressed: () => controller.variantName = null,
                      child: const Text('Default'),
                    ),
                    FilledButton(
                      onPressed: () => controller.variantName = 'beach',
                      child: const Text('beach'),
                    ),
                    FilledButton(
                      onPressed: () => controller.variantName = 'street',
                      child: const Text('street'),
                    ),
                    FilledButton(
                      onPressed: () {
                        controller.availableVariants().then((value) {
                          setState(() {
                            availableVariants = value;
                          });
                        });
                      },
                      child: const Text('available variants'),
                    ),
                    if (availableVariants != null)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: availableVariants!.length,
                        itemBuilder: (context, index) {
                          String variant = availableVariants![index];
                          return Text('variant $index is $variant');
                        },
                      )
                  ],
                  o3d: O3D(
                    controller: controller,
                    progressBarColor: Colors.red,
                    src: 'assets/glb/materials_variants_shoe.glb',
                    // variantName: 'street',
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),
                Text(
                  'New parking'.tr,
                  style: AppFonts.styleWithGilroyBoldText(
                      color: Theme.of(context).colorScheme.onBackground,
                      fSize: FontSizeValue.fontSize25),
                ),
                const SizedBox(
                  height: 10,
                ),



              ],
            ),
          ),
        ));
  }



}
class ModelDetail extends StatelessWidget {
  final List<Widget> actions;
  final Widget o3d;

  const ModelDetail({
    super.key,
    required this.actions,
    required this.o3d,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade100.withOpacity(.3),
      elevation: 0,
      margin: const EdgeInsets.all(16),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        padding: const EdgeInsets.all(4),
        width: double.infinity,
        height: 400,
        child: Column(
          children: [
            Wrap(
              children: actions
                  .map((child) => Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 2),
                child: child,
              ))
                  .toList(),
            ),
            Expanded(
                child: Card(
                  color: Colors.blue.shade100.withOpacity(.3),
                  elevation: 0,
                  child: AspectRatio(aspectRatio: 1, child: o3d),
                ))
          ],
        ),
      ),
    );
  }
}
