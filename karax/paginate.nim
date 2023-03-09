import karax/vstyles, std/[dom, strformat, strutils, sugar]

include karax/prelude

let imagesPerPage = 10
let sidePages = 5
let numOfImages = parseInt($getElementById("Count").getAttribute("count"))
var curPage = 1
var numOfPages = numOfImages div imagesPerPage
if float(numOfPages) != numOfImages / imagesPerPage:
  numOfPages += 1

proc imageList(): VNode =
  let start = (curPage-1)*imagesPerPage+1
  let ends = min(start+imagesPerPage-1, numOfImages)

  result = buildHtml(tdiv):
    for img in (start..ends):
      tdiv(style = "text-align: center;".toCss):
        img(src = fmt"{img:03d}.jpg")

proc pageList(): VNode =
  var
    startPage = 0
    endPage = 0
  startPage = min(curPage-sidePages, numOfPages-2*sidePages)
  startPage = max(1, startPage)
  endPage = max(curPage+sidePages, startPage+2*sidePages)
  endPage = min(numOfPages, endPage)

  result = buildHtml(tdiv(style = "margin:2.8em auto".toCss)):
    ul(class = "pagination justify-content-center"):
      for pageNum in (startPage..endPage):
        li(class = (if pageNum ==
                curPage: "page-item active" else: "page-item")):
          a(class = "page-link", href = "#", id = $pageNum,
                  onclick = (e: Event, n: VNode) => (
                          curPage = parseInt(n.id))):
            let textStyle = (if pageNum == 1 or pageNum ==
                    numOfPages: "color: red" else: "")
            tdiv(style = textStyle.toCss):
              text $pageNum

proc createDom(): VNode =
  result = buildHtml(tdiv):
    pageList()
    imageList()
    pageList()

setRenderer createDom
