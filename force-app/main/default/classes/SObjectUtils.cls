/**
 * @description       :
 * @author            : unknown
 * @group             :
 * @last modified on  : 2022-12-07
 * @last modified by  : unknown
**/
public without sharing class SObjectUtils {
    /**
    * coalesce returns first non-null value in list
    * @author unknown | 2022-01-06
    * @param List<Decimal> values
    * @return Decimal
    **/
    public static Decimal coalesce(List<Decimal> values) {
        for (Decimal val : values) {
            if (val != null) return val;
        }
        return null;
    }

    /**
    * Nz function lets you return a value when a variant is null
    * (microsoft access function)
    * https://support.microsoft.com/en-us/office/nz-function-8ef85549-cc9c-438b-860a-7fd9f4c69b6c
    * @author unknown | 2022-01-06
    * @param Decimal variant
    * @param Decimal valueIfNull
    * @return Decimal
    **/
    public static Decimal Nz(Decimal variant, Decimal valueIfNull) {
        return variant == null ? valueIfNull : variant;
    }

    /**
    * Nz function lets you return 0 (zero) when a variant is null
    * (microsoft access function)
    * https://support.microsoft.com/en-us/office/nz-function-8ef85549-cc9c-438b-860a-7fd9f4c69b6c
    * @author unknown | 2022-01-06
    * @param Decimal variant
    * @return Decimal
    **/
    public static Decimal Nz(Decimal variant) {
        return Nz(variant, 0);
    }

    /**
    * Integer value of array element at a specific position
    * @author unknown | 2022-01-07
    * @param String[] values    List of value
    * @param Integer position   List position to parse
    * @return Integer
    **/
    public static Integer parseIntArrayElement(String[] values, Integer position) {
        try {
            return Integer.valueOf(values[position].trim());
        } catch(Exception ex) {
            return null;
        }
    }
    public static Boolean blankOrZero(Decimal value) {
        return value == null || value == 0;
    }
}