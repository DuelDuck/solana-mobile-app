import 'package:duelduck_solana/bloc/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';

import 'package:duelduck_solana/ui/widgets/app_bar/custom_app_bar.dart';
import 'package:duelduck_solana/ui/widgets/bottom_bar/bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            walletAddress:
                state is AuthSuccessConnectWallet ? state.walletAddress : null,
            onTapLogin: () => context.read<AuthCubit>().connectWallet(),
            onTapLogOut: () => context.read<AuthCubit>().logOut(),
          ),
          body: widget.child,
          bottomNavigationBar: BottomBar(),
        );
      },
    );
  }
}
