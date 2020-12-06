import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final String titulo;
  const LogoWidget({Key key, this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shadowList = [
      Shadow(color: Colors.amber[200], blurRadius: 5, offset: Offset(2, 2)),
      Shadow(color: Colors.red[200], blurRadius: 5, offset: Offset(-2, -2)),
      Shadow(color: Colors.green[200], blurRadius: 5, offset: Offset(2, -2)),
      Shadow(color: Colors.pink[200], blurRadius: 5, offset: Offset(-2, 2))
    ];
    return SafeArea(
      child: Stack(
        children: [
          _CustomPaint(),
          Container(
            height: 300,
            width: double.infinity,
            padding: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/quepaja.png')),
                SizedBox(
                  height: 20,
                ),
                Text(
                  titulo,
                  style: TextStyle(
                    color: Colors.white60,
                    decorationColor: Colors.red.withOpacity(0.3),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 10,
                    fontStyle: FontStyle.italic,
                    shadows: shadowList,
                    decorationThickness: 4,
                    decorationStyle: TextDecorationStyle.solid,
                    fontFamily: 'poppins',
                    fontSize: 30,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomPaint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderPainter(),
      ),
    );
  }
}

class _HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]
      ..strokeWidth = 10
      ..style = PaintingStyle.fill;
    final path = Path();
    path.lineTo(size.width * 0.5, size.height * 0.5);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.5, size.height * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
