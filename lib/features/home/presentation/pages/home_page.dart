import 'package:flutter/material.dart';
import 'package:flutter_getx_starter/common_widget/app_button.dart';
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
                Column(
                  children:  [
                    AppButton(title: "Default",action:  () => controller.variantName = null,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    titleColor:  Theme.of(context).colorScheme.background,

                    ),
                    SizedBox(height: 10,),
                    AppButton(title: "beach",action:  () => controller.variantName = 'beach',
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      titleColor:  Theme.of(context).colorScheme.background,

                    ),
                    SizedBox(height: 10,),
                    AppButton(title: "street",action:  () => controller.variantName = 'street',
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      titleColor:  Theme.of(context).colorScheme.background,

                    ),
                    SizedBox(height: 10,),
                    AppButton(title: "available variants",action: () {
                      controller.availableVariants().then((value) {
                        setState(() {
                          availableVariants = value;
                        });
                      });
                    },
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      titleColor:  Theme.of(context).colorScheme.background,

                    ),
                    SizedBox(height: 10,),

                    if (availableVariants != null)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: availableVariants!.length,
                        itemBuilder: (context, index) {
                          String variant = availableVariants![index];
                          return Text('variant $index is $variant', style: AppFonts.styleWithGilroyBoldText(
                              color: Theme.of(context).colorScheme.onBackground,
                              fSize: FontSizeValue.fontSize16),);
                        },
                      ),
                    SizedBox(height: 10,),
                  ],

                ),
                SizedBox(
                  width: Get.width,
                  height: Get.width,
                  child: Card(
                    color: Colors.red,
                    child: O3D(
                      controller: controller,
                      progressBarColor: Colors.red,
                      src: 'assets/glb/materials_variants_shoe.glb',
                      // variantName: 'street',
                    ),
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
