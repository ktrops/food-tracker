$(document).ready(function () {
  var rowNum = 0
  $("#addAnother").click(function( event ) {
    rowNum++
    var $selectLastInput = $(".inputItem").last();
    var $selectLastLabel = $(".labelItem").last();
    // var $formControl = $(".form-group").last();
    // var $lastDiv = $()
    var nextHtmlLabel = $selectLastLabel.clone();
    nextHtmlLabel.attr("for", "product_name" + rowNum);
    $($selectLastInput).after(nextHtmlLabel);

    var $selectLatestLabel = $(".labelItem").last()
    var nextHtmlInput = $selectLastInput.clone();
    nextHtmlInput.attr("id", "product_name" + rowNum);
    console.log(nextHtmlInput);
    nextHtmlInput.val("");
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

  $("#importItems").click(function(event) {
    event.preventDefault();
    // var name = $(this).attr("product")
    // console.log($(this).attr());
    // var payload = $(this).parents().serialize()

    $.post({
      url: '/product_check',
      data: $(this).parents().serialize(),
      success: function(produts) {
        $("aboutModal").modal();
      }
    })
    // var $form = $(this).parents("form");
    // $.ajax({
    //   url: '/product_check',
    //   type: 'POST',
    //   data: payload,
    //   success: function(products) {
    //     // $('#aboutModal').on('show.bs.modal', function(event) {
    //        $.get('/product_check', function(data) {
    //        $("#aboutModal").modal(data);
    //      }
           // $.ajax({
           //  url: '/product_select',
           //  type: 'POST',
           //  data: {products:products},
           //  success: function(selected_products) {
           //    console.log(selected_products)
           //    }
           //   })
            // }

      //   }
      // }
    // })

  })

})




















