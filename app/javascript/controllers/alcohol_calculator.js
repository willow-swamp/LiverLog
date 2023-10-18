const calculateAndDisplayIntake = () => {
  var volumeElement = document.getElementById('drink_volume');
  var percentageElement = document.getElementById('alcohol_percentage');
  var intakeElement = document.getElementById('alcohol_intake');

  var calculateIntake = () => {
    var volume = parseFloat(volumeElement.value) || 0;
    var percentage = parseFloat(percentageElement.value) || 0;
    var intake = volume * (percentage * 0.01) * 0.8;
    intakeElement.textContent = intake.toFixed(2);
  };

  volumeElement.addEventListener('input', calculateIntake);
  percentageElement.addEventListener('input', calculateIntake);
  calculateIntake();
};

document.addEventListener('DOMContentLoaded', () => {
  document.addEventListener('turbo:load', calculateAndDisplayIntake);
});

export default calculateAndDisplayIntake;
