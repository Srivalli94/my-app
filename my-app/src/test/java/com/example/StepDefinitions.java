package com.example;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;

public class StepDefinitions {
    @Given("the application is running")
    public void the_application_is_running() {
        // Step implementation
    }

    @Then("it should print Hello, OpenShift!")
    public void it_should_print_hello_openshift() {
        System.out.println("Hello, OpenShift!");
    }
}

