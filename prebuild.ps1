. .\BuildUtils\build_utils.ps1

$buildNumber = ($env:APPVEYOR_BUILD_NUMBER, "0" -ne $null)[0]
$version = Get-VersionFromTag

Update-AppveyorBuild -Version "$version.$buildNumber"

if($env:APPVEYOR_REPO_BRANCH -ne "release") {
	$version = "$version-pre$buildNumber"
}

Patch-Xml "YamlDotNet.Dynamic\YamlDotNet.Dynamic.nuspec" $version "/package/metadata/version/text()" @{ }
Patch-AssemblyInfo "YamlDotNet.Dynamic\Properties\AssemblyInfo.cs" $version
