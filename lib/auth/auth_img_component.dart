part of 'auth_screen.dart';

class AuthImgComponent extends StatelessWidget {
  const AuthImgComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: FadeInUp(
        duration: const Duration(seconds: 1),
        child: Stack(
          children: <Widget>[
            Positioned(
                left: MediaQuery.of(context).size.width / 2 - 150,
                width: 300,
                height: 300,
                child: SvgPicture.asset('assets/bg.svg')),
            Positioned(
              left: MediaQuery.of(context).size.width / 2 + 37,
              child: Image.asset(
                "assets/Crest.png",
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
