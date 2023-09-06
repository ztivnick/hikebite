import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikebite/utils/auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends ConsumerState<AccountPage> {
  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateChangesProvider);

    return Center(
      child: user.when(
        data: (user) {
          return Column(children: [
            Text('Welcome ${user!.email!}'),
            ElevatedButton(
              onPressed: signOut,
              child: const Text("sign out"),
            )
          ]);
        },
        error: (e, s) => Text('Error with sign in'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
