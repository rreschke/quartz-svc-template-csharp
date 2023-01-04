<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="AzureCloudQuartzSvc" generation="1" functional="0" release="0" Id="325d08b3-8461-4720-bddd-e27bef76b1a1" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="AzureCloudQuartzSvcGroup" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="QuartzUI:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/LB:QuartzUI:Endpoint1" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="QuartzUI:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/MapQuartzUI:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="QuartzUIInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/MapQuartzUIInstances" />
          </maps>
        </aCS>
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
        <lBChannel name="LB:QuartzUI:Endpoint1">
          <toPorts>
            <inPortMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/QuartzUI/Endpoint1" />
          </toPorts>
        </lBChannel>
      </channels>
      <maps>
        <map name="MapQuartzUI:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/QuartzUI/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapQuartzUIInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/QuartzUIInstances" />
          </setting>
        </map>
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
          <role name="QuartzUI" generation="1" functional="0" release="0" software="C:\Git\back-quartz-svc-template\QuartzSvcTemplate\AzureCloudQuartzSvc\csx\Debug\roles\QuartzUI" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaIISHost.exe " memIndex="-1" hostingEnvironment="frontendadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Endpoint1" protocol="http" portRanges="80" />
            </componentports>
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;QuartzUI&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;QuartzUI&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;WorkerRole&quot; /&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/QuartzUIInstances" />
            <sCSPolicyUpdateDomainMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/QuartzUIUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/QuartzUIFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
        <groupHascomponents>
          <role name="WorkerRole" generation="1" functional="0" release="0" software="C:\Git\back-quartz-svc-template\QuartzSvcTemplate\AzureCloudQuartzSvc\csx\Debug\roles\WorkerRole" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaWorkerHost.exe " memIndex="-1" hostingEnvironment="consoleroleadmin" hostingEnvironmentVersion="2">
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;WorkerRole&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;QuartzUI&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;WorkerRole&quot; /&gt;&lt;/m&gt;" />
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
        <sCSPolicyUpdateDomain name="QuartzUIUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyUpdateDomain name="WorkerRoleUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyFaultDomain name="QuartzUIFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyFaultDomain name="WorkerRoleFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyID name="QuartzUIInstances" defaultPolicy="[1,1,1]" />
        <sCSPolicyID name="WorkerRoleInstances" defaultPolicy="[1,1,1]" />
      </sCSPolicy>
    </group>
  </groups>
  <implements>
    <implementation Id="556b507e-23aa-4461-ba95-941f3f3d4bc9" ref="Microsoft.RedDog.Contract\ServiceContract\AzureCloudQuartzSvcContract@ServiceDefinition">
      <interfacereferences>
        <interfaceReference Id="63d1824d-10c6-4510-8f42-0ae137a34e14" ref="Microsoft.RedDog.Contract\Interface\QuartzUI:Endpoint1@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/AzureCloudQuartzSvc/AzureCloudQuartzSvcGroup/QuartzUI:Endpoint1" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>