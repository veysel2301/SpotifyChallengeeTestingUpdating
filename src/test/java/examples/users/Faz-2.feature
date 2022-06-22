Feature: Faz 2
  Background:
    * configure driver = { type: 'chromedriver', executable: 'src/test/java/resources/chromedriver.exe' }
    * def userid = 'hd5mvu4goazdxz6jzzcl31q5j'

    * def apiToken = 'BQA_Qcp_7XMvyKAm4-96Wfy_3hV0tk1w5A1IHMlpNZGENp8fkDXgijkOHf8k_fevHf9zVsftgoGmM510u6ctz6bjXPp1V9OfWfLCVG9L_KfwXTdZy947ShGT9XDaU31OjX0nGIvfIs1ciX1x-aCNPf6HXPmZZ3TVW9dvujvuMQY_ZhCcpkuY78rmrQz5HESe-NYhND4b1x5LLPC4nCxint2kWPuF6y-RrMmruOcHVoXStxZus1ssvGXLUlGEenolEYcute7qC5vGMo7G7lgkd2cAXJnSjXWYuK3Au1Ms'
    * def requestbodyfaz2 =
    """
    {
  "name": "MentorLabs Faz2",
  "description": "MentorLabs Faz2 description",
  "public": false
}
    """
  Scenario: Faz -2 API and UI testing
    Given driver 'https://open.spotify.com/'
    And driver.maximize()
    And click("//button[@data-testid='login-button']")
    * scroll('#login-button')
    And input('#login-username','veyseloner23@gmail.com')
    * delay(2000)
    And input('#login-password','Veysel23.')
    * delay(2000)
    And click('#login-button')
    * delay(2000)
    And url 'https://api.spotify.com/v1/'
    And driver.refresh()
    And path '/users/'+userid+'/playlists'
    And header Authorization = 'Bearer ' +apiToken
    And request requestbodyfaz2
    When method post

    * def playlist_id = response.id
    And url 'https://api.spotify.com/v1/'
    And path '/search'
    And header Authorization = 'Bearer ' +apiToken
    And header Content-Type = 'application/json'
    And params {q:'The Final Countdown (Expanded Edition)',type:'track'}
    When method get
    * def trackUri = response.tracks.items[0].uri
    And def requestAdditembody = {uris:[#(trackUri)]}
    And url 'https://api.spotify.com/v1/'
    And path '/playlists/'+playlist_id+'/tracks'
    And header Authorization = 'Bearer ' +apiToken
    And header Content-Type = 'application/json'
    And request requestAdditembody
    When method post
    And click("//div[@class='AINMAUImkAYJd4ertQxy'][1]")
    And click("//button[@data-testid='play-button']")
    * delay(30000)
    And url 'https://api.spotify.com'
    And path 'v1/me/player/currently-playing'
    And header Authorization = 'Bearer ' +apiToken
    And method get
    * def songPlaying = karate.jsonPath(response,"$.['item'].['name']")
    Then match songPlaying == 'The Final Countdown'
