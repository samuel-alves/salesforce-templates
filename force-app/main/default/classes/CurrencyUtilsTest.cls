/**
 * @description       :
 * @author            : unknown
 * @group             :
 * @last modified on  : 2025-02-03
 * @last modified by  : unknown
**/
@isTest
public class CurrencyUtilsTest {
    @isTest static void testNull() {
        String check = CurrencyUtils.convertNumberToText(null);
        System.assertEquals('',check);
    }
    @isTest static void testZero() {
        String check = CurrencyUtils.convertNumberToText(0.0);
        System.assertEquals('Zero',check);
    }
    @isTest static void testSevenPointEight() {
        String check = CurrencyUtils.convertNumberToText(7.8);
        System.assertEquals('Seven',check);
    }
    @isTest static void testTwentyFive() {
        String check = CurrencyUtils.convertNumberToText(25);
        System.assertEquals('Twenty Five',check);
    }
    @isTest static void testTwentyFiveMillion() {
        String check = CurrencyUtils.convertNumberToText(25000000);
        System.assertEquals('Twenty Five Million',check);
    }
    @isTest static void testTwentyFiveMillionNineHundredTwentyThreeThousandFiveHundredThree() {
        String check = CurrencyUtils.convertNumberToText(25923503);
        System.assertEquals('Twenty Five Million Nine Hundred Twenty Three Thousand Five Hundred Three',check);
    }
}