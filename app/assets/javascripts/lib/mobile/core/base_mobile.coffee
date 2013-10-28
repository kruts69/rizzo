define ['jsmin', 'lib/mobile/core/authenticator_mobile','lib/mobile/core/shopping_cart_mobile', 'lib/mobile/select_group_manager_mobile', 'lib/utils/asset_fetch', 'lib/utils/local_store'], ($, Authenticator, ShoppingCart, SelectGroup, AssetFetch, LocalStore) ->

  class Base

    constructor: (args={})->
      @authenticateUser()
      @showUserBasket()
      @initialiseFooterSelects()
      @initialiseResponsiveNavSelect()
      @addNavTracking()
      @scrollPerf() unless window.lp.touch is true


    authenticateUser: ->
      @auth = new Authenticator()
      AssetFetch.get "https://secure.lonelyplanet.com/sign-in/status", () =>
        @auth.update()

    showUserBasket: ->
      shopCart = new ShoppingCart()

    initialiseFooterSelects: ->
      countrySelect = new SelectGroup '.js-select-country'
      languageSelect = new SelectGroup '.js-select-language', ->
        document.getElementById('js-language').submit()

    initialiseResponsiveNavSelect: ->
      languageSelect = new SelectGroup '#js-responsive-nav', ($this)->
        window.location = "http://www.lonelyplanet.com/" + $this.options[$this.selectedIndex].value

    addNavTracking: ->
      $('#js-primary-nav').on 'click', (e)->
        if e.target.hasClass('js-nav-item') then window.s.linkstacker(e.target.innerText)
        if e.target.hasClass('js-nav-cart') then window.s.linkstacker("shopping-cart")

      $('#js-primary-nav').on 'submit', (e)->
        if e.target.hasClass('js-nav-search') then window.s.linkstacker("search")

      $('#js-secondary-nav').on 'click', (e)->
        if e.target.hasClass('js-nav-item') then window.s.linkstacker(e.target.innerText + "-sub")

      $('#js-breadcrumbs').on 'click', (e)->
        if e.target.hasClass('js-nav-item') then window.s.linkstacker("breadcrumbs")

      $('#js-footer-nav').on 'click', (e)->
        if e.target.hasClass('js-nav-item') then window.s.linkstacker("footer")

    scrollPerf: ->
      document.body.classList.add('js-hover')
      enableTimer = false

      window.addEventListener 'scroll', ->
        clearTimeout(enableTimer);
        document.body.classList.remove('js-hover')
        enableTimer = setTimeout ->
          document.body.classList.add('js-hover')
        , 500
      , false

