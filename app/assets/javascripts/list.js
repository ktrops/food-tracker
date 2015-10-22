$(document).ready(function () {
  var rowNum = 0
  $("#addAnother").click(function( event ) {
    rowNum++
    var $selectLastInput = $(".inputItem").last();
    var $selectLastLabel = $(".labelItem").last();
    var nextHtmlLabel = $selectLastLabel.clone();
    nextHtmlLabel.attr("for", "product_name" + rowNum);
    console.log(nextHtmlLabel);
    $($selectLastInput).after(nextHtmlLabel);

    var $selectLatestLabel = $(".labelItem").last()
    var nextHtmlInput = $selectLastInput.clone();
    nextHtmlInput.attr("id", "product_name" + rowNum);
    $($selectLatestLabel).after(nextHtmlInput);

  })

})
