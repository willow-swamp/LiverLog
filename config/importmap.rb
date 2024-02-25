# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin '@fortawesome/fontawesome-free', to: 'https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.5.1/js/all.js'
pin 'chart.js', to: 'https://ga.jspm.io/npm:chart.js@4.4.1/dist/chart.js'
pin '@kurkle/color', to: 'https://ga.jspm.io/npm:@kurkle/color@0.3.2/dist/color.esm.js'
