Plotly.d3.csv('https://raw.githubusercontent.com/cookm346/music_similarity/master/data/pca3_data.csv', function(err, rows){
function unpack(rows, key) {
	return rows.map(function(row)
	{ return row[key]; });}

var trace1 = {
	x:unpack(rows, 'PC1'), y: unpack(rows, 'PC2'), z: unpack(rows, 'PC3'),
	mode: 'markers+text',
  text: unpack(rows, 'artist'),
	marker: {
		size: 12,
		opacity: 0.8},
	type: 'scatter3d'
};

var data = [trace1];
var layout = {
	autosize: false,
	width: 1600,
	height: 1000,
	margin: {
    l: 50,
    r: 50,
    b: 50,
    t: 50,
    pad: 4
  }};
Plotly.newPlot('myDiv', data, layout);
});