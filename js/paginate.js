const picPerPage = 10;
var imgCount = document.getElementById("Count").getAttribute("count")
var pageNums = ~~(imgCount/picPerPage);
if (imgCount/picPerPage != pageNums) {
    pageNums++;
}
update(1)

function updatePageLinks(cur_id) {
    var pageLinksList = document.getElementsByClassName("pageLinks")
    for (var p = 0; p < pageLinksList.length; p++) {
        var pageLinks = pageLinksList[p]
        pageLinks.innerHTML = ""
        for (var i = 1; i <= pageNums; i++) {
            if (i == cur_id) {
                pageLinks.innerHTML += '<a class="page-current">' + i + '</a>';
                continue;
            }
            pageLinks.innerHTML += '<a href="#" onclick="update(this.innerHTML)">' + i + '</a>';
        }
    }
}

function update(a_id) {
    updatePageLinks(a_id)

    var offset = picPerPage*(a_id - 1)
    var imgs = document.getElementById("imgs")
    imgs.innerHTML = ""
    for (var i = offset + 1; i <= offset + picPerPage && i <= imgCount; i++) {
        imgs.innerHTML += '<p><img src="' + i.toString().padStart(3, "0") + '.jpg"></p>'
    }
}
