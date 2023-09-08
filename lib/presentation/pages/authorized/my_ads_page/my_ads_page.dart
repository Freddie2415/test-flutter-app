import 'package:app/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAdsPage extends StatelessWidget {
  const MyAdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBar(
        title: const Text("Мои объявления"),
      ),
      body: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 10 / 17,
        ),
        children: const [
          AddGridItem(),
          AddGridItem(),
          AddGridItem(),
          AddGridItem(),
          AddGridItem(),
        ],
      ),
    );
  }

  static Route<Object?> route() =>
      MaterialPageRoute(builder: (context) => const MyAdsPage());
}

class AddGridItem extends StatelessWidget {
  const AddGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
                    child: Image.network(
                      "https://s3-alpha-sig.figma.com/img/85ee/2964/dadd4549e82643b5c55f7f04d5726796?Expires=1694995200&Signature=OKegGCMuUtF1nvUxIF-k5N8uzRKns2ia9VYIVrFIbO5yBNJGWAv6IFZ-lxIo~iWQY4W90x9HqlKfrFkg-SxxpO~~CGQzfzJIq0gPIVIO1HJrEiDfIp7sMR6zvzla~OvFERaZoMPINqUugbf0SBtopSJi1Au5NQkI9OvQT-gR3YL2hL5avaRPYPbQIILqod-x86ZNudYv1B6UdSkKWE6uq-14wCJ8wpQSwSjaPiJkKSz1Z6pQ5pIxaw5UIroYlX--um~GRhJs0VjGKOKAZS9mfaN4MIJJYYz15j3GsSQuYR931bQwx4ZTzD1HXc5-qgnI3CWhgqwgi4QSIbOq6gxWHA__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: AppColor.grey4,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "г. Ташкент",
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: const Color(0xFF63676C),
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Оригинальные кроссовки Nike Air Max 97",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "Вчера, 19:20",
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                            color: AppColor.grey1,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Text(
                        "+998 71 200 70 07",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                          color: AppColor.grey1,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "4 820 000",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "UZS",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColor.mainBlue,
                              height: 1.3,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF21B264),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "В модерации",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "до 15.09.2023",
                      style: GoogleFonts.inter(
                        color: const Color(0xFFFAAC36),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
