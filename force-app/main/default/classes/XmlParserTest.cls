/**
 * @File Name          : XMLParserTest.cls
 * @Description        :
 * @Author             : unknown
 * @Group              :
 * @Last Modified By   : unknown
 * @Last Modified On   : 11/22/2019, 5:41:24 PM
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    11/19/2019   unknown     Initial Version
**/
@IsTest
public class XmlParserTest {
    @IsTest
    static void parseXML() {
        String xml = '<?xml version="1.0" encoding="UTF-8"?><parent><name>test</name><age>28</age><children><child><name>child 1</name><age>1</age></child><child><name>child 2</name><age>2</age></child></children></parent>'; // XML
        String jsonContent = XmlParser.xmlToJson(xml);

        // You can deserailize the xml like we do JSON in apex using JSON.deserilize method

        ResponseWrapper rw = (ResponseWrapper) JSON.deserialize(jsonContent, ResponseWrapper.class);
    }

    public class ResponseWrapper{
        public Person parent;
    }

    public class Person {
        public String name;
        public String age;
        public List<Person> children;
    }
}