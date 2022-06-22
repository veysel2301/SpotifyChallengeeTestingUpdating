Feature: Apı Testing

  Background:
    * def urlHome = 'https://open.spotify.com/'
    * def userid = 'hd5mvu4goazdxz6jzzcl31q5j'
    *  def requestbody = createPlaylistBody
    * def apiToken = 'BQDBbmzl168Sa91mpiWicGliQfT-d7g2dNL0HbS7n7ZJ-0BpRyazLNhqzmZlUeZy40LDPyUtbn1T3XTgf-IJt-EXHwBSgIRJ_F578zDTgjT1dK-7Yu0jBHhpHiB7eqve6n-F1MsqaL1XX8U1sZlL5XVPY4HS5YojoFhm3NKhbP-9AzhUvSIIEQh1zXgZC2jYPT5eMhHhzBrPZ80A5GwLhcWqx3aNy-DFA-GkNz2GCFZ9uhoVV3DQp5EOHu5GBl-P1bXrl_X6eJV8dayVafmdYOxF1_Tw14uwbkA'

  Scenario: MentorLabs API Testing
    Given url 'https://api.spotify.com/v1/'
    And path '/users/'+userid+'/playlists'
    And header Authorization = 'Bearer ' +apiToken
    And request requestbody
    When method post
    * def playlist_id = response.id
    And url 'https://api.spotify.com/v1/'
    And path '/search'
    And header Authorization = 'Bearer ' +apiToken
    And header Content-Type = 'application/json'
    And params {q:'Bohemian Rhapsody',type:'track'}
    When method get
    * def trackUri = response.tracks.items[10].uri
    And def requestAdditembody = {uris:[#(trackUri)]}
    And url 'https://api.spotify.com/v1/'
    And path '/playlists/'+playlist_id+'/tracks'
    And header Authorization = 'Bearer ' +apiToken
    And header Content-Type = 'application/json'
    And request requestAdditembody
    When method post




