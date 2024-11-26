import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {

  IconData barIcon;
  double goal;
  double actual;
  ProgressBar({super.key, required this.barIcon, required this.goal, required this.actual});

  @override
  Widget build(BuildContext context) {
    // Calculate the progress as a percentage
    double progress = actual / goal;

    // Make sure the progress doesn't exceed 100% (i.e., 1.0)
    progress = progress > 1.0 ? 1.0 : progress;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(barIcon, size: 40,),
            const SizedBox(width: 10,),
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                color: Colors.amber.shade200,
                minHeight: 10,
              ),
            ),
          ],
        ),
      ],
    );
    
    // Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Text("Goal: $goal, Actual: $actual"),
    //       const SizedBox(height: 10),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Icon(barIcon),
    //           const SizedBox(width: 10),
    //           SizedBox(
    //             width: 200,
    //             child: LinearProgressIndicator(
    //                   value: progress,
    //                   backgroundColor: Colors.grey[300],
    //                   color: Colors.amber.shade200,
    //                   minHeight: 10,
    //                 ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}

// Row(
      //   children: [
      //     const Icon(Icons.night_shelter_sharp),
      //     LinearProgressIndicator(
      //       value: progress,
      //       backgroundColor: Colors.grey[300],
      //       color: Colors.amber.shade200,
      //       minHeight: 30,
      //     ),
      //   ],
      // ),