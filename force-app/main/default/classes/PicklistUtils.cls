/**
 * @File Name          : PicklistUtils.cls
 * @Description        :
 * @Author             : unknown
 * @Group              :
 * @Last Modified By   : unknown
 * @Last Modified On   : 2025-02-03
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    12/20/2019   unknown     Initial Version
 **/
public class PicklistUtils {
    public class MyPickListInfo {
        public String validFor;
    }

    public static Map<String, List<String>> getFieldDependencies(String objectName, String controllingField, String dependentField) {
        Map<String, List<String>> controllingInfo = new Map<String, List<String>>();

        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);

        Schema.DescribeSObjectResult describeResult = objType.getDescribe();
        Schema.DescribeFieldResult controllingFieldInfo = describeResult.fields.getMap().get(controllingField).getDescribe();
        Schema.DescribeFieldResult dependentFieldInfo = describeResult.fields.getMap().get(dependentField).getDescribe();

        List<Schema.PicklistEntry> controllingValues = controllingFieldInfo.getPicklistValues();
        List<Schema.PicklistEntry> dependentValues = dependentFieldInfo.getPicklistValues();

        for (Schema.PicklistEntry currControllingValue : controllingValues) {
            System.debug('ControllingField: Label:' + currControllingValue.getLabel());
            controllingInfo.put(currControllingValue.getLabel(), new List<String>());
        }

        for (Schema.PicklistEntry currDependentValue : dependentValues) {
            String jsonString = JSON.serialize(currDependentValue);

            MyPickListInfo info = (MyPickListInfo) JSON.deserialize(jsonString, MyPickListInfo.class);

            String hexString = EncodingUtil.convertToHex(EncodingUtil.base64Decode(info.validFor)).toUpperCase();

            System.debug('DependentField: Label:' + currDependentValue.getLabel() + ' ValidForInHex:' + hexString + ' JsonString:' + jsonString);

            Integer baseCount = 0;

            for (Integer curr : hexString.getChars()) {
                Integer val = 0;

                if (curr >= 65) {
                    val = curr - 65 + 10;
                } else {
                    val = curr - 48;
                }

                if ((val & 8) == 8) {
                    System.debug(
                        'Dependent Field: ' + currDependentValue.getLabel() + ' Partof ControllingField:' + controllingValues[baseCount + 0].getLabel()
                    );
                    controllingInfo.get(controllingValues[baseCount + 0].getLabel()).add(currDependentValue.getLabel());
                }
                if ((val & 4) == 4) {
                    System.debug(
                        'Dependent Field: ' + currDependentValue.getLabel() + ' Partof ControllingField:' + controllingValues[baseCount + 1].getLabel()
                    );
                    controllingInfo.get(controllingValues[baseCount + 1].getLabel()).add(currDependentValue.getLabel());
                }
                if ((val & 2) == 2) {
                    System.debug(
                        'Dependent Field: ' + currDependentValue.getLabel() + ' Partof ControllingField:' + controllingValues[baseCount + 2].getLabel()
                    );
                    controllingInfo.get(controllingValues[baseCount + 2].getLabel()).add(currDependentValue.getLabel());
                }
                if ((val & 1) == 1) {
                    System.debug(
                        'Dependent Field: ' + currDependentValue.getLabel() + ' Partof ControllingField:' + controllingValues[baseCount + 3].getLabel()
                    );
                    controllingInfo.get(controllingValues[baseCount + 3].getLabel()).add(currDependentValue.getLabel());
                }

                baseCount += 4;
            }
        }

        System.debug('ControllingInfo: ' + controllingInfo);

        return controllingInfo;
    }

    /**
    * Access the state and country picklist through Apex
	* https://help.salesforce.com/s/articleView?id=000387645&type=1
    * @author unknown | 2024-08-20
    * @return List<Schema.PicklistEntry>
    **/
    public static List<Schema.PicklistEntry> getCountryCode() {
        Schema.DescribeFieldResult fieldResult = User.Countrycode.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        // System.debug('Picklist::' + ple);
        // for (Schema.PicklistEntry f : ple) {
        //     System.debug(f.getLabel() + '::' + f.getValue());
        // }
		return ple;
    }

	/**
	* Access the state and country picklist through Apex
	* https://help.salesforce.com/s/articleView?id=000387645&type=1
	* @author unknown | 2024-08-20
	* @return List<Schema.PicklistEntry>
	**/
	public static List<Schema.PicklistEntry> getStateCode() {
		Schema.DescribeFieldResult fieldResult = User.statecode.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		// System.debug('Picklist::'+ple);
		// for( Schema.PicklistEntry f : ple){
		// System.debug(f.getLabel() +'::'+ f.getValue());
		// }
		return ple;
	}
}
