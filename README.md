# cypress-cucumber-preprocessor

[![Build status](https://github.com/badeball/cypress-cucumber-preprocessor/actions/workflows/build.yml/badge.svg)](https://github.com/badeball/cypress-cucumber-preprocessor/actions/workflows/build.yml)
[![Npm package weekly downloads](https://badgen.net/npm/dw/@badeball/cypress-cucumber-preprocessor)](https://npmjs.com/package/@badeball/cypress-cucumber-preprocessor)

This preprocessor aims to provide a developer experience and behavior similar to that of [Cucumber](https://cucumber.io/), to Cypress.

## Installation

```
$ npm install @badeball/cypress-cucumber-preprocessor
```

## Introduction

The preprocessor (with its dependencies) parses Gherkin documents and allows you to write tests as shown below.

```cucumber
# cypress/integration/duckduckgo.feature
Feature: duckduckgo.com
  Scenario: visting the frontpage
    When I visit duckduckgo.com
    Then I should see a search bar
```

```ts
// cypress/integration/duckduckgo.ts
import { When, Then } from "@badeball/cypress-cucumber-preprocessor/methods";

When("I visit duckduckgo.com", () => {
  cy.visit("https://www.duckduckgo.com");
});

Then("I should see a search bar", () => {
  cy.get("input").should(
    "have.attr",
    "placeholder",
    "Search the web without being tracked"
  );
});
```

## User guide

For further documentation see [docs](docs/readme.md) and [docs/quick-start.md](docs/quick-start.md).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## Building

Building can be done once using:

```
$ npm run build
```

Or upon file changes with:

```
$ npm run watch
```

There are multiple types of tests, all ran using npm scripts:

```
$ npm run test:fmt
$ npm run test:types
$ npm run test:unit
$ npm run test:integration # make sure to build first
$ npm run test # runs all of the above
```
