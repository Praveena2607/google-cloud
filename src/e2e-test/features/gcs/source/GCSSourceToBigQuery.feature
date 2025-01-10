@GCS_Source
Feature: GCS source - Verification of GCS to BQ successful data transfer

  @GCS_CSV_TEST @BQ_SINK_TEST
  Scenario: To verify data is getting transferred from GCS to BigQuery with Mandatory fields
    Given Open Datafusion Project to configure pipeline
    When Source is GCS
    When Sink is BigQuery
    Then Connect source as "GCS" and sink as "BigQuery" to establish connection
    Then Open GCS source properties
    Then Enter GCS property projectId and reference name
    Then Override Service account details if set in environment variables
    Then Enter GCS source property path "gcsCsvFile"
    Then Select GCS property format "csv"
    Then Toggle GCS source property skip header to true
    Then Validate output schema with expectedSchema "gcsCsvFileSchema"
    Then Validate "GCS" plugin properties
    Then Close the GCS properties
    Then Open BigQuery sink properties
    Then Override Service account details if set in environment variables
    Then Enter the BigQuery sink mandatory properties
    Then Validate "BigQuery" plugin properties
    Then Close the BigQuery properties
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "succeeded"
    Then Close the pipeline logs
    Then Click on preview data for BigQuery sink
    Then Verify preview output schema matches the outputSchema captured in properties
    Then Close the preview data
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Get count of no of records transferred to target BigQuery Table

  @GCS_OUTPUT_FIELD_TEST @BQ_SINK_TEST
  Scenario: To verify successful data transfer from GCS to BigQuery with outputField
    Given Open Datafusion Project to configure pipeline
    When Source is GCS
    When Sink is BigQuery
    Then Connect source as "GCS" and sink as "BigQuery" to establish connection
    Then Open GCS source properties
    Then Enter GCS property projectId and reference name
    Then Override Service account details if set in environment variables
    Then Enter GCS source property path "gcsOutputFieldTestFile"
    Then Select GCS property format "csv"
    Then Enter GCS source property path field "gcsPathField"
    Then Toggle GCS source property skip header to true
    Then Validate output schema with expectedSchema "gcsOutputFieldTestFileSchema"
    Then Validate "GCS" plugin properties
    Then Close the GCS properties
    Then Open BigQuery sink properties
    Then Override Service account details if set in environment variables
    Then Enter the BigQuery sink mandatory properties
    Then Validate "BigQuery" plugin properties
    Then Close the BigQuery properties
    Then Save and Deploy Pipeline
    Then Run the Pipeline in Runtime
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Get count of no of records transferred to target BigQuery Table
    Then Verify output field "gcsPathField" in target BigQuery table contains path of the source GcsBucket "gcsOutputFieldTestFile"

  @GCS_OUTPUT_FIELD_TEST @BQ_SINK_TEST @GCS_Source_Required
  Scenario: To verify Successful GCS to BigQuery data transfer with Datatype override
    Given Open Datafusion Project to configure pipeline
    When Source is GCS
    When Sink is BigQuery
    Then Connect source as "GCS" and sink as "BigQuery" to establish connection
    Then Open GCS source properties
    Then Enter GCS property projectId and reference name
    Then Override Service account details if set in environment variables
    Then Enter GCS source property path "gcsOutputFieldTestFile"
    Then Select GCS property format "csv"
    Then Enter GCS source property override field "gcsOverrideField" and data type "gcsOverrideFloatDataType"
    Then Toggle GCS source property skip header to true
    Then Validate output schema with expectedSchema "gcsOverrideSchema"
    Then Validate "GCS" plugin properties
    Then Close the GCS properties
    Then Open BigQuery sink properties
    Then Override Service account details if set in environment variables
    Then Enter the BigQuery sink mandatory properties
    Then Validate "BigQuery" plugin properties
    Then Close the BigQuery properties
    Then Save and Deploy Pipeline
    Then Run the Pipeline in Runtime
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Get count of no of records transferred to target BigQuery Table
    Then Verify datatype of field "gcsOverrideField" is overridden to data type "gcsOverrideFloatDataType" in target BigQuery table

  @GCS_DELIMITED_TEST @BQ_SINK_TEST
  Scenario: To verify Successful GCS to BigQuery data transfer with Delimiter
    Given Open Datafusion Project to configure pipeline
    When Source is GCS
    When Sink is BigQuery
    Then Connect source as "GCS" and sink as "BigQuery" to establish connection
    Then Open GCS source properties
    Then Enter GCS property projectId and reference name
    Then Override Service account details if set in environment variables
    Then Enter GCS source property path "gcsDelimitedFile"
    Then Select GCS property format "delimited"
    Then Enter GCS property delimiter "gcsDelimiter"
    Then Toggle GCS source property skip header to true
    Then Validate output schema with expectedSchema "gcsDelimitedFileSchema"
    Then Validate "GCS" plugin properties
    Then Close the GCS properties
    Then Open BigQuery sink properties
    Then Override Service account details if set in environment variables
    Then Enter the BigQuery sink mandatory properties
    Then Validate "BigQuery" plugin properties
    Then Close the BigQuery properties
    Then Save and Deploy Pipeline
    Then Run the Pipeline in Runtime
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Get count of no of records transferred to target BigQuery Table

  @GCS_BLOB_TEST @BQ_SINK_TEST
  Scenario: To verify Successful GCS to BigQuery data transfer with blob file by entering MaxMinSplitSize
    Given Open Datafusion Project to configure pipeline
    When Source is GCS
    When Sink is BigQuery
    Then Connect source as "GCS" and sink as "BigQuery" to establish connection
    Then Open GCS source properties
    Then Enter GCS property projectId and reference name
    Then Override Service account details if set in environment variables
    Then Enter GCS source property path "gcsBlobFile"
    Then Select GCS property format "blob"
    Then Enter GCS source property minimum split size "gcsMinSplitSize" and maximum split size "gcsMaxSplitSize"
    Then Validate output schema with expectedSchema "gcsBlobFileSchema"
    Then Validate "GCS" plugin properties
    Then Close the GCS properties
    Then Open BigQuery sink properties
    Then Override Service account details if set in environment variables
    Then Enter the BigQuery sink mandatory properties
    Then Validate "BigQuery" plugin properties
    Then Close the BigQuery properties
    Then Save and Deploy Pipeline
    Then Run the Pipeline in Runtime
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Get count of no of records transferred to target BigQuery Table

  @GCS_CSV_TEST @BQ_SINK_TEST
  Scenario: To verify Successful GCS to BigQuery data transfer using Regex path filter
    Given Open Datafusion Project to configure pipeline
    When Source is GCS
    When Sink is BigQuery
    Then Connect source as "GCS" and sink as "BigQuery" to establish connection
    Then Open GCS source properties
    Then Enter GCS property projectId and reference name
    Then Override Service account details if set in environment variables
    Then Enter GCS source property path "gcsCsvFile"
    Then Select GCS property format "csv"
    Then Enter GCS source property regex path filter "gcsRegexPathFilter"
    Then Toggle GCS source property skip header to true
    Then Validate output schema with expectedSchema "gcsCsvFileSchema"
    Then Validate "GCS" plugin properties
    Then Close the GCS properties
    Then Open BigQuery sink properties
    Then Override Service account details if set in environment variables
    Then Enter the BigQuery sink mandatory properties
    Then Validate "BigQuery" plugin properties
    Then Close the BigQuery properties
    Then Save and Deploy Pipeline
    Then Run the Pipeline in Runtime
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Get count of no of records transferred to target BigQuery Table

  @GCS_CSV_TEST @BQ_SINK_TEST
  Scenario: To verify Successful GCS to BigQuery data transfer with sample size field
    Given Open Datafusion Project to configure pipeline
    When Source is GCS
    When Sink is BigQuery
    Then Connect source as "GCS" and sink as "BigQuery" to establish connection
    Then Open GCS source properties
    Then Enter GCS property projectId and reference name
    Then Override Service account details if set in environment variables
    Then Enter GCS source property path "gcsCsvFile"
    Then Select GCS property format "csv"
    Then Enter input plugin property: "sampleSize" with value: "gcsSampleSize"
    Then Toggle GCS source property skip header to true
    Then Validate output schema with expectedSchema "gcsCsvFileSchema"
    Then Validate "GCS" plugin properties
    Then Close the GCS properties
    Then Open BigQuery sink properties
    Then Override Service account details if set in environment variables
    Then Enter the BigQuery sink mandatory properties
    Then Validate "BigQuery" plugin properties
    Then Close the BigQuery properties
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "succeeded"
    Then Close the pipeline logs
    Then Close the preview
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Get count of no of records transferred to target BigQuery Table
    Then Validate the values of records transferred from GCS bucket file is equal to the values of target BigQuery table

  @GCS_CSV_TEST @BQ_SINK_TEST
  Scenario: To verify Successful GCS to BigQuery data transfer with with enable quoted values true
    Given Open Datafusion Project to configure pipeline
    When Source is GCS
    When Sink is BigQuery
    Then Connect source as "GCS" and sink as "BigQuery" to establish connection
    Then Open GCS source properties
    Then Enter GCS property projectId and reference name
    Then Override Service account details if set in environment variables
    Then Enter GCS source property path "gcsCsvFile"
    Then Select GCS property format "csv"
    Then Toggle GCS source property skip header to true
    Then Click plugin property: "switch-enableQuotedValues"
    Then Validate output schema with expectedSchema "gcsCsvFileSchema"
    Then Validate "GCS" plugin properties
    Then Close the GCS properties
    Then Open BigQuery sink properties
    Then Override Service account details if set in environment variables
    Then Enter the BigQuery sink mandatory properties
    Then Validate "BigQuery" plugin properties
    Then Close the BigQuery properties
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "succeeded"
    Then Close the pipeline logs
    Then Close the preview
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Get count of no of records transferred to target BigQuery Table
    Then Validate the values of records transferred from GCS bucket file is equal to the values of target BigQuery table

  @GCS_CSV_TEST @BQ_SINK_TEST
  Scenario: To verify Successful GCS to BigQuery data transfer with allow empty input true
    Given Open Datafusion Project to configure pipeline
    When Source is GCS
    When Sink is BigQuery
    Then Connect source as "GCS" and sink as "BigQuery" to establish connection
    Then Open GCS source properties
    Then Enter GCS property projectId and reference name
    Then Override Service account details if set in environment variables
    Then Enter GCS source property path "gcsCsvFile"
    Then Select GCS property format "csv"
    Then Toggle GCS source property skip header to true
    Then Select radio button plugin property: "ignoreNonExistingFolders" with value: "true"
    Then Validate output schema with expectedSchema "gcsCsvFileSchema"
    Then Validate "GCS" plugin properties
    Then Close the GCS properties
    Then Open BigQuery sink properties
    Then Override Service account details if set in environment variables
    Then Enter the BigQuery sink mandatory properties
    Then Validate "BigQuery" plugin properties
    Then Close the BigQuery properties
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "succeeded"
    Then Close the pipeline logs
    Then Close the preview
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Get count of no of records transferred to target BigQuery Table
    Then Validate the values of records transferred from GCS bucket file is equal to the values of target BigQuery table

  @GCS_TSV_TEST @BQ_SINK_TEST
  Scenario: To verify successful data transfer from GCS source to BigQuery sink using tsv file format
    Given Open Datafusion Project to configure pipeline
    When Select plugin: "GCS" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "BigQuery" from the plugins list as: "Sink"
    Then Connect source as "GCS" and sink as "BigQuery" to establish connection
    Then Open GCS source properties
    Then Enter GCS property projectId and reference name
    Then Override Service account details if set in environment variables
    Then Enter GCS source property path "gcsTsvFile"
    Then Select GCS property format "tsv"
    Then Toggle GCS source property skip header to true
    Then Validate output schema with expectedSchema "gcsTsvFileSchema"
    Then Validate "GCS" plugin properties
    Then Close the GCS properties
    Then Open BigQuery sink properties
    Then Override Service account details if set in environment variables
    Then Enter the BigQuery sink mandatory properties
    Then Validate "BigQuery" plugin properties
    Then Close the BigQuery properties
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "succeeded"
    Then Close the pipeline logs
    Then Click on preview data for BigQuery sink
    Then Verify preview output schema matches the outputSchema captured in properties
    Then Close the preview data
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Get count of no of records transferred to target BigQuery Table
    Then Validate the values of records transferred from GCS bucket file is equal to the values of target BigQuery table

  @GCS_PARQUET_TEST @BQ_SINK_TEST
  Scenario: To verify successful data transfer from GCS source to BigQuery sink using parquet file format
    Given Open Datafusion Project to configure pipeline
    When Select plugin: "GCS" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "BigQuery" from the plugins list as: "Sink"
    Then Connect source as "GCS" and sink as "BigQuery" to establish connection
    Then Open GCS source properties
    Then Enter GCS property projectId and reference name
    Then Override Service account details if set in environment variables
    Then Enter GCS source property path "gcsParquetFile"
    Then Select GCS property format "parquet"
    Then Validate output schema with expectedSchema "gcsParquetFileSchema"
    Then Validate "GCS" plugin properties
    Then Close the GCS properties
    Then Open BigQuery sink properties
    Then Override Service account details if set in environment variables
    Then Enter the BigQuery sink mandatory properties
    Then Validate "BigQuery" plugin properties
    Then Close the BigQuery properties
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "succeeded"
    Then Close the pipeline logs
    Then Click on preview data for BigQuery sink
    Then Verify preview output schema matches the outputSchema captured in properties
    Then Close the preview data
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Get count of no of records transferred to target BigQuery Table
    Then Validate the values of records transferred from GCS bucket file is equal to the values of target BigQuery table

  @GCS_JSON_TEST @BQ_SINK_TEST
  Scenario: To verify successful data transfer from GCS source to BigQuery sink using json file format
    Given Open Datafusion Project to configure pipeline
    When Select plugin: "GCS" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "BigQuery" from the plugins list as: "Sink"
    Then Connect source as "GCS" and sink as "BigQuery" to establish connection
    Then Open GCS source properties
    Then Enter GCS property projectId and reference name
    Then Override Service account details if set in environment variables
    Then Enter GCS source property path "gcsJsonFile"
    Then Select GCS property format "json"
    Then Enter GCS source property output schema "outputSchema" as macro argument "OutSchema"
    Then Validate "GCS" plugin properties
    Then Close the GCS properties
    Then Open BigQuery sink properties
    Then Override Service account details if set in environment variables
    Then Enter the BigQuery sink mandatory properties
    Then Validate "BigQuery" plugin properties
    Then Close the BigQuery properties
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "gcsJsonFileSchema" for key "OutSchema"
    Then Run the preview of pipeline with runtime arguments
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "succeeded"
    Then Close the pipeline logs
    Then Close the preview
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Enter runtime argument value "gcsJsonFileSchema" for key "OutSchema"
    Then Run the Pipeline in Runtime with runtime arguments
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Get count of no of records transferred to target BigQuery Table
    Then Validate the values of records transferred from GCS bucket file is equal to the values of target BigQuery table

  @GCS_CSV_TEST @BQ_SINK_TEST
  Scenario: To verify Successful GCS to BigQuery data transfer with enable data file encryption flag true
    Given Open Datafusion Project to configure pipeline
    When Select plugin: "GCS" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "BigQuery" from the plugins list as: "Sink"
    Then Connect source as "GCS" and sink as "BigQuery" to establish connection
    Then Open GCS source properties
    Then Enter GCS property projectId and reference name
    Then Override Service account details if set in environment variables
    Then Enter GCS source property path "gcsCsvFile"
    Then Select GCS property format "csv"
    Then Toggle GCS source property skip header to true
    Then Validate output schema with expectedSchema "gcsCsvFileSchema"
    Then Validate "GCS" plugin properties
    Then Select radio button plugin property: "encrypted" with value: "true"
    Then Close the GCS properties
    Then Open BigQuery sink properties
    Then Override Service account details if set in environment variables
    Then Enter the BigQuery sink mandatory properties
    Then Validate "BigQuery" plugin properties
    Then Close the BigQuery properties
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "succeeded"
    Then Close the pipeline logs
    Then Close the preview
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Get count of no of records transferred to target BigQuery Table
    Then Validate the values of records transferred from GCS bucket file is equal to the values of target BigQuery table

  @GCS_CSV_TEST @BQ_SINK_TEST @BigQuery_Sink_Required
  Scenario:To verify successful records transfer from GCS source to BigQuery sink with macro fields enabled at source
    Given Open Datafusion Project to configure pipeline
    When Select plugin: "GCS" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "BigQuery" from the plugins list as: "Sink"
    Then Open GCS source properties
    Then Enter GCS property reference name
    Then Enter GCS property "projectId" as macro argument "gcsProjectId"
    Then Enter GCS property "serviceAccountType" as macro argument "serviceAccountType"
    Then Enter GCS property "serviceAccountFilePath" as macro argument "serviceAccount"
    Then Enter GCS property "serviceAccountJSON" as macro argument "serviceAccount"
    Then Enter GCS property "path" as macro argument "gcsSourcePath"
    Then Enter GCS property "format" as macro argument "gcsFormat"
    Then Enter GCS source property "skipHeader" as macro argument "gcsSkipHeader"
    Then Click on the Macro button of Property: "sampleSize" and set the value to: "SampleSize"
    Then Click on the Macro button of Property: "override" and set the value to: "OverRide"
    Then Click on the Macro button of Property: "minSplitSize" and set the value to: "MinSplit"
    Then Click on the Macro button of Property: "maxSplitSize" and set the value to: "MaxSplit"
    Then Click on the Macro button of Property: "fileRegex" and set the value to: "FileReg"
    Then Click on the Macro button of Property: "pathField" and set the value to: "PathF"
    Then Click on the Macro button of Property: "filenameOnly" and set the value to: "FilenameOnly"
    Then Click on the Macro button of Property: "recursive" and set the value to: "ReadFilesRecursively"
    Then Click on the Macro button of Property: "ignoreNonExistingFolders" and set the value to: "IgnoreNonExistingFolders"
    Then Click on the Macro button of Property: "encrypted" and set the value to: "DataFileEncrypted"
    Then Click on the Macro button of Property: "encryptedMetadataSuffix" and set the value to: "testmeta"
    Then Click on the Macro button of Property: "fileSystemProperties" and set the value to: "FileSystemPr"
    Then Click on the Macro button of Property: "fileEncoding" and set the value to: "Encode"
    Then Enter GCS source property output schema "outputSchema" as macro argument "gcsOutputSchema"
    Then Validate "GCS" plugin properties
    Then Close the GCS properties
    Then Open BigQuery sink properties
    Then Enter BigQuery property reference name
    Then Enter BigQuery property "projectId" as macro argument "bqProjectId"
    Then Enter BigQuery property "datasetProjectId" as macro argument "bqDatasetProjectId"
    Then Enter GCS property "serviceAccountType" as macro argument "serviceAccountType"
    Then Enter GCS property "serviceAccountFilePath" as macro argument "serviceAccount"
    Then Enter GCS property "serviceAccountJSON" as macro argument "serviceAccount"
    Then Enter BigQuery property "dataset" as macro argument "bqDataset"
    Then Enter BigQuery property "table" as macro argument "bqTargetTable"
    Then Enter BigQuery sink property "truncateTable" as macro argument "bqTruncateTable"
    Then Enter BigQuery sink property "updateTableSchema" as macro argument "bqUpdateTableSchema"
    Then Validate "BigQuery" plugin properties
    Then Close the BigQuery properties
    Then Connect source as "GCS" and sink as "BigQuery" to establish connection
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "projectId" for key "gcsProjectId"
    Then Enter runtime argument value "serviceAccountType" for key "serviceAccountType"
    Then Enter runtime argument value "serviceAccount" for key "serviceAccount"
    Then Enter runtime argument value "gcsCsvFile" for GCS source property path key "gcsSourcePath"
    Then Enter runtime argument value "gcsSkipHeaderTrue" for key "gcsSkipHeader"
    Then Enter runtime argument value "csvFormat" for key "gcsFormat"
    Then Enter runtime argument value "sampleSize" for key "SampleSize"
    Then Enter runtime argument value "gcsOverrideField" for key "OverRide"
    Then Enter runtime argument value "gcsMinSplitSize" for key "MinSplit"
    Then Enter runtime argument value "gcsMaxSplitSize" for key "MaxSplit"
    Then Enter runtime argument value "fileRegex" for key "FileReg"
    Then Enter runtime argument value "gcsPathField" for key "PathF"
    Then Enter runtime argument value "filenameOnly" for GCS source property path key "FilenameOnly"
    Then Enter runtime argument value "recursive" for GCS source property path key "ReadFilesRecursively"
    Then Enter runtime argument value "ignoreNonExistingFolders" for GCS source property path key "IgnoreNonExistingFolders"
    Then Enter runtime argument value "encrypted" for GCS source property path key "DataFileEncrypted"
    Then Enter runtime argument value "encryptedMetadataSuffix" for GCS source property path key "testmeta"
    Then Enter runtime argument value "gcsCSVFileSysProperty" for key "FileSystemPr"
    Then Enter runtime argument value "fileEncoding" for key "Encode"
    Then Enter runtime argument value "gcsPathFieldOutputSchema" for key "gcsOutputSchema"
    Then Enter runtime argument value "projectId" for key "bqProjectId"
    Then Enter runtime argument value "projectId" for key "bqDatasetProjectId"
    Then Enter runtime argument value "dataset" for key "bqDataset"
    Then Enter runtime argument value for BigQuery sink table name key "bqTargetTable"
    Then Enter runtime argument value "bqTruncateTableTrue" for key "bqTruncateTable"
    Then Enter runtime argument value "bqUpdateTableSchemaTrue" for key "bqUpdateTableSchema"
    Then Run the preview of pipeline with runtime arguments
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "succeeded"
    Then Close the pipeline logs
    Then Close the preview
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Enter runtime argument value "projectId" for key "gcsProjectId"
    Then Enter runtime argument value "serviceAccountType" for key "serviceAccountType"
    Then Enter runtime argument value "serviceAccount" for key "serviceAccount"
    Then Enter runtime argument value "gcsCsvFile" for GCS source property path key "gcsSourcePath"
    Then Enter runtime argument value "gcsSkipHeaderTrue" for key "gcsSkipHeader"
    Then Enter runtime argument value "csvFormat" for key "gcsFormat"
    Then Enter runtime argument value "sampleSize" for key "SampleSize"
    Then Enter runtime argument value "gcsOverrideField" for key "OverRide"
    Then Enter runtime argument value "gcsMinSplitSize" for key "MinSplit"
    Then Enter runtime argument value "gcsMaxSplitSize" for key "MaxSplit"
    Then Enter runtime argument value "fileRegex" for key "FileReg"
    Then Enter runtime argument value "gcsPathField" for key "PathF"
    Then Enter runtime argument value "filenameOnly" for GCS source property path key "FilenameOnly"
    Then Enter runtime argument value "recursive" for GCS source property path key "ReadFilesRecursively"
    Then Enter runtime argument value "ignoreNonExistingFolders" for GCS source property path key "IgnoreNonExistingFolders"
    Then Enter runtime argument value "encrypted" for GCS source property path key "DataFileEncrypted"
    Then Enter runtime argument value "encryptedMetadataSuffix" for GCS source property path key "testmeta"
    Then Enter runtime argument value "gcsCSVFileSysProperty" for key "FileSystemPr"
    Then Enter runtime argument value "fileEncoding" for key "Encode"
    Then Enter runtime argument value "gcsPathFieldOutputSchema" for key "gcsOutputSchema"
    Then Enter runtime argument value "projectId" for key "bqProjectId"
    Then Enter runtime argument value "projectId" for key "bqDatasetProjectId"
    Then Enter runtime argument value "dataset" for key "bqDataset"
    Then Enter runtime argument value for BigQuery sink table name key "bqTargetTable"
    Then Enter runtime argument value "bqTruncateTableTrue" for key "bqTruncateTable"
    Then Enter runtime argument value "bqUpdateTableSchemaTrue" for key "bqUpdateTableSchema"
    Then Run the Pipeline in Runtime with runtime arguments
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Get count of no of records transferred to target BigQuery Table
    Then Validate the values of records transferred from GCS bucket file is equal to the values of target BigQuery table
