# To Run
# 1. download selenium server
# 2. optionally download chromedriver
# 3. install jasmine node globally
#   - npm install jasmine-node -g
# 4. get node libraries
#   - cd to/materia/dir/
#   - npm install
# 5. run the selenium server:
#   - java -jar selenium-server-standalone-2.37.0.jar
#   - or with chrome: -Dwebdriver.chrome.driver=/path/to/chromedriver
# 6. run the tests
#   - jasmine-node spec/materia.spec.coffee --coffee
#   - or optional set browser: env BROWSER=chrome jasmine-node spec/materia.spec.coffee --coffee
#   
# Useful links
# https://github.com/camme/webdriverjs
# http://pivotal.github.io/jasmine/
# https://github.com/camme/webdriverjs/blob/master/examples/webdriverjs.with.jasmine.spec.js

webdriverjs = require('webdriverjs')
testBrowser = process.env.BROWSER || 'firefox' # phantomjs, firefox, 'safari'. 'chrome'
jasmine.getEnv().defaultTimeoutInterval = 30000
author =
	username: '~author'
	password: 'kogneato'
student =
	username: '~student'
	password: 'kogneato'

webdriverOptions = { desiredCapabilities: {browserName: testBrowser}, logLevel: "silent" }

console.log "Running #{testBrowser} with #{author.username} and #{student.username}"

describe 'Homepage', ->
    client = {}
    
    beforeEach ->
        client = webdriverjs.remote(webdriverOptions)
        client.init()

    afterEach (done) ->
        client.end(done)

    it 'should display correctly', (done) ->
        client
            .url('http://localhost:8080/')
            .getTitle( (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Welcome to Materia | Materia')
            )
            .waitFor('.store_main', 7000)
            .isVisible('.store_main:first-child section')
            .execute('return $(".store_main section").length;', null, (err, result) ->
                expect(err).toBeNull()
                expect(result.value).toBeGreaterThan(0)
            )
            .click('.span_next:last-child')
            .pause(1500)
            .isVisible('.store_main:last-child section')
            .pause(2000)
            .call(done)

describe 'Widget Catalog Page', ->
    client = {}
    client = webdriverjs.remote(webdriverOptions)
    client.init()

    it 'should display widgets', (done) ->
        client
            .url('http://localhost:8080/widgets')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Widget Catalog | Materia')

            # make sure the widgets get loaded
            .waitFor('.widget', 7000)
            .execute 'return $(".widget").length;', null, (err, result) ->
                expect(err).toBeNull()
                expect(result.value).toBeGreaterThan(0)
            .isVisible '.flash-cards', (err, result) ->
                expect(err).toBeNull()
                expect(result).toBe(true)
            .isVisible '.enigma', (err, result) ->
                expect(err).toBeNull()
                expect(result).toBe(true)
            .isVisible '.timeline', (err, result) ->
                expect(err).toBeNull()
                expect(result).toBe(true)
            .isVisible '.labeling', (err, result) ->
                expect(err).toBeNull()
                expect(result).toBe(true)

            # make sure the check boxes do stuff
            .click('#form_filter_tracks_student_data')
            .click('#form_filter_collects_scores')
            .pause(1500) # wait for a transition to animate
            .getElementCssProperty 'css selector', '.flash-cards.widgetMin', 'opacity', (err, opacity) ->
                expect(err).toBeNull()
                expect(parseFloat(opacity)).toBeCloseTo(0.2, 2)
            .getElementCssProperty 'css selector', '.timeline.widgetMin', 'opacity', (err, opacity) ->
                expect(err).toBeNull()
                expect(parseFloat(opacity)).toBeCloseTo(0.2, 2)
            .getElementCssProperty 'css selector', '.enigma.widgetMin', 'opacity', (err, opacity) ->
                expect(err).toBeNull()
                expect(opacity).toBe('1')
            .click('#form_supported_data_qa')
            .pause(1500)
            .getElementCssProperty 'css selector', '.enigma.widgetMin', 'opacity', (err, opacity) ->
                expect(err).toBeNull()
                expect(parseFloat(opacity)).toBeCloseTo(0.2, 2)
            .getElementCssProperty 'css selector', '.timeline.widgetMin', 'opacity', (err, opacity) ->
                expect(err).toBeNull()
                expect(parseFloat(opacity)).toBeCloseTo(0.2, 2)
            .click('#form_supported_data_media')
            .pause(1500)
            .getElementCssProperty 'css selector', '.enigma.widgetMin', 'opacity', (err, opacity) ->
                expect(err).toBeNull()
                expect(parseFloat(opacity)).toBeCloseTo(0.2, 2)
            .getElementCssProperty 'css selector', '.timeline.widgetMin', 'opacity', (err, opacity) ->
                expect(err).toBeNull()
                expect(parseFloat(opacity)).toBeCloseTo(0.2, 2)
            .getElementCssProperty 'css selector', '.labeling.widgetMin', 'opacity', (err, opacity) ->
                expect(err).toBeNull()
                expect(opacity).toBe('1')
            .click('#form_filter_tracks_student_data')
            .click('#form_filter_collects_scores')
            .click('#form_supported_data_qa')
            .click('#form_supported_data_media')
            .pause(1800)
            .getElementCssProperty 'css selector', '.enigma.widgetMin', 'opacity', (err, opacity) ->
                expect(err).toBeNull()
                expect(parseFloat(opacity)).toBeCloseTo(1, 2)
            .getElementCssProperty 'css selector', '.timeline.widgetMin', 'opacity', (err, opacity) ->
                expect(err).toBeNull()
                expect(parseFloat(opacity)).toBeCloseTo(1, 2)
            .getElementCssProperty 'css selector', '.flash-cards.widgetMin', 'opacity', (err, opacity) ->
                expect(err).toBeNull()
                expect(parseFloat(opacity)).toBeCloseTo(1, 2)
            .getElementCssProperty 'css selector', '.labeling.widgetMin', 'opacity', (err, opacity) ->
                expect(err).toBeNull()
                expect(parseFloat(opacity)).toBeCloseTo(1, 2)

            # Check mouse over info card functions
            .execute 'return $(".infocard.show").length;', null, (err, result) ->
                expect(err).toBeNull()
                expect(result.value).toBe(0)
            .moveToObject('.labeling')
            .pause(1500)
            .execute 'return $(".infocard.show").length;', null, (err, result) ->
                expect(err).toBeNull()
                expect(result.value).toBe(1)
            .call(done)
            .call -> client.end(done)

describe 'Login Page', ->
    client = {}
    
    beforeEach ->
        client = webdriverjs.remote(webdriverOptions)
        client.init()

    afterEach (done) ->
        client.end(done)

    it 'should display an error on incorrect login', (done) ->
        client
            .url('http://localhost:8080/login')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Login | Materia')
            .getText '.detail h3', (err, text) ->
                expect(err).toBeNull()
                expect(text).toContain('Using your')
            .click('form input.action_button')
            .isVisible('.error')
            .getText '.error', (err, text) ->
                expect(err).toBeNull()
                expect(text).toBe('ERROR: Username and/or password incorrect.')
            .call(done)

    it 'should blur input boxes when filled', (done) ->
        client
            .url('http://localhost:8080/login')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Login | Materia')
            .setValue('#username', 'someusername')
            .pause(1500)
            .getElementCssProperty 'id', 'username_label', 'opacity', (err, opacity) ->
                expect(err).toBeNull()
                expect(parseFloat(opacity)).toBeCloseTo(0.2, 2)
            .setValue('#password', 'somepassword')
            .pause(1500)
            .getElementCssProperty 'id', 'password_label', 'opacity', (err, opacity) ->
                expect(err).toBeNull()
                expect(parseFloat(opacity)).toBeCloseTo(0.2, 2)
            .call(done)

    it 'should relocate to my widgets on author login', (done) ->
        client
            .url('http://localhost:8080/login')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Login | Materia')
            .setValue('#username', author.username)
            .setValue('#password', author.password)
            .click('form input.action_button')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('My Widgets | Materia')
            .call(done)

    it 'should relocate to my profile on student login', (done) ->
        client
            .url('http://localhost:8080/login')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Login | Materia')
            .setValue('#username', student.username)
            .setValue('#password', student.password)
            .click('form input.action_button')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Profile | Materia')
            .call(done)

    it 'should display user info in header', (done) ->
        client
            .url('http://localhost:8080/login')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Login | Materia')
            .setValue('#username', author.username)
            .setValue('#password', author.password)
            .click('form input.action_button')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('My Widgets | Materia')
            .getText '.user', (err, text) ->
                expect(err).toBeNull()
                expect(text).toBe('Welcome Prof Author')
            .getText '.logout', (err, text) ->
                expect(err).toBeNull()
                expect(text).toBe('Logout')
            .isVisible('.user.avatar')
            .call(done)

describe 'Profile page', ->
    client = {}
    
    beforeEach ->
        client = webdriverjs.remote(webdriverOptions)
        client.init()

    afterEach (done) ->
        client.end(done)

    it 'should display profile', (done) ->
        client
            .url('http://localhost:8080/profile')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Login | Materia')
            .setValue('#username', author.username)
            .setValue('#password', author.password)
            .click('form input.action_button')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('My Widgets | Materia')
            .url('http://localhost:8080/profile')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Profile | Materia')
            .getText '.page h2', (err, text) ->
                expect(err).toBeNull()
                expect(text).toContain('Prof Author')
            .isVisible('.avatar_big')
            .getAttribute '.avatar_big img', 'src', (err, src) ->
                expect(err).toBeNull()
                expect(src).toContain('gravatar')
                expect(src).toContain('default-avatar.jpg')
                expect(src).toContain('100')
            .call(done)

describe 'When not logged in', ->
    client = {}
    client = webdriverjs.remote(webdriverOptions)
    client.init()

    it ' settings should redirect to login', (done) ->
        client
            .url('http://localhost:8080/settings')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Login | Materia')
            .call(done)

    it ' my-widgets should redirect to login', (done) ->
        client
            .url('http://localhost:8080/settings')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Login | Materia')
            .call(done)

    it ' profile should redirect to login', (done) ->
        client
            .url('http://localhost:8080/settings')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Login | Materia')
            .call(done)
            .call -> client.end(done)


describe 'Settings page', ->
    client = {}
    
    beforeEach ->
        client = webdriverjs.remote(webdriverOptions)
        client.init()

    afterEach (done) ->
        client.end(done)

    it 'should display profile', (done) ->
        client
            .url('http://localhost:8080/settings')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Login | Materia')
            .setValue('#username', author.username)
            .setValue('#password', author.password)
            .click('form input.action_button')

            # Check page state
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Settings | Materia')
            .isVisible('.avatar_big')
            .getAttribute 'form input.action_button', 'class', (err, classes) ->
                expect(err).toBeNull()
                expect(classes).toContain('disabled')

            # Reset 
            # no avatar
            # no notify
            .click('#avatar_default')
            .execute 'return $("#notify_on_perm_change:checked").length;', null, (err, isChecked) ->
                expect(err).toBeNull()
                if isChecked.value
                    client.click('#notify_on_perm_change')
            .getAttribute 'form input.action_button', 'class', (err, classes) ->
                expect(err).toBeNull()
                expect(classes).not().toContain('disabled')
            .click('form input.action_button')

            # Check that page displays expected options
            .waitFor('.settingSaveAlert', 7000)
            .isSelected('#avatar_default')
            .getAttribute '.avatar_big img', 'src', (err, src) ->
                expect(err).toBeNull()
                expect(src).not().toContain('gravatar')
                expect(src).toContain('default-avatar.jpg')
            .execute 'return $("#notify_on_perm_change:checked").length;', null, (err, isChecked) ->
                expect(err).toBeNull()
                expect(isChecked.value).toBe(0)
            .getAttribute 'header .user.avatar img', 'src', (err, src) ->
                expect(err).toBeNull()
                expect(src).not().toContain('gravatar')
                expect(src).toContain('default-avatar.jpg')

            .refresh()

            # check again that page displays expected options
            .execute "return $('#notify_on_perm_change:checked').length;", null, (err, result) ->
                expect(err).toBeNull()
                expect(result.value).toBe(0)
            .isSelected('#avatar_default')
            .getAttribute 'header .user.avatar img', 'src', (err, src) ->
                expect(err).toBeNull()
                expect(src).not().toContain('gravatar')
                expect(src).toContain('default-avatar.jpg')

            # Turn on stuff
            # gravatar yes
            # notifications yes
            .click('#avatar_gravatar')
            .click('#notify_on_perm_change')
            .click('form input.action_button')

            # check that new options are set
            .waitFor('.settingSaveAlert', 7000)
            .isSelected('#avatar_gravatar')
            .isVisible('#notify_on_perm_change:checked')
            .getAttribute '.avatar_big img', 'src', (err, src) ->
                expect(err).toBeNull()
                expect(src).toContain('gravatar')
                expect(src).toContain('default-avatar.jpg')
                expect(src).toContain('100')
            .getAttribute 'header .user.avatar img', 'src', (err, src) ->
                expect(err).toBeNull()
                expect(src).toContain('gravatar')
                expect(src).toContain('default-avatar.jpg')
                expect(src).toContain('24')

            .refresh()

            # check again that page displays expected options
            .isSelected('#avatar_gravatar')
            .isVisible('#notify_on_perm_change:checked')
            .getAttribute '.avatar_big img', 'src', (err, src) ->
                expect(err).toBeNull()
                expect(src).toContain('gravatar')
                expect(src).toContain('default-avatar.jpg')
                expect(src).toContain('100')
            # check the header too
            .getAttribute 'header .user.avatar img', 'src', (err, src) ->
                expect(err).toBeNull()
                expect(src).toContain('gravatar')
                expect(src).toContain('default-avatar.jpg')
                expect(src).toContain('24')

            .call(done)

describe 'Help Page', ->
    client = {}
    

    beforeEach ->
        client = webdriverjs.remote(webdriverOptions)
        client.init()

    afterEach (done) ->
        client.end(done)

    it 'should redirect to login when not logged in', (done) ->
        client
            .url('http://localhost:8080/help')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Help | Materia')
            .getText '.page h1', (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Help & Support')
            .call(done)

describe 'Widget Exists', ->
    client = {}
    
    beforeEach ->
        client = webdriverjs.remote(webdriverOptions)
        client.init()

    afterEach (done) ->
        client.end(done)

    it 'widget should appear on catalog', (done) ->
        client
            .url('http://localhost:8080/widgets')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Widget Catalog | Materia')
            # make sure the widgets get loaded
            .waitFor('.widget', 4000)
            .execute 'return $(".widget").length;', null, (err, result) ->
                expect(err).toBeNull()
                expect(result.value).toBeGreaterThan(0)
                currentTitle = ''

                for i in [1...result.value]
                    client
                        .waitFor('.widget', 4000)
                        .moveToObject('.widget:nth-child('+i+')')
                        .getText '.widget:nth-child('+i+') .header h1', (err, title) ->
                            expect(err).toBeNull()
                            currentTitle = title
                        .getText '.infocard .header h1', (err, infoCardTitle) ->
                            expect(err).toBeNull()
                            expect(currentTitle).toBe(infoCardTitle)
                        .click('.infocard .card-content')
                        .waitFor('.detail h1', 4000)
                        .pause 500
                        .getText '.detail h1', (err, widgetPageTitle) ->
                            expect(err).toBeNull()
                            expect(widgetPageTitle).toBe(currentTitle)
                        .back()
            .call(done)
    , 55000

describe 'When I create a widget', ->
    client = {}
    randomId = Math.random()
    title = 'Selenium Test Enigma Widget '+randomId
    cleanTitle = title.replace(' ', '-').replace('.', '-')
    instanceID = null

    # Reuse session to keep from having to log in
    client = webdriverjs.remote(webdriverOptions)
    client.init()

    it 'it should update hash url', (done) ->
        client
            .url('http://localhost:8080/widgets')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Widget Catalog | Materia')
            .waitFor('.widget.enigma', 7000)
            .moveToObject('.widget.enigma')
            .click('.infocard .card-content')
            .waitFor('#createLink', 7000)
            .click('#createLink')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Login | Materia')
            .setValue('#username', author.username)
            .setValue('#password', author.password)
            .click('form input.action_button')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Create Widget | Materia')
            .waitFor('#container', 7000)
            .frame('container') # switch into widget frame
            .waitFor('.intro.show', 7000)
            .setValue('.intro.show input', title)
            .click('.intro.show input[type=button]')
            .setValue('#category_0', 'Test')
            .click('button.add')
            .setValue('#question_text', 'Test question')
            .frame(null) # switch back to main content
            .click('#creatorSaveBtn')
            .waitFor('#saveBtnTxt:contains("Saved!")', 7000)
            .execute "return document.location.href.split('#')[1];", null, (err, result) ->
                console.log 'instance id', result.value
                instanceID = result.value
                expect(err).toBeNull()
                expect(instanceID.length).toBe(5)
            .call(done)
    , 25000

    it 'it should appear as a draft', (done) ->
        client
            .url('http://localhost:8080/my-widgets#'+instanceID)
            .pause(1000)
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('My Widgets | Materia')
            .waitFor('#widget_'+instanceID, 7000)
            .getText '#widget_'+instanceID+' .score', (err, mode) ->
                expect(err).toBeNull()
                expect(mode).toBe('Draft')
            .call(done)
    , 22000

    it 'it should display correctly on my widgets page', (done) ->
        client
            .url('http://localhost:8080/my-widgets#'+instanceID)
            .waitFor('#widget_'+instanceID, 7000)
            .pause(1000)
            .getElementCssProperty 'css selector', '.share-widget-container', 'opacity', (err, opacity) ->
                expect(err).toBeNull()
                expect(parseFloat(opacity)).toBeCloseTo(0.3, 2)
            .getElementCssProperty 'id', 'embed_link', 'display', (err, display) ->
                expect(err).toBeNull()
                expect(display).toBe('none')
            .getAttribute '#play_link', 'disabled', 'opacity', (err, disabled) ->
                expect(err).toBeNull()
                expect(disabled).toBe('disabled')
            .getText '#widget_'+instanceID+' .score', (err, mode) ->
                expect(err).toBeNull()
                expect(mode).toBe('Draft')
            .getText '.container .page h1', (err, mode) ->
                expect(err).toBeNull()
                expect(mode).toBe(title)
            .call(done)

    it 'it should collaborate', (done) ->
        client
            .url('http://localhost:8080/my-widgets#'+instanceID)
            .waitFor('#widget_'+instanceID, 7000)
            .pause(1500)
            .click('#share_widget_link')
            .waitFor('#popup', 7000)
            .isVisible('#popup')
            .getText '#popup h2', (err, text) ->
                expect(err).toBeNull()
                expect(text).toBe('Collaboration:')
            .waitFor('.access_list .user_perm', 7000)
            .execute "return $('.access_list .user_perm').length;", null, (err, result) ->
                expect(err).toBeNull()
                expect(result.value).toBe(1)
            .getText '.access_list .user_perm:first-child .name', (err, name) ->
                expect(err).toBeNull()
                expect(name).toContain('Prof Author')
            .getValue '.access_list .user_perm:first-child select.perm', (err, value) ->
                expect(err).toBeNull()
                expect(value).toBe('30')
            .getValue '.access_list .exp-date', (err, value) ->
                expect(err).toBeNull()
                expect(value).toBe('Never')
            .click('.cancel_button')
            .call(done)

    it 'it should copy', (done) ->
        copyTitle = 'Selenium Copy Test '+randomId
        client
            .url('http://localhost:8080/my-widgets#'+instanceID)
            .pause 1900
            .waitFor('#widget_'+instanceID, 7000)
            .waitFor('.widget.gameSelected li.title:contains("'+title+'")', 7000)
            .click('#copy_widget_link')
            .waitFor('#popup .newtitle', 7000)
            .isVisible('#popup')
            .getText '#popup h2', (err, text) ->
                expect(err).toBeNull()
                expect(text).toBe('Make a Copy:')
            .setValue('.newtitle', copyTitle)
            .click('.copy_button.action_button')
            # copy shows up in list
            .pause 1900
            .waitFor('li.title:contains("'+copyTitle+'")', 7000)
            # copy is auto-selected
            .pause 1900
            .waitFor('.widget.gameSelected li.title:contains("'+copyTitle+'")', 7000)
            # copy is selected and displayed on main section
            .getText '.container .page h1', (err, mode) ->
                expect(err).toBeNull()
                expect(mode).toBe(copyTitle)
            .call(done)
    , 25000

    it 'it should delete using the delete button', (done) ->
        client
            .url('http://localhost:8080/my-widgets#'+instanceID)
            .pause(2000)
            .waitFor('#widget_'+instanceID+'.gameSelected', 5000)
            .click('.controls #delete_widget_link')
            .waitFor('.controls .delete_dialogue', 5000)
            .isVisible('.delete_dialogue')
            .click('.delete_button')
            .pause(2000)
            .execute "return $('#widget_"+instanceID+"').length;", null, (err, result) ->
                expect(err).toBeNull()
                expect(result.value).toBe(1)
            .refresh()
            .waitFor('.widget', 5000)
            .pause(2000)
            .execute "return $('#widget_"+instanceID+"').length;", null, (err, result) ->
                expect(err).toBeNull()
                expect(result.value).toBe(1)
            .pause(1800)
            .isVisible('.error-nowidget')
            .call(done)
            .call -> client.end(done)
    , 25000

describe 'My Widgets Page', ->
    client = {}
    
    beforeEach ->
        client = webdriverjs.remote(webdriverOptions)
        client.init()

    afterEach (done) ->
        client.end(done)

    it 'should relocate to my widgets on author login', (done) ->
        client
            .url('http://localhost:8080/login')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Login | Materia')
            .setValue('#username', author.username)
            .setValue('#password', author.password)
            .click('form input.action_button')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('My Widgets | Materia')
            .call(done)

    it 'should display instructions by default', (done) ->
        client
            .url('http://localhost:8080/login')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('Login | Materia')
            .setValue('#username', author.username)
            .setValue('#password', author.password)
            .click('form input.action_button')
            .getTitle (err, title) ->
                expect(err).toBeNull()
                expect(title).toBe('My Widgets | Materia')
            .waitFor '.directions.unchosen p', 5000
            .getText '.directions.unchosen p', (err, text) ->
                expect(err).toBeNull()
                expect(text).toBe('Choose a widget from the list on the left.')
            .call(done)
