#!/bin/bash

# Why this: Beforing writing this script, I was trying to import a large table (113 columns & 700k rows) from mysql to hbase using sqoop.
#   However I always get Java Heap Space, I tried to increase java heap space but not success so the work arround is that we slit the process
#   into subset of import.

## Some configuration
mysql_connection="jdbc:mysql://localhost:3306/vnaggr"
mysql_username=root
mysql_password=mysql
mysql_tableName=rg_resourceviewtable # Define source table which will be streamed to hbase

hbase_tableName=hbase_resourceview
hbase_columnFamily=cf
hbase_rowKey=R_GroupId,R_DomainId,R_resID # Define composite row key of hbase. After import, value will be: field1_field2_field3
hbase_binDir=~/tmp/sqoopBinDir

## Column names which is defined in mysql table <<<<<<<<<<<<<<<<<<<<<<< NEED TO UPDATE THIS ACCORDING TO YOUR COLUMNS
declare -a arr=("R_resID,R_DomainId,R_GroupId,R_HomeDomainId,R_ParentDomainId,R_DSID,R_DomainDescription,R_DomainName,R_AggrID,R_AggrName"  "R_AggrAddress,R_PollerID,R_PollerName,R_PollerAddress,R_HomeDomainName,R_HomeDomainDescription,R_GroupName,R_LowestLevel"  "R_PTGroupID,R_displayName,R_resComment,R_RenamedStatus,R_displayIP,R_StartTime,R_EndTime,R_resDeactivated,R_groupExtension"  "R_lastcollecteddate,R_configID,R_Dataset,R_DatasetType,R_Subtype,R_CircuitIndex1,R_CircuitIndex2,R_CircuitIndex3,R_CircuitIndex4"  "R_CircuitIndex5,R_AuxID,R_AuxIDString,R_AuxID1,R_AuxID2,R_AuxID3,R_AuxIndex,R_AuxIndex1,R_CollectorIndex1,R_CollectorIndex2,R_CircuitSpeed1"  "R_CircuitSpeed2,R_CircuitSpeed3,R_CircuitUserSpeed1,R_CircuitUserSpeed2,R_CircuitUserSpeed3,R_CircuitStatus1,R_CircuitStatus2,R_CircuitService"  "R_configNoIndex,R_auxStr,R_auxStr1,R_auxStr2,R_auxStr3,R_IFID,R_ifIPAddress,R_ifGroup,R_ifIndex,R_ifSlot,R_ifPort,R_ifSubport,R_ifAuxIndex"  "R_ifSpeed,R_ifUserSpeed,R_ifAdminStatus,R_ifOperStatus,R_ifAuxStatus,R_ifDeactivated,R_ifDescrEncoding,R_ifName,R_ifType,R_ifFullDuplex"  "R_ifComment,R_devID,R_devName,R_devIP,R_devIPv6,R_devIPString,R_devAddrType,R_devAddr1,R_devAddr2,R_DNSIPStr,R_IPAddress,R_AltIPAddress"  "R_IPAddressString,R_AltIPAddressString,R_Suspend,R_devSNMPPort,R_snmpv3ProfileId,R_snmpv3EngineId,R_PTStartHour,R_PTEndHour,R_PTStartDay"  "R_PTEndDay,R_ifTypeDescription,R_datasetDescription,R_shortDescription,R_summarySectionTitle,R_resType,R_resDescription,R_typeGroupID"  "R_typeGroupName,R_typeGroupOrder,R_datasetWeight,R_speedUnit,R_collector,R_enabled,R_pollingPeriod,R_minPeriod,R_collects,R_resLastModified"
)

function sqoopImport(){
    columns = ${1}
    
    sqoop import 
        --connect ${mysql_connection}
        --username ${mysql_username} --password ${mysql_password}
        --table ${mysql_tableName}
        --hbase-table ${hbase_tableName} 
        --column-family ${hbase_columnFamily} 
        --hbase-row-key ${hbase_rowKey} -m 1
        --driver com.mysql.jdbc.Driver
        --bindir ${hbase_binDir}
        --columns "${columns}"
}

## now loop through the above array
for columns in "${arr[@]}"
do
    echo "Trying to import following columns: ${columns}"
    echo "------------------------------------------------------------------------------------"
    sqoopImport ${columns}
done

