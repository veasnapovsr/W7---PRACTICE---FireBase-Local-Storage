// import 'package:flutter/material.dart';
//
// import '../../../model/ride/ride_pref.dart';
// import '../../../service/ride_prefs_service.dart';
// import '../../theme/theme.dart';
//
// import '../../../utils/animations_util.dart';
// import '../rides/rides_screen.dart';
// import 'widgets/ride_pref_form.dart';
// import 'widgets/ride_pref_history_tile.dart';
//
// const String blablaHomeImagePath = 'assets/images/blabla_home.png';
//
// ///
// /// This screen allows user to:
// /// - Enter his/her ride preference and launch a search on it
// /// - Or select a last entered ride preferences and launch a search on it
// ///
// class RidePrefScreen extends StatefulWidget {
//   const RidePrefScreen({super.key});
//
//   @override
//   State<RidePrefScreen> createState() => _RidePrefScreenState();
// }
//
// class _RidePrefScreenState extends State<RidePrefScreen> {
//   onRidePrefSelected(RidePreference newPreference) async {
//     // 1 - Update the current preference
//     RidePrefService.instance.setCurrentPreference(newPreference);
//
//     // 2 - Navigate to the rides screen (with a buttom to top animation)
//     await Navigator.of(context)
//         .push(AnimationUtils.createBottomToTopRoute(RidesScreen()));
//
//     // 3 - After wait  - Update the state   -- TODO MAKE IT WITH STATE MANAGEMENT
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     RidePreference? currentRidePreference =
//         RidePrefService.instance.currentPreference;
//     List<RidePreference> pastPreferences =
//         RidePrefService.instance.getPastPreferences();
//
//     return Stack(
//       children: [
//         // 1 - Background  Image
//         BlaBackground(),
//
//         // 2 - Foreground content
//         Column(
//           children: [
//             SizedBox(height: BlaSpacings.m),
//             Text(
//               "Your pick of rides at low price",
//               style: BlaTextStyles.heading.copyWith(color: Colors.white),
//             ),
//             SizedBox(height: 100),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
//               decoration: BoxDecoration(
//                 color: Colors.white, // White background
//                 borderRadius: BorderRadius.circular(16), // Rounded corners
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // 2.1 Display the Form to input the ride preferences
//                   RidePrefForm(
//                       initialPreference: currentRidePreference,
//                       onSubmit: onRidePrefSelected),
//                   SizedBox(height: BlaSpacings.m),
//
//                   // 2.2 Optionally display a list of past preferences
//                   SizedBox(
//                     height: 200, // Set a fixed height
//                     child: ListView.builder(
//                       shrinkWrap: true, // Fix ListView height issue
//                       physics: AlwaysScrollableScrollPhysics(),
//                       itemCount: pastPreferences.length,
//                       itemBuilder: (ctx, index) => RidePrefHistoryTile(
//                         ridePref: pastPreferences[index],
//                         onPressed: () =>
//                             onRidePrefSelected(pastPreferences[index]),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// class BlaBackground extends StatelessWidget {
//   const BlaBackground({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 340,
//       child: Image.asset(
//         blablaHomeImagePath,
//         fit: BoxFit.cover, // Adjust image fit to cover the container
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Provider/ride_prefs_provider.dart';
import '../../../model/ride/ride_pref.dart';
import '../../../utils/animations_util.dart';
import '../../theme/theme.dart';

import '../rides/rides_screen.dart';
import 'widgets/ride_pref_form.dart';
import 'widgets/ride_pref_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

class RidePrefScreen extends StatelessWidget {
  const RidePrefScreen({super.key});

  void onRidePrefSelected(BuildContext context, RidePreference newPreference) async {
    // Use the provider to set the current preference
    final provider = context.read<RidesPreferencesProvider>();
    provider.setCurrentPreference(newPreference);

    // Navigate to the rides screen (with a bottom to top animation)
    await Navigator.of(context)
        .push(AnimationUtils.createBottomToTopRoute(RidesScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RidesPreferencesProvider>(
      builder: (context, provider, child) {
        return Stack(
          children: [
            // Background Image
            BlaBackground(),

            // Foreground content
            Column(
              children: [
                SizedBox(height: BlaSpacings.m),
                Text(
                  "Your pick of rides at low price",
                  style: BlaTextStyles.heading.copyWith(color: Colors.white),
                ),
                SizedBox(height: 100),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Form to input ride preferences
                      RidePrefForm(
                        initialPreference: provider.currentPreference,
                        onSubmit: (pref) => onRidePrefSelected(context, pref),
                      ),
                      SizedBox(height: BlaSpacings.m),

                      // List of past preferences
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: provider.preferencesHistory.length,
                          itemBuilder: (ctx, index) => RidePrefHistoryTile(
                            ridePref: provider.preferencesHistory[index],
                            onPressed: () => onRidePrefSelected(
                                context,
                                provider.preferencesHistory[index]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class BlaBackground extends StatelessWidget {
  const BlaBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
