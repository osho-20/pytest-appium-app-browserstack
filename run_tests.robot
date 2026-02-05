*** Settings ***
Documentation    Robot Framework wrapper for BrowserStack Pytest execution
Library          Process
Library          OperatingSystem

*** Variables ***
${SCRIPT_PATH}    ${CURDIR}/script.sh
${TIMEOUT}        30 minutes

*** Test Cases ***
Execute BrowserStack Pytest Tests
    [Documentation]    Run the bash script to execute pytest tests on BrowserStack
    [Tags]    browserstack    android    pytest
    
    Log    Starting BrowserStack pytest execution    console=True
    Log    Working directory: ${CURDIR}    console=True
    
    # Get BrowserStack credentials from environment
    ${BROWSERSTACK_USERNAME}=    Get Environment Variable    BROWSERSTACK_USERNAME    default=NOT_SET
    ${BROWSERSTACK_ACCESS_KEY}=    Get Environment Variable    BROWSERSTACK_ACCESS_KEY    default=NOT_SET
    
    Log    BrowserStack Username: ${BROWSERSTACK_USERNAME}    console=True
    Log    BrowserStack Key configured: ${'Yes' if $BROWSERSTACK_ACCESS_KEY != 'NOT_SET' else 'No'}    console=True
    
    # Ensure script has execute permissions
    Run    chmod +x ${SCRIPT_PATH}
    
    # Execute the bash script from the project directory with environment variables
    ${result}=    Run Process    bash    ${SCRIPT_PATH}
    ...    cwd=${CURDIR}
    ...    timeout=${TIMEOUT}
    ...    stdout=${CURDIR}/robot_stdout.log
    ...    stderr=${CURDIR}/robot_stderr.log
    ...    shell=False
    ...    env:BROWSERSTACK_USERNAME=${bs_username}
    ...    env:BROWSERSTACK_ACCESS_KEY=${bs_key}
    
    # Log output for debugging
    Log    STDOUT:\n${result.stdout}    console=True
    Log    STDERR:\n${result.stderr}    console=True
    Log    Exit Code: ${result.rc}    console=True
    
    # Check exit code - fail if non-zero
    Run Keyword If    ${result.rc} != 0    Fail    Pytest execution failed with exit code ${result.rc}. Check logs for details.
    
    Log    BrowserStack pytest execution completed successfully    console=True

*** Keywords ***
# Add custom keywords here if needed
