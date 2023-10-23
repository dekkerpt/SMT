########### EPO QUERY GENERATOR #############
#                                           #
# Creator: ESS Portugal Team                #
#                                           #
# Date: 2023/06/15                          #
#                                           #
#############################################

$queryname = "Rollout - June - Day 01"
$description = "Check TP and TP+FW tags"


# Read system name list
$SystemsList = Get-Content "$PSScriptRoot\SystemList.txt"

# Create new array to include all the systems
$SystemsToAdd = @()

# Function to cycle through all the lines in the system list
foreach ($SystemName in $SystemsList) {
    # Get the last system from the list and set a specific variable
   if ($SystemName -eq (Get-Content "$PSScriptRoot\SystemList.txt" -Tail 1)){
        $LastSystemName = $SystemName
    }
    else {
    # Add new line with each system to the array
    $SystemsToAdd += "eq+EPOLeafNode.NodeName+%22$SystemName%22+%29+%28+"
}

# Remove spaces from array
$SystemsToAdd = $SystemsToAdd.Replace(" ","")

}

# The last system and array will be added to the conditionURI inside the XML

# Create new XML file and format it
$xmlWriter = New-Object System.XMl.XmlTextWriter("$PSScriptRoot\$queryname.xml",$Null)
$xmlWriter.Formatting = 'Indented'
$xmlWriter.Indentation = 1
$XmlWriter.IndentChar = "`t"
$xmlWriter.WriteStartDocument()

# XML Document Start
$xmlWriter.WriteStartElement('queries')
$xmlWriter.WriteStartElement('query')

# Element :: Name
$xmlWriter.WriteStartElement('name')
$xmlWriter.WriteString($queryname)
$xmlWriter.WriteEndElement()

# Element :: Description
$xmlWriter.WriteStartElement('description')
$xmlWriter.WriteString($description)
$xmlWriter.WriteEndElement()

# Element :: Property :: Target
$xmlWriter.WriteStartElement('property')
$xmlWriter.WriteAttributeString('name','target')
$xmlWriter.WriteString('EPOLeafNode')
$xmlWriter.WriteEndElement()

# Element :: Property :: TableURI
$xmlWriter.WriteStartElement('property')
$xmlWriter.WriteAttributeString('name','tableURI')
$xmlWriter.WriteString("query:table?orion.table.columns=EPOLeafNode.NodeName%3AEPOLeafNode.LastUpdate%3AEPOBranchNode.NodeTextPath2%3AEPOLeafNode.Tags%3AEPOProdPropsView_EPOAGENT.productversion%3AEPOProdPropsView_THREATPREVENTION.productversion%3AEPOProdPropsView_FIREWALL.productversion&orion.table.order=asc&orion.table.order.by=EPOLeafNode.NodeName")
$xmlWriter.WriteEndElement()

# Element :: Property :: ConditionURI
$xmlWriter.WriteStartElement('property')
$xmlWriter.WriteAttributeString('name','conditionURI')
$xmlWriter.WriteString("query:condition?orion.condition.sexp=%28+where+%28+or+%28+
    $SystemsToAdd
    eq+EPOLeafNode.NodeName+%22$LastSystemName%22+%29+%29+%29")
$xmlWriter.WriteEndElement()

# Element :: Property :: SummaryURI
$xmlWriter.WriteStartElement('property')
$xmlWriter.WriteAttributeString('name','summaryURI')
$xmlWriter.WriteString("query:summary?orion.sum.query=false&orion.query.type=table.table")
$xmlWriter.WriteEndElement()

# End and close XML file
$xmlWriter.WriteEndElement()
$xmlWriter.WriteEndElement()
$xmlWriter.WriteEndDocument()
$xmlWriter.Flush()
$xmlWriter.Close()