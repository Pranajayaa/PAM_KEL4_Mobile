String url = "http://www.pam-kel4.my.id/";

class UrlApi {
  String login = "${url}api/login";
  String register = "${url}api/register";
  String getUserById = "${url}api/editProfile/";

  String getCustomer = "${url}api/indexCustomers";
  String createCustomer = "${url}api/createCustomers";
  String editCustomer = "${url}api/updateCustomers/";
  String deleteCustomer = "${url}api/destroyCustomers/";

  String getCategory = "${url}api/indexCategories";
  String createCategory = "${url}api/createCategories";
  String editCategory = "${url}api/updateCategories/";
  String deleteCategory = "${url}api/destroyCategories/";

  String getJastip = "${url}api/indexPersonalShopper";
  String createJastip = "${url}api/createShopper";
  String editJastip = "${url}api/editPersonalShopper/";
  String deleteJastip = "${url}api/destroyPersonalShopper/";
  String getJastipById = "${url}api/editPersonalShopper/";
}