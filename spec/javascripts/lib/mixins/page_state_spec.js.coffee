define ['public/assets/javascripts/lib/mixins/page_state.js'], (withPageState) ->

  describe 'withPageState', ->

    withPageState = new withPageState()

    describe 'Has Filtered', ->

      describe 'by subpath', ->
        beforeEach ->
          spyOn(withPageState, "withinFilterUrl").and.returnValue(true)

        it 'returns true for hasFiltered', ->
          expect(withPageState.hasFiltered()).toBe(true)

      describe 'by querystring', ->
        beforeEach ->
          spyOn(withPageState, "withinFilterUrl").and.returnValue(false)
          spyOn(withPageState, "getParams").and.returnValue("/england/london/hotels?filters=foo")

        it 'returns true for hasFiltered', ->
          expect(withPageState.hasFiltered()).toBe(true)

    describe 'Has not Filtered', ->

      describe 'by subpath', ->
        beforeEach ->
          spyOn(withPageState, "withinFilterUrl").and.returnValue(false)

        it 'returns true for hasFiltered', ->
          expect(withPageState.hasFiltered()).toBe(false)

      describe 'by querystring', ->
        beforeEach ->
          spyOn(withPageState, "withinFilterUrl").and.returnValue(false)
          spyOn(withPageState, "getParams").and.returnValue("/england/london/hotels?search=foo")

        it 'returns true for hasFiltered', ->
          expect(withPageState.hasFiltered()).toBe(false)


    describe 'Has Searched', ->

      describe 'by querystring', ->
        beforeEach ->
          spyOn(withPageState, "getParams").and.returnValue("/england/london/hotels?search=foo")

        it 'returns true for hasSearched', ->
          expect(withPageState.hasSearched()).toBe(true)

      describe 'by querystring', ->
        beforeEach ->
          spyOn(withPageState, "getParams").and.returnValue("/england/london/hotels?filters=foo")

        it 'returns true for hasSearched', ->
          expect(withPageState.hasSearched()).toBe(false)


    describe 'Get Document Root', ->

      describe 'within a subcategory url', ->
        beforeEach ->
          spyOn(withPageState, "withinFilterUrl").and.returnValue(true)

        it 'in hotels', ->
          expect(withPageState.createDocumentRoot("/england/london/hotels/rated")).toBe("/england/london/hotels")
          expect(withPageState.createDocumentRoot("/england/london/hotels/apartments")).toBe("/england/london/hotels")
          expect(withPageState.createDocumentRoot("/england/london/hotels/5-star")).toBe("/england/london/hotels")

        it 'in things to do', ->
          expect(withPageState.createDocumentRoot("/england/london/things-to-do/snowboarding")).toBe("/england/london/things-to-do")

      describe 'without a subcategory url', ->
        beforeEach ->
          spyOn(withPageState, "withinFilterUrl").and.returnValue(false)

        it 'in hotels', ->
          expect(withPageState.createDocumentRoot("/england/london/hotels/")).toBe("/england/london/hotels/")

        it 'in things to do', ->
          expect(withPageState.createDocumentRoot("/england/london/things-to-do/")).toBe("/england/london/things-to-do/")
