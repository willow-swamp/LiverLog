function buttonClick() {
  var btnHide = document.getElementById("hide");
  var drinkDetails = document.getElementById("drink-details");
  if (btnHide.checked) {
    drinkDetails.style.display = "none";
  } else {
    drinkDetails.style.display = "";
  };
};
