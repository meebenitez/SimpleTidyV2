$(function () {
    $(document).on('click', ".select-button", function(e) {
        var ids = $(this).data("id");
      var url = `/lists/${ids[1]}/chores/${ids[0]}/complete`
      $.ajax ({
          method: "GET",
          url: url,
          chore_id: ids[0],
          list_id: ids[1]
      }).done(function(data){
          if ($(".select-button").length === 1){
              $(`#${this.chore_id}`).remove();
              $("#list-container").html("<br><br><center>Woohoo!  All done! Great work!</center><br>");
          } else {
              $(`#${this.chore_id}`).remove();
              $("#list-container").load(location.href+" #list-container>*","");
          }
          $.get("/lists/" + data.id + "/chores/" + this.chore_id + ".json", function(data) {
              let completedChore = new CompletedChore(data)
              let completedChoreHTML = completedChore.formatButton()
              $(".completed-items").append(completedChoreHTML);
          })

      })
      e.preventDefault
    });
    $('.completed-chores').hide();
    $(document).on('click','.show-completed', function(e){
      e.preventDefault();
      $(this).next('.completed-chores').toggle();
  });


  });

  function CompletedChore(chore){
      this.id = chore.id
      this.name = formatName(chore)
      this.time_of_day = chore.time_of_day
      this.frequency = chore.frequency
  }

  function formatName(chore){
      if (chore.time_of_day === "morning"){
          return `☀ ${chore.name}`
      } else if (chore.time_of_day === "evening"){
          return `☾ ${chore.name}`
      } else {
          return `${chore.name}`
      }
  }

  CompletedChore.prototype.formatButton = function() {
      return `
              <div class="completed-item">
                  <button class="chore completed" id="${this.id}">
                      ${this.name}
                  </button>
              </div>

              `
  }