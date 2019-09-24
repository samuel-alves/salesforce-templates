public with sharing class Utils {
	private static Pricebook2 stdPriceBook;          // Singleton, remember when first referenced

	//  ------------------------------------------------------
	//  getStdPricebookId : as of V31, testmethods can locate std pricebook wo seeAlldata=true
	//  ------------------------------------------------------
	public static ID getStdPricebookId() {
		if (Test.isRunningTest()) return Test.getStandardPricebookId();
		return getStdPricebook().id;
	}

	//  -------------------------------------------------------
	//  getStdPriceBook: Singleton
	//  -------------------------------------------------------
	public static Pricebook2 getStdPriceBook () {
		if (stdPriceBook == null)
			stdPriceBook    = [SELECT id, name FROM Pricebook2 WHERE isStandard = true LIMIT 1];
		return stdPriceBook;
	}

	public String getRandomNumber(Integer len) {
		final String chars = '0123456789';
		String randStr = '';
		while (randStr.length() < len) {
			Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
			randStr += chars.substring(idx, idx + 1);
		}
		return randStr;
	}
}