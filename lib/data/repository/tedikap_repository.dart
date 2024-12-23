import './global_variabel.dart';

class BetterUApiRepository {
  static String mainUrl = GlobalVariables.baseUrl;

  static String getAllProduct = '$mainUrl/api/product';
  static String getAllRewardProduct = '$mainUrl/api/reward-product';
  static String getAllVoucherActive = '$mainUrl/api/voucher/active';
  static String getAllProductFavorite = '$mainUrl/api/product/favorite';
  static String getCheckoutProduct = '$mainUrl/api/cart';
  static String getCheckoutRewardProduct = '$mainUrl/api/cart-reward';
  static String getCheckoutOrder = '$mainUrl/api/order/history';
  static String getOrderByID = '$mainUrl/api/order';
  static String getCheckoutOrderReward = '$mainUrl/api/order-reward';
  static String getUserPoin = '$mainUrl/api/point';
  static String getFilterProduct = '$mainUrl/api/filter/product';
  static String getFilterRewardProduct = '$mainUrl/api/filter/reward-product';
  static String getSearchProduct = '$mainUrl/api/filter/product';

  static String getProductByID = '$mainUrl/api/product/show';
  static String getRewardProductByID = '$mainUrl/api/reward-product/show';
  static String getCheckoutProductByIDUser = '$mainUrl/api/cart/getById';
  static String getDetailPromoByID= '$mainUrl/api/voucher/show';
  static String getDetailCartByID= '$mainUrl/api/cart/item';
  static String getDetailCartRewardByID= '$mainUrl/api/cart-reward/item';
  static String postProductFavorite = '$mainUrl/api/product/favorite';

  static String getImage = '$mainUrl/storage/product/';
  static String getAvatarProfile = '$mainUrl/storage/avatar/';
  static String getImagePromo = '$mainUrl/storage/voucher/';
  static String getImageRewardProduct = '$mainUrl/storage/reward-product/';

  static String postRegister = '$mainUrl/api/user/register';
  static String postLogin = '$mainUrl/api/user/login';
  static String getCurrentUser = '$mainUrl/api/user/get-user';
  static String postProfile = '$mainUrl/api/user/update-profile';
  static String postLogout = '$mainUrl/api/user/logout';
  static String postPayment = '$mainUrl/api/payment';
  static String postOrder = '$mainUrl/api/order/store';
  static String postOrderReward = '$mainUrl/api/order-reward/store';

  static String putOrdertByID = '$mainUrl/api/cart/update';
  static String putOrderRewardtByID = '$mainUrl/api/cart-reward/update';
  static String postCart = '$mainUrl/api/cart/store';
  static String postCartReward = '$mainUrl/api/cart-reward/store';
  static String deleteOrderByID = '$mainUrl/api/cart/delete';
  static String deleteOrderRewardByID = '$mainUrl/api/cart-reward/delete';
  static String patchUpdateQty = '$mainUrl/api/cart/update-quantity';
  static String patchUpdateQtyReward = '$mainUrl/api/cart-reward/update-quantity';

  static String postApplyVoucher = '$mainUrl/api/cart/apply-voucher';
  static String postRemoveVoucher = '$mainUrl/api/cart/remove-voucher';

}
