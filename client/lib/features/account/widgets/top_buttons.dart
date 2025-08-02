import 'package:client/features/account/screens/your_orders_screen.dart';
import 'package:client/features/account/services/account_service.dart';
import 'package:client/features/account/widgets/account_button.dart';
import 'package:client/features/admin/screens/admin_screen.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Your Orders',
              onTap: () {
                Navigator.pushNamed(context, YourOrdersScreen.routeName);
              },
            ),
            AccountButton(
              text: 'Turn Seller',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminScreen()),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
              onTap: () => AccountService().logOut(context),
            ),
            AccountButton(
              text: 'Your Wish List',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}