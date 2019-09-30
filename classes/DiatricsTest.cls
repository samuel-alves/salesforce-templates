@IsTest
public with sharing class DiatricsTest {
    @IsTest
    private static void removeDiatrics() {
        String test = Diatrics.removeDiacritics('TéêEÊst');

        System.assertEquals(test, 'TeeEEst', 'Valores não são iguais');
    }
}