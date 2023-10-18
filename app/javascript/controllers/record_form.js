const formSwitch = () => {
  var selecterBox = document.getElementById('drink-details');
  var hide = document.getElementById('hide');
  var disp = document.getElementById('disp');
  var check = document.getElementsByClassName('js-check')
  var formDisplayChange = () => {
    if (check[1].checked) {
        selecterBox.style.display = "block";
    } else {
        selecterBox.style.display = "none";
    };
  };
  hide.addEventListener('click', formDisplayChange);
  disp.addEventListener('click', formDisplayChange);
  formDisplayChange();
};

document.addEventListener('DOMContentLoaded', () => {
  document.addEventListener('turbo:load', formSwitch());
});

export default formSwitch;
