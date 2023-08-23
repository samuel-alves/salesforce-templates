/**
 * @description       :
 * @author            : samuelalves@loba.pt
 * @group             :
 * @last modified on  : 2022-12-07
 * @last modified by  : samuelalves@loba.pt
**/
@IsTest
public without sharing class SObjectUtilsTest {
    @IsTest
    static void coalesce() {
        System.assert(SObjectUtils.coalesce(new Decimal[] {null, 1}) == 1);
        System.assert(SObjectUtils.coalesce(new Decimal[] {null, null}) == null);
    }

    @IsTest
    static void Nz() {
        System.assert(SObjectUtils.Nz(null) == 0);
    }

    @IsTest
    static void parseIntAtPosition() {
        String[] values = new String[]{'1'};
        System.assert(SObjectUtils.parseIntArrayElement(values, 0) == 1);
        System.assert(SObjectUtils.parseIntArrayElement(values, 1) == null);
    }

    @IsTest
    static void blankOrZero() {
        String[] values = new String[]{'1'};
        System.assert(SObjectUtils.blankOrZero(null) == true);
        System.assert(SObjectUtils.blankOrZero(1) == false);
    }
}