import 'package:flutter/material.dart';

import 'package:duelduck_solana/data/repositories/models/duel.dart';
import 'package:duelduck_solana/ui/screens/add_duel/widgets/publish_duel.dart';
import 'package:duelduck_solana/ui/screens/add_duel/widgets/duel_settings.dart';

class AddDuelScreen extends StatefulWidget {
  const AddDuelScreen({super.key});

  @override
  State<AddDuelScreen> createState() => _AddDuelScreenState();
}

class _AddDuelScreenState extends State<AddDuelScreen> {
  bool _isConfirmationDuel = false;

  late CreateDuelModel createDuelModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            _isConfirmationDuel
                ? PublishDuel(createDuelModel: createDuelModel)
                : DuelSettings(
                  onNextStep: (createDuel) {
                    setState(() {
                      createDuelModel = createDuel;
                      _isConfirmationDuel = true;
                    });
                  },
                ),
      ),
    );
  }
}
