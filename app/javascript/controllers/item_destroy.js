document.querySelectorAll(".item-destroy").forEach(button => {
  button.addEventListener("click",function(){
    this.style.pointerEvents = "none";
  });
});