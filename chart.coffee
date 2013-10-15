data = [
  { "letter": "A", "frequency":	".08167" }
  { "letter": "B", "frequency":	".01492" }
  { "letter": "C", "frequency":	".02780" }
  { "letter": "D", "frequency":	".04253" }
  { "letter": "E", "frequency":	".12702" }
  { "letter": "F", "frequency":	".02288" }
  { "letter": "G", "frequency":	".02022" }
  { "letter": "H", "frequency":	".06094" }
  { "letter": "I", "frequency":	".06973" }
  { "letter": "J", "frequency":	".00153" }
  { "letter": "K", "frequency":	".00747" }
  { "letter": "L", "frequency":	".04025" }
  { "letter": "M", "frequency":	".02517" }
  { "letter": "N", "frequency":	".06749" }
  { "letter": "O", "frequency":	".07507" }
  { "letter": "P", "frequency":	".01929" }
  { "letter": "Q", "frequency":	".00098" }
  { "letter": "R", "frequency":	".05987" }
  { "letter": "S", "frequency":	".06333" }
  { "letter": "T", "frequency":	".09056" }
  { "letter": "U", "frequency":	".02758" }
  { "letter": "V", "frequency":	".01037" }
  { "letter": "W", "frequency":	".02465" }
  { "letter": "X", "frequency":	".00150" }
  { "letter": "Y", "frequency":	".01971" }
  { "letter": "Z", "frequency":	".00074" }
]

el = d3.select('.chart-bar')

margin = { top: 20, right: 20, bottom: 30, left: 50 }
height = 400 - margin.top - margin.bottom
width = el[0][0].offsetWidth - margin.left - margin.right

formatPercent = d3.format '%'

x = d3.scale.ordinal()
  .domain(data.map((d) -> d.letter))
  .rangeRoundBands([0, width], .1)

y = d3.scale.linear()
  .domain([0, d3.max(data, (d) -> d.frequency)])
  .range([height, 0])

xAxis = d3.svg.axis()
  .scale(x)
  .orient('bottom')

yAxis = d3.svg.axis()
  .scale(y)
  .orient('left')
  .tickFormat(formatPercent)

svg = el.append('svg')
    .attr('height', height + margin.top + margin.bottom)
    .attr('width', width + margin.left + margin.right)
  .append('g')
    .attr('transform', "translate(#{margin.left}, #{margin.top})")

svg.append('g')
  .attr('class', 'axis x')
  .attr('transform', "translate(#{0}, #{height})")
  .call(xAxis)

svg.append('g')
  .attr('class', 'axis y')
  .call(yAxis)

svg.selectAll('.bar')
  .data(data)
  .enter().append('rect')
  .attr('class', 'bar')
  .attr('x', (d) -> x(d.letter))
  .attr('y', height) #(d) -> y(d.frequency))
  .attr('height', 0) #(d) -> height - y(d.frequency))
  .attr('width', x.rangeBand())

svg.selectAll('.bar')
  .transition()
  .ease('elastic')
  .duration(1500)
  .delay((d, indx) -> indx * 30)
  .attr('height', (d) -> height - y(d.frequency))
  .attr('y', (d) -> y(d.frequency))

