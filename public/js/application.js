$(document).ready(function() {
  $("#deck_id").change(function(){
    var selected = this.value;
    if(selected == "new_deck"){
      $('<input class="text-input" type="text" id="new_deck_field" name="custom_deck_id" placeholder="New Deck Name">').insertAfter('#deck_id');
      $("#create_deck_button").attr("value", "Create Deck!")
    }
    if(selected != "new_deck"){
      $("#new_deck_field").remove();
    }
  });

  var cardCount = 2;

  $("#add_nother_card").click(function(){
    event.preventDefault();
    $(".new_card_text").append('<div><textarea cold="50" rows="5" id="question' + cardCount + '" class="text-input" type="text" name="question[' + cardCount + ']" placeholder="Question"></textarea></div><div><input class="text-input" id=answer' + cardCount + ' type="text" name="answer[' + cardCount + ']" placeholder="Answer"></div>');
    cardCount++
  })

  $("#create_deck_button").click(function(){
    if($("#new_deck_field").val() === ""){
      alert("Please enter a name for your new deck.")
      event.preventDefault();
      return
    };
    for(var i = 1; i < cardCount; i++){
      var current_question = "#question" + i
      var current_answer = "#answer" + i
      if($("#question" + i).val() === "" || $("#answer" + i).val() === ""){
        alert("Please fill in all of your questions and answers.")
        event.preventDefault();
        return
      };
    };
  })
});





















