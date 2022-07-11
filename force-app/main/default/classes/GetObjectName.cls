global class GetObjectName implements Process.Plugin {
    global Process.PluginResult invoke(Process.PluginRequest request) { 
        Id recordId = (Id) request.inputParameters.get('recordId');
        
        String sObjName = recordId.getSObjectType().getDescribe().getName();  

        Map<String,Object> result = new Map<String,Object>();
        result.put('objectName', sObjName);
        return new Process.PluginResult(result);
    }

    global Process.PluginDescribeResult describe() { 
        Process.PluginDescribeResult result = new Process.PluginDescribeResult(); 
        result.Name = 'Get Object Name from record id';
        result.Tag = 'Object Classes';
        result.inputParameters = new List<Process.PluginDescribeResult.InputParameter> { 
            new Process.PluginDescribeResult.InputParameter('recordId', Process.PluginDescribeResult.ParameterType.STRING, true) 
        }; 
        result.outputParameters = new List<Process.PluginDescribeResult.OutputParameter> {
            new Process.PluginDescribeResult.OutputParameter('objectName', Process.PluginDescribeResult.ParameterType.STRING)
        }; 
        return result; 
    }
}