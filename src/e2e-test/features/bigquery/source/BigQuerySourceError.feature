@BigQuery_Source
Feature: BigQuery source - Validate BigQuery source plugin error scenarios

  Scenario Outline:Verify BigQuery Source properties validation errors for mandatory fields
    Given Open Datafusion Project to configure pipeline
    When Source is BigQuery
    Then Open BigQuery source properties
    Then Enter the BigQuery properties with blank property "<property>"
    Then Validate mandatory property error for "<property>"
    Examples:
      | property      |
      | dataset       |
      | table         |

  @BQ_SOURCE_TEST
  Scenario Outline:Verify BigQuery Source properties validation errors for incorrect values
    Given Open Datafusion Project to configure pipeline
    When Source is BigQuery
    Then Open BigQuery source properties
    Then Enter BigQuery property reference name
    Then Override Service account details if set in environment variables
    Then Enter the BigQuery source properties with incorrect property "<property>" value "<value>"
    Then Validate BigQuery source incorrect property error for table "<property>" value "<value>"
    Examples:
      | property       | value                       |
      | dataset        | bqIncorrectDataset          |
      | table          | bqIncorrectTableName        |
      | datasetProject | bqIncorrectDatasetProjectId |

  Scenario Outline:Verify BigQuery Source properties validation errors for incorrect format of projectIds
    Given Open Datafusion Project to configure pipeline
    When Source is BigQuery
    Then Open BigQuery source properties
    Then Enter BigQuery property reference name
    Then Enter BigQuery property projectId "<ProjectID>"
    Then Enter BigQuery property datasetProjectId "<DatasetProjectID>"
    Then Enter BigQuery property dataset "dataset"
    Then Enter BigQuery source property table name
    Then Verify plugin properties validation fails with 1 error
    Examples:
      | ProjectID                  | DatasetProjectID                  |
      | bqIncorrectFormatProjectId | projectId                         |
      | projectId                  | bqIncorrectFormatDatasetProjectId |

  @BQ_SOURCE_TEST
  Scenario:Verify BigQuery Source properties validation errors for incorrect value of temporary bucket name
    Given Open Datafusion Project to configure pipeline
    When Source is BigQuery
    Then Open BigQuery source properties
    Then Enter BigQuery property reference name
    Then Enter BigQuery property projectId "projectId"
    Then Enter BigQuery property datasetProjectId "projectId"
    Then Override Service account details if set in environment variables
    Then Enter BigQuery property dataset "dataset"
    Then Enter BigQuery source property table name
    Then Enter BigQuery property temporary bucket name "bqInvalidTemporaryBucket"
    Then Verify the BigQuery validation error message for invalid property "bucket"

  @BQ_SOURCE_TEST
  Scenario Outline:To verify error message when unsupported format is provided in Partition Start date and Partition end Date
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "BigQuery" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "BigQuery"
    Then Replace input plugin property: "project" with value: "projectId"
    Then Replace input plugin property: "dataset" with value: "dataset"
    Then Replace input plugin property: "table" with value: "bqSourceTable"
    Then Click on the Get Schema button
    Then Enter BigQuery source properties partitionFrom and partitionTo
    Then Validate BigQuery source incorrect property error for Partition Start date "<property>" value "<value>"
    Then Validate BigQuery source incorrect property error for Partition End date "<property>" value "<value>"
    Then Enter BigQuery source properties referenceName
    Then Validate BigQuery source incorrect property error for reference name"<property>" value "<value>"
    Then Enter BigQuery source properties filter
    Examples:
      | property             | value                       |
      | partitionFrom        | bqIncorrectFormatStartDate  |
      | partitionTo          | bqIncorrectFormatEndDate    |
      | referenceName        | bqIncorrectReferenceName    |
      | filter               | bqIncorrectFilter           |

