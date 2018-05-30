public with sharing class GenerateUniqueKey {
	private static final Integer KEY_LENGTH = 25;

	public static String generateKey(Integer keyLength) {
		Blob aes = Crypto.generateAesKey(128);
		String randomValue = EncodingUtil.convertToHex(aes).left(keyLength);
		return randomValue;
	}

	public static String generateKey() {
		Blob aes = Crypto.generateAesKey(128);
		String randomValue = EncodingUtil.convertToHex(aes).left(KEY_LENGTH);
		return randomValue;
	}
}