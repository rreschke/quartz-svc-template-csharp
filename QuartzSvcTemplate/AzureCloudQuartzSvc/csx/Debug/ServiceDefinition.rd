<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="AzureCloudQuartzSvc" generation="1" functional="0" release="0" Id="684f7576-b74d-4d4a-83bd-b8de28dc9d41" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="AzureCloudQuartzSvcGroup" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="WorkerRole:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/LB:WorkerRole:Endpoint1" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="WorkerRole:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/MapWorkerRole:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="WorkerRoleInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/MapWorkerRoleInstances" />
          </maps>
        </aCS>
      </settings>
      <channels>
        <lBChannel name="LB:WorkerRole:Endpoint1">
          <toPorts>
            <inPortMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/WorkerRole/Endpoint1" />
          </toPorts>
        </lBChannel>
      </channels>
      <maps>
        <map name="MapWorkerRole:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/WorkerRole/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapWorkerRoleInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/WorkerRoleInstances" />
          </setting>
        </map>
      </maps>
      <components>
        <groupHascomponents>
          <role name="WorkerRole" generation="1" functional="0" release="0" software="C:\Git\back-quartz-svc-template\QuartzSvcTemplate\AzureCloudQuartzSvc\csx\Debug\roles\WorkerRole" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaWorkerHost.exe " memIndex="-1" hostingEnvironment="consoleroleadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Endpoint1" protocol="http" portRanges="9000" />
            </componentports>
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;WorkerRole&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;WorkerRole&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/WorkerRoleInstances" />
            <sCSPolicyUpdateDomainMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/WorkerRoleUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/WorkerRoleFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
      </components>
      <sCSPolicy>
        <sCSPolicyUpdateDomain name="WorkerRoleUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyFaultDomain name="WorkerRoleFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyID name="WorkerRoleInstances" defaultPolicy="[1,1,1]" />
      </sCSPolicy>
    </group>
  </groups>
  <implements>
    <implementation Id="d11e544e-4777-4119-b3aa-07343984090b" ref="Microsoft.RedDog.Contract\ServiceContract\AzureCloudQuartzSvcContract@ServiceDefinition">
      <interfacereferences>
        <interfaceReference Id="8020e345-03ce-45d7-988a-524ebd0eef4a" ref="Microsoft.RedDog.Contract\Interface\WorkerRole:Endpoint1@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/WorkerRole:Endpoint1" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>