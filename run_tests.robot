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
    
    # Ensure script has execute permissions
    Run    chmod +x ${SCRIPT_PATH}
    
    # Execute the bash script
    ${result}=    Run Process    bash    ${SCRIPT_PATH}
    ...    shell=True
    ...    timeout=${TIMEOUT}
    ...    stdout=${CURDIR}/robot_stdout.log
    ...    stderr=${CURDIR}/robot_stderr.log
    
    # Log output
    Log    ${result.stdout}    console=True
    Log    ${result.stderr}    console=True
    
    # Check exit code
    Should Be Equal As Integers    ${result.rc}    0    msg=Pytest execution failed with exit code ${result.rc}
    
    Log    BrowserStack pytest execution completed successfully    console=True

*** Keywords ***
# Add custom keywords here if needed
