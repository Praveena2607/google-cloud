/*
 * Copyright © 2021 Cask Data, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
package io.cdap.plugin.bigquery.stepsdesign;

import io.cdap.e2e.pages.actions.CdfBigQueryPropertiesActions;
import io.cdap.e2e.pages.actions.CdfGcsActions;
import io.cdap.e2e.pages.locators.CdfBigQueryPropertiesLocators;
import io.cdap.e2e.pages.locators.CdfStudioLocators;
import io.cdap.e2e.utils.*;
import io.cdap.plugin.common.stepsdesign.TestSetupHooks;
import io.cdap.plugin.utils.E2EHelper;
import io.cdap.plugin.utils.E2ETestConstants;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.junit.Assert;

import java.io.IOException;
import java.net.URISyntaxException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

/**
 * BigQuery Source related stepDesigns.
 */
public class BigQuerySource implements E2EHelper {
  @When("Source is BigQuery")
  public void sourceIsBigQuery() {
    selectSourcePlugin("BigQueryTable");
  }

  @Then("Open BigQuery source properties")
  public void openBigQuerySourceProperties() {
    openSourcePluginProperties("BigQuery");
  }

  @Then("Enter BigQuery source property table name")
  public void enterBigQuerySourcePropertyTableName() {
    CdfBigQueryPropertiesActions.enterBigQueryTable(TestSetupHooks.bqSourceTable);
  }

  @Then("Enter BigQuery source property filter {string}")
  public void enterBigQuerySourcePropertyFilter(String filter) throws IOException {
    CdfBigQueryPropertiesActions.enterFilter(PluginPropertyUtils.pluginProp(filter));
  }

  @Then("Enter BigQuery source properties partitionStartDate and partitionEndDate")
  public void enterBigQuerySourcePropertiesPartitionStartDateAndPartitionEndDate() throws IOException {
    CdfBigQueryPropertiesActions.enterPartitionStartDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
    CdfBigQueryPropertiesActions.enterPartitionEndDate(new SimpleDateFormat("yyyy-MM-dd")
            .format(DateUtils.addDays(new Date(), 1)));
  }

  @Then("Enter BigQuery source properties partitionStartDate {string} and partitionEndDate {string}")
  public void enterBigQuerySourcePropertiesPartitionStartDateAndPartitionEndDate(
          String partitionStartDate, String partitionEndDate) throws IOException {
    CdfBigQueryPropertiesActions.enterPartitionStartDate(PluginPropertyUtils.pluginProp(partitionStartDate));
    CdfBigQueryPropertiesActions.enterPartitionEndDate(PluginPropertyUtils.pluginProp(partitionEndDate));
  }

  @Then("Enter the BigQuery source mandatory properties")
  public void enterTheBigQuerySourceMandatoryProperties() throws IOException {
    CdfBigQueryPropertiesActions.enterProjectId(PluginPropertyUtils.pluginProp("projectId"));
    CdfBigQueryPropertiesActions.enterDatasetProjectId(PluginPropertyUtils.pluginProp("projectId"));
    CdfBigQueryPropertiesActions.enterBigQueryReferenceName("BQ_Ref_" + UUID.randomUUID());
    CdfBigQueryPropertiesActions.enterBigQueryDataset(PluginPropertyUtils.pluginProp("dataset"));
    CdfBigQueryPropertiesActions.enterBigQueryTable(TestSetupHooks.bqSourceTable);
  }

  @Then("Enter the BigQuery source properties with incorrect property {string} value {string}")
  public void enterTheBigQuerySourcePropertiesWithIncorrectProperty(String property, String value) throws IOException {
    CdfBigQueryPropertiesActions.enterProjectId(PluginPropertyUtils.pluginProp("projectId"));
    CdfBigQueryPropertiesActions.enterDatasetProjectId(PluginPropertyUtils.pluginProp("projectId"));
    CdfBigQueryPropertiesActions.enterBigQueryDataset(PluginPropertyUtils.pluginProp("dataset"));
    //CdfBigQueryPropertiesActions.enterPartitionStartDate(PluginPropertyUtils.pluginProp("partitionStartDate"));


    CdfBigQueryPropertiesActions.enterBigQueryTable(TestSetupHooks.bqSourceTable);



    if (property.equalsIgnoreCase("dataset")) {
      SeleniumHelper.replaceElementValue(CdfBigQueryPropertiesLocators.bigQueryDataSet,
              PluginPropertyUtils.pluginProp(value));
    } else if (property.equalsIgnoreCase("table")) {
      SeleniumHelper.replaceElementValue(CdfBigQueryPropertiesLocators.bigQueryTable,
              PluginPropertyUtils.pluginProp(value));
    } else if (property.equalsIgnoreCase("datasetProject")) {
      SeleniumHelper.replaceElementValue(CdfBigQueryPropertiesLocators.datasetProjectID,
              PluginPropertyUtils.pluginProp(value));
    } else if (property.equalsIgnoreCase("partitionFrom")) {
      SeleniumHelper.replaceElementValue(CdfBigQueryPropertiesLocators.partitionStartDate,
              PluginPropertyUtils.pluginProp(value));
    }else if (property.equalsIgnoreCase("partitionTo")) {
      SeleniumHelper.replaceElementValue(CdfBigQueryPropertiesLocators.partitionEndDate,
              PluginPropertyUtils.pluginProp(value));
    }else if (property.equalsIgnoreCase("referenceName")) {
      SeleniumHelper.replaceElementValue(CdfBigQueryPropertiesLocators.bigQueryReferenceName,
              PluginPropertyUtils.pluginProp(value));
    } else if (property.equalsIgnoreCase("filter")) {
      SeleniumHelper.replaceElementValue(CdfBigQueryPropertiesLocators.filter,
              PluginPropertyUtils.pluginProp(value));
    } else {
      Assert.fail("Invalid BigQuery property " + property);
    }
  }

  @Then("Validate BigQuery source incorrect property error for reference name{string} value {string}")
  public void validateBigQuerySourceIncorrectPropertyErrorForreferncename(String property, String value) {
    CdfBigQueryPropertiesActions.getSchema();
    SeleniumHelper.waitElementIsVisible(CdfBigQueryPropertiesLocators.getSchemaButton, 5L);
    String tableFullName = StringUtils.EMPTY;
    if (property.equalsIgnoreCase("dataset")) {
      tableFullName = PluginPropertyUtils.pluginProp("projectId") + ":" + PluginPropertyUtils.pluginProp(value)
              + "." + TestSetupHooks.bqSourceTable;
    } else if (property.equalsIgnoreCase("table")) {
      tableFullName = PluginPropertyUtils.pluginProp("projectId") + ":"
              + PluginPropertyUtils.pluginProp("dataset")
              + "." + PluginPropertyUtils.pluginProp(value);
    } else if (property.equalsIgnoreCase("datasetProject")) {
      tableFullName = PluginPropertyUtils.pluginProp(value) + ":" + PluginPropertyUtils.pluginProp("dataset")
              + "." + TestSetupHooks.bqSourceTable;
    }
    else if (property.equalsIgnoreCase("referenceName")) {
      tableFullName = PluginPropertyUtils.pluginProp(value) + ":" + PluginPropertyUtils.pluginProp("reference")
              + "." + TestSetupHooks.bqSourceTable;
    }
    String expectedErrorMessage = PluginPropertyUtils.errorProp(E2ETestConstants.ERROR_MSG_INCORRECT_REFERENCENAME)
            .replaceAll("TABLENAME", tableFullName);
    String actualErrorMessage = PluginPropertyUtils.findPropertyErrorElement("referenceName").getText();

    Assert.assertEquals(expectedErrorMessage, actualErrorMessage);
    String actualColor = PluginPropertyUtils.getErrorColor(PluginPropertyUtils.findPropertyErrorElement("referenceName"));
    String expectedColor = ConstantsUtil.ERROR_MSG_COLOR;
    Assert.assertEquals(expectedColor, actualColor);

  }
  @Then("Validate BigQuery source incorrect property error for filter {string} value {string}")
  public void validateBigQuerySourceIncorrectPropertyErrorForFilter(String property, String value) {
    CdfBigQueryPropertiesActions.getSchema();
    SeleniumHelper.waitElementIsVisible(CdfBigQueryPropertiesLocators.getSchemaButton, 5L);
    String tableFullName = StringUtils.EMPTY;
    if (property.equalsIgnoreCase("dataset")) {
      tableFullName = PluginPropertyUtils.pluginProp("projectId") + ":" + PluginPropertyUtils.pluginProp(value)
              + "." + TestSetupHooks.bqSourceTable;
    } else if (property.equalsIgnoreCase("table")) {
      tableFullName = PluginPropertyUtils.pluginProp("projectId") + ":"
              + PluginPropertyUtils.pluginProp("dataset")
              + "." + PluginPropertyUtils.pluginProp(value);
    } else if (property.equalsIgnoreCase("datasetProject")) {
      tableFullName = PluginPropertyUtils.pluginProp(value) + ":" + PluginPropertyUtils.pluginProp("dataset")
              + "." + TestSetupHooks.bqSourceTable;
    }else if (property.equalsIgnoreCase("filter")) {
      tableFullName = PluginPropertyUtils.pluginProp(value) + ":" + PluginPropertyUtils.pluginProp("filter")
              + "." + TestSetupHooks.bqSourceTable;
    }
    String expectedErrorMessage = PluginPropertyUtils.errorProp(E2ETestConstants.ERROR_MSG_INCORRECT_FILTER)
            .replaceAll("FILTER", tableFullName);
    String actualErrorMessage = PluginPropertyUtils.findPropertyErrorElement("filter").getText();
    Assert.assertEquals(expectedErrorMessage, actualErrorMessage);
    String actualColor = PluginPropertyUtils.getErrorColor(PluginPropertyUtils.findPropertyErrorElement("filter"));
    String expectedColor = ConstantsUtil.ERROR_MSG_COLOR;
    Assert.assertEquals(expectedColor, actualColor);
  }

  @Then("Enter BigQuery source properties partitionFrom and partitionTo")
  public void enterBigQuerySourcePropertiespartitionFromandpartitionTo() throws IOException {
    CdfBigQueryPropertiesActions.enterPartitionStartDate(new SimpleDateFormat("dd-MM-yyyy").format(new Date()));
    CdfBigQueryPropertiesActions.enterPartitionEndDate(new SimpleDateFormat("dd-MM-yyyy")
            .format(DateUtils.addDays(new Date(), 1)));
  }

  @Then("Enter BigQuery source properties referenceName")
  public void EnterBigQuerysourcepropertiesreferenceName() throws IOException {
    CdfBigQueryPropertiesActions.enterBigQueryReferenceName("#$%^");

  }

  @Then("Enter BigQuery source properties filter")
  public void EnterBigQuerysourcepropertiesfilter() throws IOException {
    CdfBigQueryPropertiesActions.enterFilter("%%%%");

  }


  @Then("Validate BigQuery source incorrect property error for table {string} value {string}")
  public void propvalidateBigQuerySourceIncorrectPropertyErrorFor(String property, String value) {
    CdfBigQueryPropertiesActions.getSchema();
    SeleniumHelper.waitElementIsVisible(CdfBigQueryPropertiesLocators.getSchemaButton, 5L);
    String tableFullName = StringUtils.EMPTY;
    if (property.equalsIgnoreCase("dataset")) {
      tableFullName = PluginPropertyUtils.pluginProp("projectId") + ":" + PluginPropertyUtils.pluginProp(value)
              + "." + TestSetupHooks.bqSourceTable;
    } else if (property.equalsIgnoreCase("table")) {
      tableFullName = PluginPropertyUtils.pluginProp("projectId") + ":"
              + PluginPropertyUtils.pluginProp("dataset")
              + "." + PluginPropertyUtils.pluginProp(value);
    } else if (property.equalsIgnoreCase("datasetProject")) {
      tableFullName = PluginPropertyUtils.pluginProp(value) + ":"
              + PluginPropertyUtils.pluginProp("dataset")
              + "." + TestSetupHooks.bqSourceTable;
    }
    String expectedErrorMessage = PluginPropertyUtils.errorProp(E2ETestConstants.ERROR_MSG_INCORRECT_TABLE)
            .replaceAll("TABLENAME", tableFullName);
    String actualErrorMessage = PluginPropertyUtils.findPropertyErrorElement("table").getText();
    Assert.assertEquals(expectedErrorMessage, actualErrorMessage);
    String actualColor = PluginPropertyUtils.getErrorColor(PluginPropertyUtils.findPropertyErrorElement("table"));
    String expectedColor = ConstantsUtil.ERROR_MSG_COLOR;
    Assert.assertEquals(expectedColor, actualColor);
  }

  @Then("Validate BigQuery source incorrect property error for Partition Start date {string} value {string}")
  public void validateBigQuerySourceIncorrectErrorFor(String property, String value) {
    CdfBigQueryPropertiesActions.getSchema();


    SeleniumHelper.waitElementIsVisible(CdfBigQueryPropertiesLocators.getSchemaButton, 5L);
    String tableFullName = StringUtils.EMPTY;
    if (property.equalsIgnoreCase("dataset")) {
      tableFullName = PluginPropertyUtils.pluginProp("projectId") + ":" + PluginPropertyUtils.pluginProp(value)
              + "." + TestSetupHooks.bqSourceTable;
    } else if (property.equalsIgnoreCase("table")) {
      tableFullName = PluginPropertyUtils.pluginProp("projectId") + ":"
              + PluginPropertyUtils.pluginProp("dataset")
              + "." + PluginPropertyUtils.pluginProp(value);
    } else if (property.equalsIgnoreCase("datasetProject")) {
      tableFullName = PluginPropertyUtils.pluginProp(value) + ":" + PluginPropertyUtils.pluginProp("dataset")
              + "." + TestSetupHooks.bqSourceTable;

    }else if (property.equalsIgnoreCase("partitionFrom")) {
      tableFullName = PluginPropertyUtils.pluginProp("projectId") + ":"
              + PluginPropertyUtils.pluginProp("dataset")
              + "." + PluginPropertyUtils.pluginProp(value);}

    String expectedErrorMessage = PluginPropertyUtils.errorProp(E2ETestConstants.ERROR_MSG_INCORRECT_PARTITIONSTARTDATE)
            .replaceAll("TABLENAME", tableFullName);
    String actualErrorMessage = PluginPropertyUtils.findPropertyErrorElement("partitionFrom").getText();
    System.out.println(actualErrorMessage);
    Assert.assertEquals("Error message mismatch for Partition Start Date", expectedErrorMessage, actualErrorMessage);
    String actualColor = PluginPropertyUtils.getErrorColor(PluginPropertyUtils.findPropertyErrorElement("partitionFrom"));
    String expectedColor = ConstantsUtil.ERROR_MSG_COLOR;
    Assert.assertEquals(expectedColor, actualColor);
  }

  @Then("Validate BigQuery source incorrect property error for Partition End date {string} value {string}")
  public void validateBigQuerySourceIncorrectPartitionenddateErrorFor(String property, String value) {
    CdfBigQueryPropertiesActions.getSchema();
    SeleniumHelper.waitElementIsVisible(CdfBigQueryPropertiesLocators.getSchemaButton, 5L);
    String tableFullName = StringUtils.EMPTY;
    if (property.equalsIgnoreCase("dataset")) {
      tableFullName = PluginPropertyUtils.pluginProp("projectId") + ":" + PluginPropertyUtils.pluginProp(value)
              + "." + TestSetupHooks.bqSourceTable;
    } else if (property.equalsIgnoreCase("table")) {
      tableFullName = PluginPropertyUtils.pluginProp("projectId") + ":"
              + PluginPropertyUtils.pluginProp("dataset")
              + "." + PluginPropertyUtils.pluginProp(value);
    } else if (property.equalsIgnoreCase("datasetProjectId")) {
      tableFullName = PluginPropertyUtils.pluginProp(value) + ":" + PluginPropertyUtils.pluginProp("dataset")
              + "." + TestSetupHooks.bqSourceTable;
    }else if (property.equalsIgnoreCase("partitionEndDate")) {
      tableFullName = PluginPropertyUtils.pluginProp(value) + ":"
              + PluginPropertyUtils.pluginProp("partitionTo")
              + "." + TestSetupHooks.bqSourceTable;
    }

    String expectedErrorMessage = PluginPropertyUtils.errorProp(E2ETestConstants.ERROR_MSG_INCORRECT_PARTITIONENDDATE)
            .replaceAll("TABLENAME", tableFullName);
    String actualErrorMessage = PluginPropertyUtils.findPropertyErrorElement("partitionTo").getText();
    System.out.println(actualErrorMessage);
    Assert.assertEquals("Error message mismatch for Partition End Date", expectedErrorMessage, actualErrorMessage);
    String actualColor = PluginPropertyUtils.getErrorColor(PluginPropertyUtils.findPropertyErrorElement("partitionTo"));
    String expectedColor = ConstantsUtil.ERROR_MSG_COLOR;
    Assert.assertEquals(expectedColor, actualColor);
  }

  @Then("Enter BigQuery source property {string} as macro argument {string}")
  public void enterBigQuerySourcePropertyAsMacroArgument(String pluginProperty, String macroArgument) {
    enterPropertyAsMacroArgument(pluginProperty, macroArgument);
  }

  @Then("Enter runtime argument value for BigQuery source table name key {string}")
  public void enterRuntimeArgumentValueForBigQuerySourceTableNameKey(String runtimeArgumentKey) {
    ElementHelper.sendKeys(CdfStudioLocators.runtimeArgsValue(runtimeArgumentKey), TestSetupHooks.bqSourceTable);
  }

  @Then("Toggle BigQuery source property enable querying views to true")
  public void toggleBigQuerySourcePropertyEnableQueryingViewsToTrue() {
    CdfBigQueryPropertiesActions.toggleEnableQueryingViews();
  }

  @Then("Enter the BigQuery source property for view materialization project {string}")
  public void enterTheBigQuerySourcePropertyForViewMaterializationProject(String viewMaterializationProject) {
    CdfBigQueryPropertiesActions.enterViewMaterializationProject(PluginPropertyUtils.
            pluginProp(viewMaterializationProject));
  }

  @Then("Enter the BigQuery source property for view materialization dataset {string}")
  public void enterTheBigQuerySourcePropertyForViewMaterializationDataset(String viewMaterializationDataset) {
    CdfBigQueryPropertiesActions.enterViewMaterializationDataset(PluginPropertyUtils.
            pluginProp(viewMaterializationDataset));
  }

  @Then("Enter BigQuery source property table name as view")
  public void enterBigQuerySourcePropertyTableNameAsView() {
    CdfBigQueryPropertiesActions.enterBigQueryTable(TestSetupHooks.bqSourceView);
  }

  @Then("Validate the data transferred from BigQuery to BigQuery with actual And expected file for: {string}")
  public void validateTheDataFromBQToBQWithActualAndExpectedFileFor(String expectedFile) throws IOException,
          InterruptedException, URISyntaxException {
    boolean recordsMatched = BQValidationExistingTables.validateActualDataToExpectedData(
            PluginPropertyUtils.pluginProp("bqTargetTable"),
            PluginPropertyUtils.pluginProp(expectedFile));
    Assert.assertTrue("Value of records in actual and expected file is equal", recordsMatched);
  }
}