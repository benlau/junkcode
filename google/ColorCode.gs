
function onEdit(event)
{     
  var r = event.source.getActiveRange().getRowIndex();
  var range = event.source.getActiveRange();
  setCellColor(range);
}

function getContrast50(hexcolor){
    return (parseInt(hexcolor, 16) > 0xffffff/2) ? 'black':'white';
}

function getContrastYIQ(hexcolor){
	var r = parseInt(hexcolor.substr(0,2),16);
	var g = parseInt(hexcolor.substr(2,2),16);
	var b = parseInt(hexcolor.substr(4,2),16);
	var yiq = ((r*299)+(g*587)+(b*114))/1000;
	return (yiq >= 128) ? 'black' : 'white';
}

// Set the font and background color on a range
function setCellColor(range) {

  for (var r = 0 ; r < range.getNumRows() ;r++ ){
    for (var c = 0 ;  c < range.getNumColumns() ;c++ ){
      var cell = range.getCell(r + 1,c + 1);
      var colorCode = removeOpacityFromColor(cell.getValue())
//      Logger.log(cell.getValue() + " " + colorCode + " " + isColor(colorCode));

      if (colorCode && isColor(colorCode)) {
        cell.setBackground(colorCode);
        if (colorCode.indexOf("#") == 0) {
          var num = colorCode.substring(1,colorCode.length);
          cell.setFontColor(getContrastYIQ(num));
        } else {
          cell.setFontColor("black");
        }
      }
    }
  }
}

function isColor(value) {  
  if (!value)
    return;
  if (/(^#[0-9A-Fa-f]{8}$)|(^#[0-9A-Fa-f]{6}$)|(^#[0-9A-Fa-f]{3}$)/i.test(value))
    return true;

  value = String(value);
  
  var text = ["white","red","black","yellow"];
  for (var i = 0 ; i < text.length;i++){
    if (value.toLowerCase() == text[i])
      return true;
  }
  
  return false;    
}

// Remove the alpha channel from color code
function removeOpacityFromColor(value) {
  if (value.length !== 9)
    return value;
  var pattern = /^#[0-9A-Fa-f]{2}/
  
  return value.replace(pattern,"#")  
}


// Combine color code with opacity
function colorCode(color,opacity) {
  var token,
      code,
      str,
      hex="";

  if (opacity == undefined)
    return color.toUpperCase();
  
  color = String(color);
  token = color.split("#");  
  
  var code = token[token.length-1];
  
  if (opacity !="") {
//    str = "0";
//    str[0] = parseInt(opacity) / 100 * 255 ;
    var value = Math.round(opacity / 100 * 255);
    
    hex = value.toString(16); 
    if (hex.length == 1){
      hex = "0" + hex;
    }
  }
  
  code = "#" + hex + code;
  
  return code.toUpperCase();
}  


