Feature: Spotify Karate-Cucumber UI Testing
  Background:
    *  configure driver = { type: 'chromedriver', executable: 'src/test/java/resources/chromedriver.exe' }

  Scenario:UI Testing
    Given driver 'https://open.spotify.com/'
    And driver.maximize()
    And click('#VpYFchIiPg3tPhBGyynT')
    * delay(2000)
    * scroll('#login-button')
    And input('#login-username','veyseloner23@gmail.com')
    * delay(2000)
    And input('#login-password','Veysel23.')
    * delay(2000)
    And click('#login-button')
    * delay(4000)
    And click("//button[@data-testid='create-playlist-button']")
    * delay(4000)
    And waitFor('.Type__TypeElement-goli3j-0.hVBZRJ').click()
    * delay(4000)
    And input("//input[@data-testid='playlist-edit-details-name-input']"," ")
    * delay(4000)
    And input("//input[@data-testid='playlist-edit-details-name-input']",'MentorLabs Challenge')
    * delay(300)
    And waitFor("//button[@data-testid='playlist-edit-details-save-button']").click()
    * delay(2000)
    And input('.Type__TypeElement-goli3j-0.ebHsEf.l42JW4EP_5CU1Ba7jYIc','Daft Punk')
    * delay(2000)
    And waitFor("//button[@data-testid='add-to-playlist-button']").click()
    Then position("//div[@data-testid='tracklist-row']/div[1]")
    * delay(2000)

