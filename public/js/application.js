$(document).ready(function() {
  $("#deck_id").change(function(){
    var selected = this.value;
    if(selected == "new_deck"){
      $('<input class="text-input" type="text" id="new_deck_field" name="custom_deck_id" placeholder="New Deck Name">').insertAfter('#deck_id');
      $("#create_deck_button").attr("value", "Create Deck!")
    }
    if(selected != "new_deck"){
      $("#new_deck_field").remove();
      $("#create_deck_button").attr("value", "Create Cards!")
    }
  });

  var cardCount = 2;

  $("#add_nother_card").click(function(){
    event.preventDefault();
    $(".new_card_text").append('<div class="new_card_forms"><div><textarea cols="50" rows="5" id="question' + cardCount + '" class="text-input" type="text" name="question[' + cardCount + ']" placeholder="Question"></textarea></div><div><input class="text-input" id=answer' + cardCount + ' type="text" name="answer[' + cardCount + ']" placeholder="Answer"></div></div>');
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

  $("#answer_button").click(function(){
    event.preventDefault();
    $.post("/game/question",
      {answer: $("#answer").val(),
       round_id: $("#current_round").val(),
       card_id: $("#current_card").val()
      },
      function(data){
        var dejsonified = $.parseJSON(data);
        $("#answer_area").text(dejsonified.result_text);
        if(dejsonified.exit_game === true){
          $("#question_form").append('<form action="../../game/end_game/' + dejsonified.current_round + '"><input type="submit" value="Go to results" class="btn"></form>')
        }
        else{
        $("#answer").val("")
        $("#question_area").text(dejsonified.new_card_text);
        $("#current_card").attr("value", dejsonified.new_card_id)

        }
      }
    )
  })
});


















