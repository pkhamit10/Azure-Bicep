param pAppServicePlanName string = 'pkappserviceplan001'
param pSKUName string = 'S1'
param pSKUCapacity int = 1
param pLocation string = resourceGroup().location
param pAppServiceName string = 'pkappservice001'
param pEnvironment string ='prod'
param pInstrumentkey string = ''

module appservice_module 'br:pkacr001.azurecr.io/appserviceplan:v1' = {
  name: 'appservice_module'
  params: {
    pAppServiceName: pAppServiceName
    pAppServicePlanName: pAppServicePlanName
    pEnvironment: pEnvironment
    pInstrumentkey: pInstrumentkey
    pSKUCapacity: pSKUCapacity
    pSKUName: pSKUName
  }
}  


