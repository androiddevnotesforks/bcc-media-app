import 'package:brunstadtv_app/helpers/btv_colors.dart';
import 'package:brunstadtv_app/helpers/btv_typography.dart';
import 'package:brunstadtv_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MyList extends StatelessWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My List In Progress'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/4x/Testimony_Selected.png', gaplessPlayback: true),
              Text(S.of(context).doYouKnowTitle, style: BtvTextStyles.headline1),
              Padding(
                padding: EdgeInsets.only(top: 12, bottom: 42),
                child: Text(
                  S.of(context).doYouKnowContent,
                  textAlign: TextAlign.center,
                  style: BtvTextStyles.body1,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: BtvColors.tint1,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {},
                child: Text(
                  S.of(context).exploreContent,
                  style: BtvTextStyles.button1.copyWith(color: BtvColors.onTint),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
