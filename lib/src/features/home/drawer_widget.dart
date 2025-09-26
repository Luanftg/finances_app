import 'package:finances_app/src/core/domain/domain.dart';
import 'package:finances_app/src/core/widgets/user_avatar_widget.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, this.clientEntity});
  final ClientEntity? clientEntity;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.lightGreen.shade200,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.green.shade300),
            child: UserAvatarWidget(
              userName: clientEntity?.name ?? '',
              userEmail: clientEntity?.email ?? '',
              photoUrl: clientEntity?.photoUrl,
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Perfil do Usuário'),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.category_outlined),
              title: Text('Categorias'),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.payment_outlined),
              title: Text('Tipos de Pagamento'),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed('log_screen'),
            child: ListTile(
              leading: Icon(Icons.abc),
              title: Text('Loggs'),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.settings_outlined),
              title: Text('Configurações'),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('Sair'),
            ),
          ),
        ],
      ),
    );
  }
}
