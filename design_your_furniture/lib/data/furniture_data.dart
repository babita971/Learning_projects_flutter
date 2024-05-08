import 'package:design_your_furniture/modal/furniture_modal.dart';

class FurnitureData {
  final List<ChairModel> _furnitureStore = [
    ChairModel(
        chairName: 'Rickman Lounge Chair-Yellow',
        chairImages: [
          'assets/images/Rickman_Lounge_Chair_Yellow1.png',
          'assets/images/Rickman_Lounge_Chair_Yellow2.png',
          'assets/images/Rickman_Lounge_Chair_Yellow3.png',
          // 'assets/images/Rickman_Lounge_Chair_Yellow4.png',
          'assets/images/Rickman_Lounge_Chair_Yellow5.png'
        ],
        chairSubTitle: 'new sell',
        chairPreview:
            'assets/images-nobg/Rickman_Lounge_Chair_Yellow1-removebg.png',
        chairPrice: 126,
        description:
            'All Wooden Structure. Made from Solid Teak Wood with Melamine Polish.'),
    ChairModel(
        chairName: 'Rickman Lounge Chair-Mat Grey',
        chairImages: [
          'assets/images/Rickman_Lounge_Chair_Color_Matty_Grey_1.jpg',
          'assets/images/Rickman_Lounge_Chair_Color_Matty_Grey_2.jpg',
          'assets/images/Rickman_Lounge_Chair_Color_Matty_Grey_3.jpg',
          'assets/images/Rickman_Lounge_Chair_Color_Matty_Grey_4.jpg',
          // 'assets/images/Rickman_Lounge_Chair_Color_Matty_Grey_5.png'
        ],
        chairPreview:
            'assets/images-nobg/Rickman_Lounge_Chair_Color_Matty_Grey_1-removebg.png',
        chairSubTitle: 'new sell',
        chairPrice: 149,
        description:
            '40 Density Premium Quality foum with HD Supersoft foum covered Seat And Back.'),
    ChairModel(
        chairName: 'Owen Lounge Chair-Midnight Blue',
        chairImages: [
          'assets/images/Owen_Lounge_Chair_Matte_Midnight_Blue_1.jpg',
          'assets/images/Owen_Lounge_Chair_Matte_Midnight_Blue_2.jpg',
          'assets/images/Owen_Lounge_Chair_Matte_Midnight_Blue_3.jpg',
          // 'assets/images/Owen_Lounge_Chair_Matte_Midnight_Blue_4.png',
        ],
        chairPreview:
            'assets/images-nobg/Owen_Lounge_Chair_Matte_Midnight_Blue_1-removebg.png',
        chairSubTitle: 'new sell',
        chairPrice: 163,
        description:
            'Simply elegant in its design, this grey Prato dining chair is perfect for an intimate meal or family snack time.'),
    ChairModel(
        chairName: 'Rickman Lounge Chair-Green',
        chairImages: [
          'assets/images/Rickman_Lounge_Chair_Green1.png',
          'assets/images/Rickman_Lounge_Chair_Green2.png',
          'assets/images/Rickman_Lounge_Chair_Green3.png',
          'assets/images/Rickman_Lounge_Chair_Green4.png',
          // 'assets/images/Rickman_Lounge_Chair_Green5.png'
        ],
        chairPreview:
            'assets/images-nobg/Rickman_Lounge_Chair_Green1-removebg.png',
        chairSubTitle: 'new sell',
        chairPrice: 182,
        description:
            'Comfort and cozy, our Rickman Lounge Chair is the epitome of elegance.'),
  ];

  getAllFurnitureData() {
    return _furnitureStore;
  }

  getChairDataByIndex(int index) {
    return _furnitureStore[index];
  }
}
