class TPricingCalculator {
  //* calculate price based on tax and shipping
  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmmount = productPrice * taxRate;

    double shippingCost = getShippingCost(location);
    double totalPrice = productPrice + taxAmmount + shippingCost;
    return totalPrice;
  }

  //* calculate shipping cost
  static String calculateShippingCost(String location, double productPrice) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  //* calculate tax rate
  static String calculateTax(String location, double productPrice) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmmount = productPrice * taxRate;
    return taxAmmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    //? lookup the tax rate for given location using an api
    return 0.10;
  }

  static double getShippingCost(String location) {
    //? lookup the shipping cost for given location using an api
    return 5.00;
  }

  //* sum all cart value and return total amount
  // static double calculateCartTotal(CartModel cart) {
  //   return cart.item
  //       .map((e) => e.price)
  //       .fold(
  //         0,
  //         (previousPrice, currentPrice) => previousPrice + (currentPrice ?? 0),
  //       );
  // }
}
