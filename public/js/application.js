$(document).ready(function() {
  $("#deck_id").change(function(){
    var selected = this.value;
    if(selected == "new_deck"){
      $('<input class="text-input" type="text" name="custom_deck_id" placeholder="New Deck Name">').insertAfter('#deck_id');
    }
  });

  var cardCount = 2;

  $("#add_nother_card").click(function(){
    event.preventDefault();
    $(".new_card_text").append('<div><input class="text-input" type="text" name="question[' + cardCount + ']" placeholder="Question"></div><div><input class="text-input" type="text" name="answer[' + cardCount + ']" placeholder="Answer"></div>');
    cardCount++
  })
});
