function dynInput(cbox) {
  if (cbox.checked) {
    var input = document.createElement("input");
    input.type = "time";
    input.name = "times[]"
    var div = document.createElement("div");
    div.innerHTML = "Arrival time:";
    div.appendChild(input);
    document.getElementById("insertinputs").appendChild(div);
  } else {
    document.getElementById(cbox.name).remove();
  }
}

// $(function(){
//   $(".cbox").click(function() {
//     console.log(self)
//     dynInput(self)
//   });
// });
