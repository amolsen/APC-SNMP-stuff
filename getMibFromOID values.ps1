$outname = "pdu"

$mib = ""; $mib = Import-Csv .\Downloads\POWERNET-MIB.csv 
#$oid = Get-Content '.\Documents\LocalPosh\ATEA - DEV\22-1-70-oid.txt'
$oid =  "";$oid = Get-Content ".\PDUOIDResult.txt"

foreach($line in $oid){

$lineArr1 = $line.Split(" ")[0].replace("iso","1")
$lineArr= $lineArr1.Substring(0,($lineArr1.Length-2))
$lineArr
#$lineArr
if($mibsel = $mib | where {$_.'OBJECT_IDENTIFIER' -like $lineArr}){
$mibsel.'OBJECT_NAME'
$name = $mibsel.'OBJECT_NAME'
$name
$key = "atea.apc.unit.name." + $name.toLower()
$oid = $lineArr1
$description = $mibsel.'OBJECT_DESCRIPTION'
$guid = (New-Guid).Guid.Replace("-","").Substring(0,32)
$vtype = "FLOAT"
$name
if($description -match "character" -OR $description -match "Character") {$vtype = "CHAR"}

$text = @"
    <item>
    <uuid>$guid</uuid>
    <name>$name</name>
    <type>SNMP_AGENT</type>
    <snmp_oid>$oid</snmp_oid>
    <key>$key</key>
    <delay>10s</delay>
    <history>7d</history>
    <value_type>$vtype</value_type>
    <description>$description</description>
    </item>
"@ | out-file ".\Documents\Tools\$outname.txt" -Append


#$lineArr1 +","+($mibsel | convertto-csv)| Out-File .\Documents\Aircondition-.csv -Append
##$mibsel | Export-Csv .\Documents\outmib2.csv -Append

}


}


<#
get-content ".\Documents\Tools\" + $outname +".txt"
#>