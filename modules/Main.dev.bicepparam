using './Main.bicep'

param pEnvironment = 'dev'
/*param pAppServicePlanName = 'azbicep-dev-fc-asp1'
param pAppServiceName = 'azbicep-dev-fc-webapp1'
param pAppInsightsName = 'azbicep-dev-fc-ai1'
param pSqlServerName = 'azbicep-dev-fc-sqlserver1'
param pSqlDatabaseName = 'database-dev'
param padminLogin = 'sqladmin' */

var prefixes = loadJsonContent('./sharedvariables.json')

param pAppServicePlanName = '${prefixes.projectnameprefix}-${prefixes.envprefix}-${prefixes.regionprefix}-${prefixes.appserviceplanprefix}1'
param pAppServiceName = '${prefixes.projectnameprefix}-${prefixes.envprefix}-${prefixes.regionprefix}-${prefixes.appserviceprefix}1'
param pAppInsightsName = '${prefixes.projectnameprefix}-${prefixes.envprefix}-${prefixes.regionprefix}-${prefixes.appinsightsprefix}1'
param pSqlServerName = '${prefixes.projectnameprefix}-${prefixes.envprefix}-${prefixes.regionprefix}-${prefixes.sqlserverprefix}1'
param pSqlDatabaseName = '${prefixes.projectnameprefix}-${prefixes.envprefix}-${prefixes.regionprefix}-${prefixes.sqldatabaseprefix}1'
param padminLogin = '${prefixes.projectnameprefix}-${prefixes.adminlogin}'

