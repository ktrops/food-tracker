$(document).ready(function () {
  var rowNum = 0
  $("#addAnother").click(function( event ) {
    rowNum++
    var $formControlLast = $(".form-group").last();
    var $nextFormControl = $formControlLast.clone();
    $formControlLast.after($nextFormControl);
    var $selectLastInput = $(".inputItem").last();
    var $selectLastLabel = $(".labelItem").last();
    $selectLastLabel.attr("for", "product_name" + rowNum);
    $selectLastInput.attr("id", "product_name" + rowNum);
    // var $lastDiv = $()
    // var nextHtmlLabel = $selectLastLabel.clone();
    // $($selectLastInput).after(nextHtmlLabel);

    // var $selectLatestLabel = $(".labelItem").last()
    // var nextHtmlInput = $selectLastInput.clone();
    // console.log(nextHtmlInput);
    $selectLastInput.val("");
    // $($selectLatestLabel).after(nextHtmlInput);

  })

  $('input[data-autocomplete]').bind('autocompletechange', function(event, data){
  /* Do something here */
  conole.log(data.item.id);
});



  $(".draggable").draggable({
      // helper: "clone",
      revert: "invalid",
      snap: $(".droppable").prev(),
      snapMode: "outer",
      start: function() {
        var draggedThing = $(this);
      }
      // start: function(event, ui) {
      //   c.tr = this;
      //   c.helper = ui.helper;
      // }
    });

  $(".droppable").droppable({

    activeClass: "ui-state-default",
    hoverClass: "ui-state-hover",
    drop: function( event, ui) {
      console.log("I've dropped");
      var dropPlace = $(this).clone();
      var table = $(this).parents();
      $(table).append(dropPlace);
      $(this).attr("class", "draggable");
      var table = $(this).parent().attr("id");
      var id = ui.draggable.children(".date").children("form").children(".userProductInput").attr("id");
      var location = table.match(/^[^_]+(?=_)/);
      var payload = {user_product: {id: id, location: location[0]}}
      $.ajax({
        url: "user_product/change_location",
        type: "PATCH",
        data: payload,
        error: function(jqXHR, textStatus, errorThrown) {
          console.log(textStatus, errorThrown);
        },
        complete: function() {
            console.log("Date updated");
            window.location.reload();
        }

      })
      // var item = ui.draggable.text();
      // $(this).val(item);

      // $(c.tr).remove();
      // $(c.helper).remove();
    }
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

  // $("#importItems").click(function(event) {
  //   event.preventDefault();
  //   // var name = $(this).attr("product")
  //   // console.log($(this).attr());
  //   // var payload = $(this).parents().serialize()

  //   $.ajax({
  //     type:'POST',
  //     // url: '/product_check',
  //     url: "/user/:user_id/list",
  //     data: $(this).parents().serialize(),
  //     success: function(products) {
  //       console.log(products);
  //       // if (products.length > 1) {
  //       //   $("#aboutModal").html(product_form)
  //       //   $.post({
  //       //     url: '/product_form',
  //       //     success: function(product_form) {

  //       //     }
  //         }
  //         // $.get "product_form/{product_name}"
  //         //  success: function(product_form) {
  //         //  $("#aboutModal").html(product_form)

  //       // $("#aboutModal").modal();
  //       })
  //     })
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

//   })

// })




















