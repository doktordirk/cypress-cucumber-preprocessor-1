import { When, Then } from "@badeball/cypress-cucumber-preprocessor/methods";

When("I visit duckduckgo.com", () => {
  cy.visit("https://duckduckgo.com/");
});

Then("I should see a search bar", () => {
  cy.get("input").should(
    "have.attr",
    "placeholder",
    "Search the web without being tracked"
  );

  assert.deepEqual({}, {});
});
