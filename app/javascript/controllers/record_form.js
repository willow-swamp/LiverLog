const formSwitch = () => {
  var selectorBox = document.getElementById('drink-details');
  var no_drink = document.getElementById('no-drink-radio');
  var drink = document.getElementById('drink-radio');
  var check = document.getElementsByClassName('js-check');

  var formDisplayChange = () => {
    if (check[1].checked) {
      selectorBox.style.display = "block";
    } else {
      selectorBox.style.display = "none";
    };
  };

  formDisplayChange();
  no_drink.addEventListener('click', formDisplayChange);
  drink.addEventListener('click', function() {
    formDisplayChange();
    autofillDetailsInit();
  }
  );
};

function autofillDetailsInit() {
  var drinkTypeInput = document.getElementById('drink_type');

  if (drinkTypeInput) { // 要素がnullでないことを確認
    drinkTypeInput.addEventListener('input', function() {
      autofillDetails(this.value); // 正しい引数を使って autofillDetails を呼び出す
    });
  }
}

function autofillDetails(drinkTypeValue) { // 引数を受け取るように修正
  // 日本語の値から英語のキーに変換するマッピング
  const drinkTypeKeyMap = {
    'ビール': 'beer',
    'ワイン': 'wine',
    '日本酒': 'sake',
    '焼酎': 'shochu',
    'ウイスキー': 'whiskey',
    'ハイボール': 'highball',
  };

  const drinkDetails = {
    beer: { volume: 350, percentage: 5.0 },
    wine: { volume: 150, percentage: 12.0 },
    sake: { volume: 100, percentage: 15.0 },
    shochu: { volume: 60, percentage: 25.0 },
    whiskey: { volume: 30, percentage: 40.0 },
    highball: { volume: 350, percentage: 7.0 },
  };

  const drinkKey = drinkTypeKeyMap[drinkTypeValue]; // 日本語から英語キーに変換
  if (drinkKey && drinkDetails[drinkKey]) {
    const details = drinkDetails[drinkKey];
    document.getElementById('drink_volume').value = details.volume;
    document.getElementById('alcohol_percentage').value =parseFloat(details.percentage);
    calculateIntake(details.volume, details.percentage);
  }
}

function calculateIntake(volume, percentage) {
  var volume = parseFloat(volume) || 0;
  var percentage = parseFloat(percentage) || 0;
  var intake = volume * (percentage * 0.01) * 0.8;
  document.getElementById('alcohol_intake').textContent = intake.toFixed(2);
};

document.addEventListener('turbo:load', formSwitch);
document.addEventListener('turbo:before-render', formSwitch);
