store Message.Store {
  state page = 0
  state perPage = 10
  state total = 0
  state pages = []

  fun setPage (p : Number) {
    sequence {
      next { page = -1 }
      Window.setScrollTop(0)
      next { page = p }
    }
  }

  fun init {
    sequence {
      next { total = `Number(document.getElementById("Count").getAttribute("count"))` as Number }
      next { pages = Array.map((number : Number) : String { String.padLeft("0", 3, Number.toString(number)) + ".jpg" }, Array.range(1, total)) }
    }
  }
}

routes {
  * {
    Message.Store.init()
  }
}

component Text {
  connect Message.Store exposing { page, perPage, pages }

  fun render : Html {
    <>
      for (img of Maybe.withDefault([], Array.groupsOf(perPage, pages)[page])) {
        <img src={img}/>
      }
    </>
  }
}

component Main {
  connect Message.Store exposing { total, page, setPage, perPage }

  fun render : Html {
    <div>
      <Ui.Theme.Root
        tokens={Ui:DEFAULT_TOKENS}
        fontConfiguration={Ui:DEFAULT_FONT_CONFIGURATION}>

        <Ui.Layout.Centered>
          <Ui.Container
            orientation="vertical"
            gap={Ui.Size::Em(2.8)}>

            <Ui.Pagination
              page={page}
              perPage={perPage}
              onChange={setPage}
              total={total}/>

            <Text/>

            <Ui.Pagination
              page={page}
              perPage={perPage}
              onChange={setPage}
              total={total}/>

          </Ui.Container>
        </Ui.Layout.Centered>

      </Ui.Theme.Root>
    </div>
  }
}
