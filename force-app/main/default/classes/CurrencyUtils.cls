/**
 * @description       :
 * @author            : unknown
 * @group             :
 * @last modified on  : 2025-02-03
 * @last modified by  : unknown
 **/
@SuppressWarnings('PMD.CognitiveComplexity')
public class CurrencyUtils {
    public static final String COIN_EURO = 'euros';
    public static final String COIN_EURO_CENT = 'cents';

    private static String[] unitsTensTeens = new List<String>{
        '',
        'One',
        'Two',
        'Three',
        'Four',
        'Five',
        'Six',
        'Seven',
        'Eight',
        'Nine',
        'Ten',
        'Eleven',
        'Twelve',
        'Thirteen',
        'Fourteen',
        'Fifteen',
        'Sixteen',
        'Seventeen',
        'Eighteen',
        'Nineteen'
    };

    private static String[] tens = new List<String>{ '', 'Ten', 'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety' };

    /**
    * @description
    * @author unknown | 2024-03-20
    * @param Decimal numb
    * @return String
    **/
    public static String convertNumberToText(Decimal numb) {
        if (numb == null) {
            return '';
        }

        String numbStr = convertNumberToText(numb.intValue()) + ' ' + COIN_EURO;
        String numbFractional = String.valueOf(numb)?.substringAfter('.');

        if (String.isNotBlank(numbFractional)) {
            numbStr += ' and ' +  convertNumberToText(Integer.valueOf(numbFractional)) + COIN_EURO_CENT;
        }

        return numbStr;
    }

    private static String convertNumberToText(Integer integerValue) {
        if (integerValue == null) {
            return '';
        }
        // Integer integerValue = n.intValue();
        if (integerValue == 0) {
            return 'Zero';
        }
        String textRepresentation = '';
        if (integerValue >= 1000000) {
            textRepresentation += convertNumberToText(integerValue / 1000000) + ' Million ';
            integerValue = math.mod(integerValue, 1000000);
        }
        if (integerValue >= 1000) {
            textRepresentation += convertNumberToText(integerValue / 1000) + ' Thousand ';
            integerValue = math.mod(integerValue, 1000);
        }
        if (integerValue >= 100) {
            textRepresentation += unitsTensTeens[integerValue / 100] + ' Hundred ';
            integerValue = math.mod(integerValue, 100);
        }
        if (integerValue >= 20) {
            textRepresentation += tens[integerValue / 10] + ' ';
            integerValue = math.mod(integerValue, 10);
        }
        if (integerValue > 0) {
            textRepresentation += unitsTensTeens[integerValue];
        }
        return textRepresentation.trim();
    }

    // Invocable method for Salesforce Flows
    @InvocableMethod(label='Convert Number to Text' description='Converts a given number to its textual representation.')
    public static List<String> convertNumberToFlow(List<Decimal> numbers) {
        List<String> textRepresentations = new List<String>();
        for (Decimal numb : numbers) {
            textRepresentations.add(convertNumberToText(numb));
        }
        return textRepresentations;
    }
}
