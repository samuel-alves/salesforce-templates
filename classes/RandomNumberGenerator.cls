public with sharing class RandomNumberGenerator {
    public static String generateRandomNumber() {
        String randomNumber = generate();
        if (randomNumber.length() < 6) {
            String randomNumber2 = generate();
            randomNumber = randomNumber + randomNumber2.substring(0, 10 - randomNumber.length());
        }
        return randomNumber;
    }

    public static String generateIdentifier(String prefix) {
        return prefix + '-' + generateRandomNumber();
    }

    private static String generate() {
        return String.valueOf(Math.abs(Crypto.getRandomInteger()));
    }
}