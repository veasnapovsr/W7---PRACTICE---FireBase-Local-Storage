import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/ui/providers/rides_pref_provider.dart';
import 'package:week_3_blabla_project/ui/providers/async_value.dart';
import 'package:week_3_blabla_project/ui/widgets/errors/bla_error_screen.dart';

import '../../../model/ride/ride_pref.dart';
import '../../theme/theme.dart';

import '../../../utils/animations_util.dart';
import '../rides/rides_screen.dart';
import 'widgets/ride_pref_form.dart';
import 'widgets/ride_pref_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

///
/// This screen allows user to:
/// - Enter his/her ride preference and launch a search on it
/// - Or select a last entered ride preferences and launch a search on it
///
class RidePrefScreen extends StatelessWidget {
  const RidePrefScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ridesPrefProvider = context.watch<RidesPrefProvider>();
    final currentRidePreference = ridesPrefProvider.currentPref;
    final pastPreferences = ridesPrefProvider.pastPreferences;

    onRidePrefSelected(RidePreference newPreference) async {
      // 1 - Update the current preference
      context.read<RidesPrefProvider>().setCurrentPreference(newPreference);

      // 2 - Navigate to the rides screen (with a buttom to top animation)
      await Navigator.of(context)
          .push(AnimationUtils.createBottomToTopRoute(RidesScreen()));

      // 3 - After wait  - Update the state   -- TODO MAKE IT WITH STATE MANAGEMENT
    }

    return Stack(
      children: [
        // 1 - Background  Image
        BlaBackground(),

        // 2 - Foreground content
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
                color: Colors.white, // White background
                borderRadius: BorderRadius.circular(16), // Rounded corners
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 2.1 Display the Form to input the ride preferences
                  RidePrefForm(
                      initialPreference: currentRidePreference,
                      onSubmit: onRidePrefSelected),
                  SizedBox(height: BlaSpacings.m),

                  // 2.2 Optionally display a list of past preferences
                  SizedBox(
                      height: 200, // Set a fixed height
                      child: Builder(builder: (BuildContext context) {
                        switch (pastPreferences.state) {
                          case AsyncValueState.loading:
                            return BlaError(
                                message: 'Loading'); // display a progress

                          case AsyncValueState.error:
                            return BlaError(
                                message: 'No connection'); // display a error

                          case AsyncValueState.success:
                            final pastList = pastPreferences.data ?? [];
                            return ListView.builder(
                              shrinkWrap: true, // Fix ListView height issue
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: pastList.length,
                              itemBuilder: (ctx, index) => RidePrefHistoryTile(
                                ridePref: pastList[index],
                                onPressed: () =>
                                    onRidePrefSelected(pastList[index]),
                              ),
                            ); // display the post
                          case AsyncValueState.empty:
                            return Text('No Post for now');
                        }
                      })),
                ],
              ),
            ),
          ],
        ),
      ],
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
        fit: BoxFit.cover, // Adjust image fit to cover the container
      ),
    );
  }
}
