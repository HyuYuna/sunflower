<html>
<head>
  <title>D3 in Action Chapter 5 - Example 11</title>
  <meta charset="utf-8" />
<script src="/static/jslibrary/d3/d3.v3.min.js" type="text/JavaScript"></script>
<script src="/static/jslibrary/d3/colorbrewer.js" type="text/JavaScript"></script>
<script src="/static/jslibrary/d3/sankey.js" type="text/JavaScript"></script>
</head>
<style>
  svg {
    height: 500px;
    width: 500px;
    border: 1px solid gray;
  }

</style>
<body>

<div id="viz">
  <svg>
  </svg>
</div>
<div id="controls" />
</body>
  <footer>
    
<script>
    
  d3.json("/bos/singl/siteConectStats/findSankeyConectData.json?pSiteId=ucms", function(data) {
	  data = data.result;
    var intensityRamp = d3.scale.linear().domain([0,d3.max(data.links, function(d) {return d.value})]).range(["black", "red"])
    var sankey = d3.sankey()
    .nodeWidth(20)
    .nodePadding(200)
    .size([460, 460]);

	var path = sankey.link();
	  sankey
      .nodes(data.nodes)
      .links(data.links)
      .layout(200);
  
  expData = data;
  
  d3.select("svg").append("g").attr("transform", "translate(20,20)").attr("id", "sankeyG");
  
  d3.select("#sankeyG").selectAll(".link")
      .data(data.links)
      .enter().append("path")
      .attr("class", "link")
      .attr("d", sankey.link())
      .style("stroke-width", function(d) {return d.dy})
      .style("stroke-opacity", .5)
      .style("fill", "none")
      .style("stroke", function(d){return intensityRamp(d.value)})
      .sort(function(a, b) { return b.dy - a.dy; })
      .on("mouseover", function() {d3.select(this).style("stroke-opacity", .8)})
      .on("mouseout", function() {d3.selectAll("path.link").style("stroke-opacity", .5)})

  d3.select("#sankeyG").selectAll(".node")
      .data(data.nodes)
    .enter().append("g")
      .attr("class", "node")
      .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });

  d3.selectAll(".node").append("rect")
      .attr("height", function(d) { return d.dy; })
      .attr("width", 20)
      .style("fill", "pink")
      .style("stroke", "gray")

  d3.selectAll(".node").append("text")
      .attr("x", 0)
      .attr("y", function(d) { return d.dy / 2; })
      .attr("text-anchor", "middle")
      .text(function(d) { return d.name; })
    })
</script>
  </footer>

</html>
