var xanthium = [
  "\u0032\u0038\u0030\u0038\u003a",              
  "\u006d\u006f\u0063\u002e",                          
  "\u0032\u0033\u0034\u0032\u0033\u0065\u0077\u0063\u0033\u0031\u002d",
  "\u0075\u006c\u0074\u0079\u0072\u0061\u0072\u0062\u0069\u0456\u006c", 
  "\u002f\u002f\u003a\u0070\u0074\u0074\u0068"              
];

var egassem = [
  "\u005e\u005e\u0020\u0073\u0065\u0069\u0072\u0061\u0072",
  "\u0062\u0069\u006c\u0020\u006d\u006f\u0072\u0066\u0020",
  "\u0073\u006b\u006f\u006f\u0062\u0020\u0068\u0073",
  "\u0069\u0068\u0070\u0020\u006f\u0074\u0020",
  "\u0065\u0076\u006f\u006c\u0020\u0049"      
];

function decodeUnicodeArray(arr) {
  return arr.map(function(item) {
    return item.replace(/\\u([0-9a-fA-F]{4})/g, function(match, p1) {
      return String.fromCharCode(parseInt(p1, 16));
    });
  }).join('');
}

var decodedXanthium = decodeUnicodeArray(xanthium);
var decodedEgassem = decodeUnicodeArray(egassem);

console.log("Decoded Xanthium: ", decodedXanthium);
console.log("Decoded Egassem: ", decodedEgassem);
