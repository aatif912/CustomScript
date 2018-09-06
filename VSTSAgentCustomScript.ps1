[Parameter(Mandatory = $true)] [String]$Version,
[Parameter(Mandatory = $true)] [String]$AccessToken,
[Parameter(Mandatory = $true)] [String]$AgentPoolName


if (!(Test-Path -Path C:\temp)) {
    New-Item -ItemType directory -Path C:\temp
}

Invoke-WebRequest -UseBasicParsing -Uri https://vstsagentpackage.azureedge.net/agent/$Version/vsts-agent-win-x64-$Version.zip -OutFile C:\temp\vsts-agent-win-x64-$Version.zip
Expand-Archive -Path C:\temp\vsts-agent-win-x64-$Version.zip -DestinationPath C:\vsts-agent -Verbose -Force
rm -Force C:\temp\vsts-agent-win-x64-$Version.zip
Set-Location -Path C:\vsts-agent
.\config.cmd --unattended --url https://shcgravity.visualstudio.com --auth pat --token $AccessToken --pool $AgentPoolName --agent $env:COMPUTERNAME --runAsService --work C:\vsts-agent\_work --replace --acceptTeeEula

