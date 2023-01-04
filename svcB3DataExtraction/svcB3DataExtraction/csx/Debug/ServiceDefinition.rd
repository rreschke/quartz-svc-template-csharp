<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="QuartzSvcTemplate" generation="1" functional="0" release="0" Id="6d438615-beb9-41d2-8a46-c6dfa5206a02" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="QuartzSvcTemplateGroup" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="QuartzUI:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/QuartzSvcTemplate/QuartzSvcTemplateGroup/LB:QuartzUI:Endpoint1" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="QuartzUI:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/QuartzSvcTemplate/QuartzSvcTemplateGroup/MapQuartzUI:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="QuartzUIInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/QuartzSvcTemplate/QuartzSvcTemplateGroup/MapQuartzUIInstances" />
          </maps>
        </aCS>
        <aCS name="WorkerRole:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/QuartzSvcTemplate/QuartzSvcTemplateGroup/MapWorkerRole:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="WorkerRoleInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/QuartzSvcTemplate/QuartzSvcTemplateGroup/MapWorkerRoleInstances" />
          </maps>
        </aCS>
      </settings>
      <channels>
        <lBChannel name="LB:QuartzUI:Endpoint1">
          <toPorts>
            <inPortMoniker name="/QuartzSvcTemplate/QuartzSvcTemplateGroup/QuartzUI/Endpoint1" />
          </toPorts>
        </lBChannel>
      </channels>
      <maps>
        <map name="MapQuartzUI:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/QuartzSvcTemplate/QuartzSvcTemplateGroup/QuartzUI/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapQuartzUIInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/QuartzSvcTemplate/QuartzSvcTemplateGroup/QuartzUIInstances" />
          </setting>
        </map>
        <map name="MapWorkerRole:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/QuartzSvcTemplate/QuartzSvcTemplateGroup/WorkerRole/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapWorkerRoleInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/QuartzSvcTemplate/QuartzSvcTemplateGroup/WorkerRoleInstances" />
          </setting>
        </map>
      </maps>
      <components>
        <groupHascomponents>
          <role name="QuartzUI" generation="1" functional="0" release="0" software="C:\Git\back-svc-cotacoes-b3\svcB3DataExtraction\svcB3DataExtraction\csx\Debug\roles\QuartzUI" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaIISHost.exe " memIndex="-1" hostingEnvironment="frontendadmin" hostingEnvironmentVersion="2">
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
            <sCSPolicyIDMoniker name="/QuartzSvcTemplate/QuartzSvcTemplateGroup/QuartzUIInstances" />
            <sCSPolicyUpdateDomainMoniker name="/QuartzSvcTemplate/QuartzSvcTemplateGroup/QuartzUIUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/QuartzSvcTemplate/QuartzSvcTemplateGroup/QuartzUIFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
        <groupHascomponents>
          <role name="WorkerRole" generation="1" functional="0" release="0" software="C:\Git\back-svc-cotacoes-b3\svcB3DataExtraction\svcB3DataExtraction\csx\Debug\roles\WorkerRole" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaWorkerHost.exe " memIndex="-1" hostingEnvironment="consoleroleadmin" hostingEnvironmentVersion="2">
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
            <sCSPolicyIDMoniker name="/QuartzSvcTemplate/QuartzSvcTemplateGroup/WorkerRoleInstances" />
            <sCSPolicyUpdateDomainMoniker name="/QuartzSvcTemplate/QuartzSvcTemplateGroup/WorkerRoleUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/QuartzSvcTemplate/QuartzSvcTemplateGroup/WorkerRoleFaultDomains" />
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
    <implementation Id="2cfec19b-107e-446a-ada3-283d3d484549" ref="Microsoft.RedDog.Contract\ServiceContract\QuartzSvcTemplateContract@ServiceDefinition">
      <interfacereferences>
        <interfaceReference Id="f82fb776-d60c-4510-ad17-55e1ba9bc799" ref="Microsoft.RedDog.Contract\Interface\QuartzUI:Endpoint1@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/QuartzSvcTemplate/QuartzSvcTemplateGroup/QuartzUI:Endpoint1" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>