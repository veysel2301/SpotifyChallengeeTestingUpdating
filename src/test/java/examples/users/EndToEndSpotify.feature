Feature: EndToEnd
  Background:
    * configure driver = { type: 'chromedriver', executable: 'src/test/java/resources/chromedriver.exe' }
    * def userid = 'hd5mvu4goazdxz6jzzcl31q5j'
    * def apiToken = 'BQB5iwZQhfcYGb1FS1cJ77THdc5lW6DhfPzRYi0iEGkq-_Zir3UqlwMD14lLEEHniVq_b8bC99klxfklmFp1F_Dq8C8jFKfpW43wuIT-C-p7-ChOFZETvQbrmvYuFryEVjb6c5x3U5mXFUjc04JEdF8aeoBkNEDr0uRuwmrRh5X5uqLt6I7YI_CqgFg9ykbsz-zjs2iIDWyd2TqZcO0xkZqLbd5kJk-eT-mKRVxKPJLAgie3u45jk22iKdv0vV_7Nvk3aQKOkVwbdkkk_CTOC_rtFuWARAONG_i_FlfD'
  * def requestbodyHappy =
    """
    {
  "name": "MentorLabs Happy hour",
  "description": "MentorLabs Happy hour description",
  "public": false
}
    """
  Scenario: End to End Scenario Faz-2
    #Chrome girilir ve Başarılı bir giriş yapılır
    Given driver 'https://open.spotify.com/'
    And driver.maximize()
    And waitFor("//button[@data-testid='login-button']").click()
    * scroll('#login-button')
    And input('#login-username','veyseloner23@gmail.com')
    * delay(2000)
    And input('#login-password','Veysel23.')
    * delay(2000)
    And waitFor('#login-button').click()
    * delay(2000)
    #MentorLabs Hour Playlisti oluşturulur.
    And url 'https://api.spotify.com/v1/'
    And path '/users/'+userid+'/playlists'
    And header Authorization = 'Bearer ' +apiToken
    And request requestbodyHappy
    When method post

    * def playlist_id = response.id
    And url 'https://api.spotify.com/v1/'
    And path '/search'
    And header Authorization = 'Bearer ' +apiToken
    And header Content-Type = 'application/json'
    And params {q:'Yeah! (feat. Lil Jon & Ludacris)',type:'track'}
    When method get
    * def trackUri = response.tracks.items[0].uri
    And def requestAdditembody = {uris:[#(trackUri)]}
    And url 'https://api.spotify.com/v1/'
    And path '/playlists/'+playlist_id+'/tracks'
    And header Authorization = 'Bearer ' +apiToken
    And header Content-Type = 'application/json'
    And request requestAdditembody
    When method post
    #Yeah! (feat. Lil Jon & Ludacris) parçası oynatılır 10 sn çalıştırılıp durdurulur.
    And click("//div[@class='JUa6JJNj7R_Y3i4P8YUX']/div[2]/div[1]/li/div")
    * delay(2000)
    And waitFor('.ButtonInner-sc-14ud5tc-0.gHYQaG.encore-bright-accent-set').click()
    * delay(10000)
    And waitFor('.ButtonInner-sc-14ud5tc-0.gHYQaG.encore-bright-accent-set').click()

    #Çalınan parçanın kontrolü yapılır.
    And url 'https://api.spotify.com'
    And path 'v1/me/player/currently-playing'
    And header Authorization = 'Bearer ' +apiToken
    And method get
    * def songPlaying = karate.jsonPath(response,"$.['item'].['name']")
    Then match songPlaying == 'Yeah! (feat. Lil Jon & Ludacris)'

    #Mentorlabs Faz-2 playlistine gidilir.
    And click("//a[@class='standalone-ellipsis-one-line utSR0FVkHnII_aL8TOcu']/span[contains(text(),'MentorLabs Faz2')]")
    And waitFor('.T0anrkk_QA4IAQL29get.mYN_ST1TsDdC6q1k1_xs').click()
    #The Final Countdown şarkısı MentorLabs Apı playlistine atılır.
    And mouse().move("//ul[@class='SboKmDrCTZng7t4EgNoM']/li[8]").click()
    And waitFor("//button[@class='wC9sIed7pfp47wZbmU6m']/span[contains(text(),'MentorLabsAPI')]").click()
    #Şarkının eklendiği kontrol edilir.
    And waitFor("//div[contains(text(),'Çalma Listesine eklendi')]")
    #MentorLabs Apı playlistine gidilir.
    And click("//a[@class='standalone-ellipsis-one-line utSR0FVkHnII_aL8TOcu']/span[contains(text(),'MentorLabsAPI')]")
    * delay(4000)
    #İlk Şarkı Silinir
    And waitFor('.T0anrkk_QA4IAQL29get.mYN_ST1TsDdC6q1k1_xs').click()
    And mouse().move("//ul[@class='SboKmDrCTZng7t4EgNoM']/li[7]").click()
    #Anasayfaya Gidilir.
    And click("//ul[@class='RSg3qFREWrqWCuUvDpJR']/li/a/span[text()='Ana sayfa']")
    * delay(2000)
    #Ruh hali kategorisine tıklanır ve Mutlu Türkçe Şarkılar playlistine tıklanır
    And click("//div[@class='onVWL7MW4PW9FyVajBAc']/h2/a[text()='Ruh Hali']")
    And mouse().move("//div[@class='iKwGKEfAfW7Rkx2_Ba4E Z4InHgCs2uhk0MU93y_a BtbiwMynlB4flsYu_hA2']/div[2]").click()
    #İlk Parça oynatılır ve 10 sn sonra durdurulur.
    And click('.ButtonInner-sc-14ud5tc-0.gHYQaG.encore-bright-accent-set')
    * delay(10000)
    And click('.ButtonInner-sc-14ud5tc-0.gHYQaG.encore-bright-accent-set')
    #MentorLabsChallenge playlistine tıklanır.

    And waitFor("//a[@class='standalone-ellipsis-one-line utSR0FVkHnII_aL8TOcu']/span[contains(text(),'MentorLabs Challenge')]").click()

    And waitFor("//div[@class='JUa6JJNj7R_Y3i4P8YUX']/div[2]/div[3]/li/div").click()

    #Give Me Everything adlı parça eklenir
    And click('.Type__TypeElement-goli3j-0.dhAODk')
    And input('.Type__TypeElement-goli3j-0.ebHsEf.l42JW4EP_5CU1Ba7jYIc','Give Me  Everything')
    And waitFor('.HcMOFLaukKJdK5LfdHh0>.Button-y0gtbx-0.jjUWAm').click()
    When waitFor("//div[contains(text(),'Çalma Listesine eklendi')]")
    #İlk Parça silinir
    And click('.T0anrkk_QA4IAQL29get.mYN_ST1TsDdC6q1k1_xs')
    And waitFor("//span[contains(text(),'Bu çalma listesinden kaldır')]").click()
    #  Playlistteki şarkı oynatılır
    And waitFor('.ButtonInner-sc-14ud5tc-0.gHYQaG.encore-bright-accent-set').click()
    * delay(10000)
    Then print 'Test Başarıyla Tamamlandı'



