import 'package:flutter/material.dart';

/// App bar tipo barra de navegador sobre fondo oscuro: icono de
/// pantalla + título a la izquierda, y acciones (favorito, like,
/// dislike) a la derecha.
class BrowserStyleAppBar extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final List<AppBarAction> actions;

  const BrowserStyleAppBar({
    super.key,
    required this.title,
    this.leadingIcon = Icons.tv_outlined,
    this.actions = const [
      AppBarAction(icon: Icons.star_border),
      AppBarAction(icon: Icons.thumb_up_outlined),
      AppBarAction(icon: Icons.thumb_down_outlined),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(leadingIcon, size: 18, color: Colors.white70),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        ...actions.map(
          (a) => Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(a.icon, size: 20, color: Colors.white70),
          ),
        ),
      ],
    );
  }
}

class AppBarAction {
  final IconData icon;
  final VoidCallback? onTap;
  const AppBarAction({required this.icon, this.onTap});
}
