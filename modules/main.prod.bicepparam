using './Main.bicep'

param pEnvironment = 'prod'
/*param pAppServicePlanName = 'azbicep-dev-fc-asp1'
param pAppServiceName = 'azbicep-dev-fc-webapp1'
param pAppInsightsName = 'azbicep-dev-fc-ai1'
param pSqlServerName = 'azbicep-dev-fc-sqlserver1'
param pSqlDatabaseName = 'database-dev'
param padminLogin = 'sqladmin' */

var prefixes = loadJsonContent('./sharedvariables.json')

param pAppServicePlanName = '${prefixes.projectnameprefix}-${pEnvironment}-${prefixes.regionprefix}-${prefixes.appserviceplanprefix}1'
param pAppServiceName = '${prefixes.projectnameprefix}-${pEnvironment}-${prefixes.regionprefix}-${prefixes.appserviceprefix}1'
param pAppInsightsName = '${prefixes.projectnameprefix}-${pEnvironment}-${prefixes.regionprefix}-${prefixes.appinsightsprefix}1'
param pSqlServerName = '${prefixes.projectnameprefix}-${pEnvironment}-${prefixes.regionprefix}-${prefixes.sqlserverprefix}1'
param pSqlDatabaseName = '${prefixes.projectnameprefix}-${pEnvironment}-${prefixes.regionprefix}-${prefixes.sqldatabaseprefix}1'
param padminLogin = '${prefixes.projectnameprefix}-${prefixes.adminlogin}'

