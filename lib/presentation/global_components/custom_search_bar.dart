import 'package:flutter/material.dart';
import '../../common/dimensions.dart';
import '../../common/theme.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.hintName,
    required this.screenHeight,
    required this.screenWidth,
    // required this.onSearch,
    // required this.onClearSearch,
    // required this.searchController,
  });

  final String hintName;
  final double screenHeight;
  final double screenWidth;
  // final Function(String) onSearch;
  // final TextEditingController searchController;
  // final VoidCallback onClearSearch;

  @override
  Widget build(BuildContext context) {
    double dpi = MediaQuery.of(context).devicePixelRatio * 170;
    TextStyle textStyleTitle = dpi < 380 ? txtSecondarySubTitle : txtPrimarySubTitle;

    return SafeArea(
      child: Container(
        width: screenWidth,
        height: screenHeight,
        color: grey2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: Dimensions.paddingSizeExtraSmall,
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeLarge),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white,
                      width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)),
              width: screenWidth * 0.9,
              child: TextField(
                // onSubmitted: (value) {
                //   if (value.isEmpty) {
                //     onClearSearch();
                //   } else {
                //     onSearch(value);
                //   }
                // },
                textAlignVertical: TextAlignVertical.center,
                // controller: searchController,
                style: txtPrimarySubTitle.copyWith(
                    fontWeight: FontWeight.w500, color: blackColor),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  // suffixIcon: searchController.text.isNotEmpty
                  //     ? IconButton(
                  //         icon: const Icon(Icons.clear,
                  //             color: Color.fromRGBO(0, 0, 0, 100)),
                  //         onPressed: () {
                  //           searchController.clear();
                  //           onClearSearch();
                  //         },
                  //       )
                  //     : const Icon(Icons.search, color: Color.fromRGBO(0, 0, 0, 100)),
                  suffixIcon: const Icon(Icons.search, color: Color.fromRGBO(0, 0, 0, 100)),
                  focusColor: const Color.fromRGBO(246, 246, 246, 100),
                  fillColor: const Color.fromRGBO(246, 246, 246, 100),
                  hintText: hintName,
                  hintStyle: textStyleTitle.copyWith(
                      fontWeight: FontWeight.w400, color: greyDark),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
