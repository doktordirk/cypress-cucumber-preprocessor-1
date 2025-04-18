Feature: JSON formatter

  Background:
    Given additional preprocessor configuration
      """
      {
        "json": {
          "enabled": true
        }
      }
      """
    And I've ensured cucumber-json-formatter is installed

  Scenario: passed example
    Given a file named "cypress/integration/a.feature" with:
      """
      Feature: a feature
        Scenario: a scenario
          Given a step
      """
    And a file named "cypress/support/step_definitions/steps.js" with:
      """
      const { Given } = require("@badeball/cypress-cucumber-preprocessor/methods");
      Given("a step", function() {})
      """
    When I run cypress
    Then it passes
    And there should be a JSON output similar to "fixtures/passed-example.json"

  Scenario: passed outline
    Given a file named "cypress/integration/a.feature" with:
      """
      Feature: a feature
        Scenario Outline: a scenario
          Given a step
          Examples:
            | value |
            | foo   |
            | bar   |
      """
    And a file named "cypress/support/step_definitions/steps.js" with:
      """
      const { Given } = require("@badeball/cypress-cucumber-preprocessor/methods");
      Given("a step", function() {})
      """
    When I run cypress
    Then it passes
    And there should be a JSON output similar to "fixtures/passed-outline.json"

  Scenario: multiple features
    Given a file named "cypress/integration/a.feature" with:
      """
      Feature: a feature
        Scenario: a scenario
          Given a step
      """
    Given a file named "cypress/integration/b.feature" with:
      """
      Feature: another feature
        Scenario: another scenario
          Given a step
      """
    And a file named "cypress/support/step_definitions/steps.js" with:
      """
      const { Given } = require("@badeball/cypress-cucumber-preprocessor/methods");
      Given("a step", function() {})
      """
    When I run cypress
    Then it passes
    And there should be a JSON output similar to "fixtures/multiple-features.json"

  Scenario: failing step
    Given additional Cypress configuration
      """
      {
        "screenshotOnRunFailure": false
      }
      """
    And a file named "cypress/integration/a.feature" with:
      """
      Feature: a feature
        Scenario: a scenario
          Given a failing step
          And another step
      """
    And a file named "cypress/support/step_definitions/steps.js" with:
      """
      const { Given } = require("@badeball/cypress-cucumber-preprocessor/methods");
      Given("a failing step", function() {
        throw "some error"
      })
      Given("another step", function () {})
      """
    When I run cypress
    Then it fails
    And there should be a JSON output similar to "fixtures/failing-step.json"

  Scenario: undefined step
    Given additional Cypress configuration
      """
      {
        "screenshotOnRunFailure": false
      }
      """
    And a file named "cypress/integration/a.feature" with:
      """
      Feature: a feature
        Scenario: a scenario
          Given an undefined step
          And another step
      """
    And a file named "cypress/support/step_definitions/steps.js" with:
      """
      const { Given } = require("@badeball/cypress-cucumber-preprocessor/methods");
      Given("a defined step", function () {})
      """
    When I run cypress
    Then it fails
    And there should be a JSON output similar to "fixtures/undefined-steps.json"

  Scenario: pending step
    Given additional Cypress configuration
      """
      {
        "screenshotOnRunFailure": false
      }
      """
    And a file named "cypress/integration/a.feature" with:
      """
      Feature: a feature
        Scenario: a scenario
          Given a pending step
          And another pending step
          And an implemented step
      """
    And a file named "cypress/support/step_definitions/steps.js" with:
      """
      const { Given } = require("@badeball/cypress-cucumber-preprocessor/methods");
      Given("a pending step", function () {
        return "pending";
      });
      Given("another pending step", function () {
        return "pending";
      });
      Given("an implemented step", () => {});
      """
    When I run cypress
    Then it passes
    And there should be a JSON output similar to "fixtures/pending-steps.json"

  Scenario: screenshot
    Given a file named "cypress/integration/a.feature" with:
      """
      Feature: a feature
        Scenario: a scenario
          Given a step
      """
    And a file named "cypress/support/step_definitions/steps.js" with:
      """
      const { Given } = require("@badeball/cypress-cucumber-preprocessor/methods");
      Given("a step", function () {
        cy.visit("index.html");
        cy.get("div").screenshot();
      });
      """
    And a file named "index.html" with:
      """
      <!DOCTYPE HTML>
      <style>
        div {
          background: red;
          width: 20px;
          height: 20px;
        }
      </style>
      <div />
      """
    When I run cypress
    Then it passes
    And there should be a JSON output similar to "fixtures/screenshot.json"
