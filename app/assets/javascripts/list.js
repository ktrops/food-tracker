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



  $(".userProductInput").each(function(){
    $(this).datepicker({
        dateFormat:"yy-mm-dd",
        onSelect: function(dateText, inst) {
        var id = $(this).attr("id");
        var value = dateText
        var payload = {user_product:{id:id, dop_expiration_date_min:value}};
        console.log(payload);
        $.ajax({
          url: '/user_products/date',
          type: 'PATCH',
          data: payload,
          error: function(jqXHR, textStatus, errorThrown) {
            console.log(textStatus, errorThrown);
          },
          complete: function() {
            console.log("Date updated");
          }
        })
      }
    })
  })

})




















