/**
 * @File Name          : XMLParser.cls
 * @Description        : An utility class to parse XML and create the equivalent JSON
 * @Author             : unknown
 * @Group              :
 * @Last Modified By   : unknown
 * @Last Modified On   : 11/22/2019, 5:41:24 PM
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    11/19/2019   unknown     Initial Version
**/
public class XmlParser {

    // To find the root element so that we can enclose it in the curly braces
    public static String rootElementName;

    /* Method which is parsing the XML content into JSON
    * @param xml : XML String
    * return     : JSON String
    */
    public static String xmlToJson(String xml) {
        // Load the xml in the document
        Dom.Document doc = new Dom.Document();
        doc.load(xml);
        Dom.XMLNode root = doc.getRootElement();

        // Pass the root element and false as the second parameter
        String jsonContent = XMLParser.parse(root, false);

        return jsonContent;
    }

    /* Method which makes the recursive calls and creates the JSON for
    * each element, it processes each node and finds the attributes and text content of a node
    * @param node      : Dom.XMLNode instance - XML node which will be processed
    * @param isChild   : Boolean - To control the structure of JSON, should be true for child element
    * return           : JSON string
    */
    public static String parse(Dom.XMLNode node, Boolean isChild){
        String json = '';
        Boolean isArray = false;
        if ( rootElementName == null ) {
            rootElementName = node.getName();
        }

        if ( node.getNodeType() == Dom.XmlNodeType.ELEMENT ) {
            Map<String, List<String> > mapChildrenJSON = new Map<String, List<String> >();
            List<String> lstJSONForChildren = new List<String>();

            // Check whether node has any child
            List<Dom.XMLNode> children = node.getChildElements();

            if ( children.size() > 0 ) {

                // Process all the children in a row
                for ( Dom.XMLNode child : children ) {
                    String tmp = parse( child, true );

                    if( tmp != '' ) {
                        if ( !mapChildrenJSON.containsKey( child.getName() ) ) {
                            mapChildrenJSON.put( child.getName(), new List<String>() );
                        }

                        // Add into a map to make a collection for the repeatative child nodes
                        mapChildrenJSON.get( child.getName() ).add( tmp );
                    }
                }

                // Strcuture the JSON based on the repeation
                // Should be treated as an array if there are multiple elements with the same node name
                for ( String key : mapChildrenJSON.keySet() ) {
                    if ( mapChildrenJSON.get(key).size() > 1 ) {
                        if(isChild) {
                            lstJSONForChildren.add( '[' + String.join(mapChildrenJSON.get(key), ', ') + ']' );
                        } else {
                            lstJSONForChildren.add( '"' + key + '": [' + String.join(mapChildrenJSON.get(key), ', ') + ']' );
                        }
                        isArray = true;
                    } else {
                        lstJSONForChildren.add( '"' + key + '": ' + mapChildrenJSON.get(key)[0] );
                    }
                }
            }

            // Construc the JSON for all the node attributes
            List<String> lstAttributes = new List<String>( lstJSONForChildren );

            for ( Integer i=0; i<node.getAttributeCount(); i++) {
                String key = node.getAttributeKeyAt( i );
                String value = node.getAttribute( key, '' );
                lstAttributes.add( '"' + key + '": "' + value + '"' );
            }

            // Look for the text content
            String textContent = node.getText();
            if ( textContent != null && textContent.trim() != '' ) {
                textContent = textContent.replace( '"', '\\"' );
                lstAttributes.add( '"ele_text": "' + textContent + '"' );
            }

            if ( !isChild ) {
                if(!isArray) {
                    json = '"' + node.getName() + '": {' + String.join(lstAttributes,  ', ') + '}';
                } else {
                    json = ' {' + String.join(lstAttributes,  ', ') + '}';
                }
            } else {
                if ( lstAttributes.size() == 1 && textContent != null && textContent.trim() != '' ) {
                    json = '"' + textContent + '"';
                } else {
                    if(!isArray) {
                        if( lstAttributes.size() > 0 ) {
                            json = '{' + String.join(lstAttributes,  ', ') + '}';
                        }
                    } else {
                        json = String.join(lstAttributes,  ', ');
                    }
                }
            }
        }

        if ( rootElementName == node.getName() ) {
            if(!isArray) {
                json = '{' + json + '}';
            } else {
                json = '{"' + node.getName() + '" : ' + json + '}';
            }
        }

        // System.debug(node.getName()+ ':' + json);

        return json;
    }

}