document.addEventListener('turbo:load', () => {
  var volumeElement = document.getElementById('drink_volume');
  var percentageElement = document.getElementById('alcohol_percentage');
  var intakeElement = document.getElementById('alcohol_intake');

  var calculateIntake = () => {
    var volume = parseFloat(volumeElement.value) || 0;
    var percentage = parseFloat(percentageElement.value) || 0;
    var intake = volume * (percentage * 0.01) * 0.8;
    intakeElement.textContent = intake.toFixed(2);
  };

  calculateIntake();
  volumeElement.addEventListener('input', calculateIntake);
  percentageElement.addEventListener('input', calculateIntake);
});
