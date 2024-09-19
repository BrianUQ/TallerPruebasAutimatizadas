package stepdefinitions;

import io.cucumber.java.en.*;
import io.jsonwebtoken.*;
import io.restassured.RestAssured;
import io.restassured.response.Response;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;


public class LoginSteps {
    private Response response;
    private String username;
    private String password;

    @Given("I have a valid credentials")
    public void i_have_a_valid_username_and_password() {
        username = "valid_user";
        password = "valid_password";
    }

    @When("I send a POST request to the login endpoint")
    public void i_send_a_post_request_to_the_login_endpoint() {
        String requestBody = "{" +
                "\"username\": \"" + username + "\"," +
                "\"password\": \"" + password + "\"" +
                "}";
        response = RestAssured.given()
                .baseUri("http://localhost:8080") // Reemplaza con tu URL base
                .contentType("application/json")
                .body(requestBody)
                .post("/login");
    }

    @Then("I should receive a successful message")
    public void i_should_receive_a_200_status_code() {
        response.then().statusCode(200);
    }

    @And("I should receive an access token")
    public void i_should_receive_an_access_token() {
        String accessToken = response.jsonPath().getString("token");
        String secretKey = "tu_clave_secreta";

        // Check for presence and format
        assertNotNull(accessToken);
        assertTrue(accessToken.matches("^Bearer .+$")); // Assuming JWT format

        // Verify token claims
        Jwts.parser()
                .setSigningKey(secretKey) // Replace with your secret key
                .parseClaimsJws(accessToken.replace("Bearer ", ""))
                .getBody(); // If parsing succeeds, the token is valid
    }
}
