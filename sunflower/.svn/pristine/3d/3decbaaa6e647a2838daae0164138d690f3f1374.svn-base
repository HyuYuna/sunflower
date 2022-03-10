# RumcaJS
RumcaJS - Horizontal charts jQuery plugin

## HTML
```html
<link rel="stylesheet" href="dist/rumca.min.css">
<script src="dist/rumca.min.js"></script>
```

## Options
```javascript
var options = {
    data: {},                       // Object with data
    animation: true,                // Status of animation
    animationOffset: 0,             // Offset for animation (in px)
    animationRepeat: true,          // Repeat animation
    showValues: true,               // Status for showing value in bars
    showArrows: false,              // Arrows for axis
    showHorizontalLines: false,     // Status for showing horizontal helper lines
    labelsAboveBars: true           // Labels above bars (axis Y)
};
```

## Data
```javascript
var axisY = [ "Apple", "Orange", "Banana", "Tomato", "Milk", "Potato"];
var axisX = ["10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%"];
var barsValue = [50, 61, 93, 76, 5, 13];

// Data to charts
var data = {
   "axisY": axisY,         // Data for axis Y labels
   "axisX": axisX,         // Data for axis X labels
   "bars": barsValue       // Data for bars value
};
```

## Methods
```javascript
var $myChart = $('#chart-1').rumcaJS(options);      // Initialization horizontal chart.

// Remove
$myChart.resetAll();                                // Remove all data.
$myChart.resetBars();                               // Remove all bars.
$myChart.resetAxisY();                              // Remove all data from axis Y.
$myChart.resetAxisX();                              // Remove all data from axis X.

$myChart.removeItem(4);                             // Remove single item. Parameter: int value (from the top, starting on 1).

// Append
$myChart.appendAll(data);                           // Insert all data. Parameter: object with data.
$myChart.appendItem('new item', 33);                // Insert an element to the end. Parameters: string value (for axis Y label), int value (for bar).
$myChart.appendBars(barsValue);                     // Insert a bars to the end. Parameter: array with int value.
$myChart.appendAxisY(axisY);                        // Insert an axis Y value to the end. Parameter: array with string value.
$myChart.appendAxisX(axisX);                        // Insert an axis X value to the ending. Parameter: array with string value.

// Prepend
$myChart.prependAll(data);                          // Insert all data. Parameter: object with data.
$myChart.prependItem('new item', 76);               // Insert an element to the beginning. Parameters: string value (for axis Y label), int value (for bar).
$myChart.prependBars(barsValue);                    // Insert a bars on the beginning. Parameter: array with int value.
$myChart.prependAxisY(axisY);                       // Insert an axis Y value to the beginning. Parameter: array with string value.
$myChart.prependAxisX(axisX);                       // Insert an axis X value to the beginning. Parameter: array with string value.

// Update
$myChart.updateAll(data);                           // Update chart with new data. Parameter: object with new data.
$myChart.updateBars(barsValue);                     // Update a bars. Parameter: array with int value.
$myChart.updateAxisY(axisY);                        // Update an axis Y. Parameter: array with string value.
$myChart.updateAxisX(axisX);                        // Update an axis X. Parameter: array with string value.

// Sort
$myChart.sortByName(true);                          // Sort by name. Parameter: boolean value (true - descending, false - ascending).
$myChart.sortByValue(false);                        // Sort by value. Parameter: boolean value (true - descending, false - ascending).

// Select
$myChart.selectMax();                               // Select bar with maxiumum value.
$myChart.selectMin();                               // Select bar with minimum value.

// Animation
$myChart.runAnimation();                            // Animation trigger.
```
