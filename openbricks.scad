/*
Copyright (c) 2025 Yaron J.G. Bandell ("openbricks at mov dot dx dot cx")

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

//
// Module:  openbricks
//
// Version: 1.4
//
// Date:    2025-03-29
//
// Author:  Yaron J.G. Bandell
//
// Email:   openbricks at mov dot dx dot cx
//
//
// Description:
//
// openbricks( wall_length, wall_height, brick_pattern, standard_brick_length, standard_brick_height, standard_brick_width, standard_mortar_length, standard_mortar_width, repeat_brick_pattern );
//
// The brick pattern should be an array of strings, where each position in a string can be any combination of the available parameters.
//
// NOTE: The two corner types at the beginning and end of a string pattern will NOT repeat even if repeat_brick_pattern is true. Corner types in any other position will create a Stretcher or Header brick
//
// Available brick types:
//
// S - Strecher
// s - Stretcher (Corner)
// D - Strecher Blank Spot
// H - Header
// h - Header (Corner)
// d - Header Blank Spot
// Z - Quoin Stretcher
// X - Quoin Header 
// B - Quoin Sailor
// N - Quoin Soldier
// z - Quoin Stretcher (Spacer Spot)
// x - Quoin Header  (Spacer Spot)
// b - Quoin Sailor (Spacer Spot)
// n - Quoin Soldier (Spacer Spot)
// R - Shiner
// T - Shiner Blank Spot
// r - Rowlock
// t - Rowlock Blank Spot
// Q - Queen Closer
// J - Sailor
// j - Sailor Blank Spot
// K - Soldier
// k - Soldier Blank Spot
// 0 - Full Stretcher size Blank
// 1 - 1/10th Stretcher size Blank
// 2 - 2/10th Stretcher Size Blank
// 3 - 3/10th Stretcher Size Blank
// 4 - 4/10th Stretcher Size Blank
// 5 - 5/10th Stretcher Size Blank
// 6 - 6/10th Stretcher Size Blank
// 7 - 7/10th Stretcher Size Blank
// 8 - 8/10th Stretcher Size Blank
// 9 - 9/10th Stretcher Size Blank
// M - Full Mortar Width
// m - 1/2 Mortar Width
// O - 3/4 Lap/Offset Brick
// G - 1/2 Lap/Offset Brick
// o - 1/4 Lap/Offset Brick
// Y - 2/3 Lap/Offset Brick
// y - 1/3 Lap/Offset Brick
// P - 3/4 Shiner Lap/Offset Brick
// g - 1/2 Shiner Lap/Offset Brick
// p - 1/4 Shiner Lap/Offset Brick
// U - 2/3 Shiner Lap/Offset Brick
// u - 1/3 Shiner Lap/Offset Brick
//

//
// Increase brickstring index to the next brick. If at end, will wrap back around automatically if repeat_control == true
//
function increase_brickindex(brickstring, brickindex, repeat_control) = (((brickstring == undef) || (brickstring == "")) ? undef : (brickindex < 0) ? 0 : (brickindex >= (len(brickstring) - 1)) ? (repeat_control ? 0 : undef) : (brickindex + 1) );


//
// Return the current brick type based on a valid brickindex.
// NOTE: Function blatantly assumes only increase_brickindex is used to iterate across the brickstring
//
function get_current_brick(brickstring, brickindex) = ( (brickstring == undef) ? undef : brickstring[brickindex] ) ;


//
// Get the X-axis dimension of a specific brick type:
//
function get_brick_length(a_brick, bricklength, brickheight, brickwidth, mortarwidth) =
(
(a_brick == undef) ? 0 :
(a_brick == "S") ? bricklength :            // Stretcher
(a_brick == "s") ? bricklength :            // Stretcher (Corner)
(a_brick == "D") ? bricklength :            // Stretcher Blank Spot
(a_brick == "H") ? brickwidth :             // Header 
(a_brick == "h") ? brickwidth :             // Header (Corner)
(a_brick == "d") ? brickwidth :             // Header Blank Spot
(a_brick == "Z") ? (get_brick_length("S", bricklength, brickheight, brickwidth, mortarwidth) + mortarwidth + get_brick_length("H", bricklength, brickheight, brickwidth, mortarwidth)) :     // Quoin Stretcher
(a_brick == "X") ? (get_brick_length("H", bricklength, brickheight, brickwidth, mortarwidth) + mortarwidth + get_brick_length("Q", bricklength, brickheight, brickwidth, mortarwidth)) :     // Quoin Header
(a_brick == "B") ? (get_brick_length("H", bricklength, brickheight, brickwidth, mortarwidth) + mortarwidth + get_brick_length("Q", bricklength, brickheight, brickwidth, mortarwidth)) :     // Quoin Sailor
(a_brick == "N") ? (brickheight * 1.5):     // Quoin Soldier
(a_brick == "z") ? (get_brick_length("S", bricklength, brickheight, brickwidth, mortarwidth) + mortarwidth + get_brick_length("H", bricklength, brickheight, brickwidth, mortarwidth)) :     // Quoin Stretcher Spacer Spot
(a_brick == "x") ? (get_brick_length("H", bricklength, brickheight, brickwidth, mortarwidth) + mortarwidth + get_brick_length("Q", bricklength, brickheight, brickwidth, mortarwidth)) :     // Quoin Header Spacer Spot
(a_brick == "b") ? (get_brick_length("H", bricklength, brickheight, brickwidth, mortarwidth) + mortarwidth + get_brick_length("Q", bricklength, brickheight, brickwidth, mortarwidth)) :     // Quoin Sailor Spacer Spot
(a_brick == "n") ? (brickheight * 1.5):     // Quoin Soldier Spacer Spot
(a_brick == "R") ? bricklength :            // Shiner
(a_brick == "T") ? bricklength :            // Shiner Blank Spot
(a_brick == "r") ? brickheight :            // Rowlock
(a_brick == "t") ? brickheight :            // Rowlock Blank Spot
(a_brick == "Q") ? (brickwidth / 2) - (mortarwidth / 2):     // Queen Closer (Lap/Offset brick)
(a_brick == "J") ? brickwidth :             // Sailor
(a_brick == "j") ? brickwidth :             // Sailor Spacer Spot
(a_brick == "K") ? brickheight :            // Soldier
(a_brick == "k") ? brickheight :            // Soldier Spacer Spot
(a_brick == "0") ? bricklength :            // Full Stretcher Size Blank
(a_brick == "1") ? bricklength * 0.1 :      // 1/10th Stretcher Size Blank
(a_brick == "2") ? bricklength * 0.2 :      // 2/10th Stretcher Size Blank
(a_brick == "3") ? bricklength * 0.3 :      // 3/10th Stretcher Size Blank
(a_brick == "4") ? bricklength * 0.4 :      // 4/10th Stretcher Size Blank
(a_brick == "5") ? bricklength * 0.5 :      // 5/10th Stretcher Size Blank
(a_brick == "6") ? bricklength * 0.6 :      // 6/10th Stretcher Size Blank
(a_brick == "7") ? bricklength * 0.7 :      // 7/10th Stretcher Size Blank
(a_brick == "8") ? bricklength * 0.8 :      // 8/10th Stretcher Size Blank
(a_brick == "9") ? bricklength * 0.9 :      // 9/10th Stretcher Size Blank
(a_brick == "M") ? mortarwidth :            // Full Mortar Width
(a_brick == "m") ? mortarwidth * 0.5 :      // 1/2 Mortar Width
(a_brick == "O") ? bricklength * 0.75 :     // 3/4 Stretcher Lap/Offset Brick
(a_brick == "G") ? bricklength * 0.5 :      // 1/2 Stretcher Lap/Offset Brick
(a_brick == "o") ? bricklength * 0.25 :     // 1/4 Stretcher Lap/Offset Brick
(a_brick == "Y") ? bricklength * 0.6666 :   // 2/3 Stretcher Lap/Offset Brick
(a_brick == "y") ? bricklength * 0.3333 :   // 1/3 Stretcher Lap/Offset Brick
(a_brick == "P") ? bricklength * 0.75 :     // 3/4 Shiner Lap/Offset Brick
(a_brick == "g") ? bricklength * 0.5 :      // 1/2 Shiner Lap/Offset Brick
(a_brick == "p") ? bricklength * 0.25 :     // 1/4 Shiner Lap/Offset Brick
(a_brick == "U") ? bricklength * 0.6666 :   // 2/3 Shiner Lap/Offset Brick
(a_brick == "u") ? bricklength * 0.3333 :   // 1/3 Shiner Lap/Offset Brick
0
) ;


//
// Get the Y-axis dimension of a specific brick type:
//
function get_brick_height(a_brick, bricklength, brickheight, brickwidth, mortarwidth) =
(
(a_brick == undef) ? 0 :
(a_brick == "S") ? brickheight :                           // Stretcher
(a_brick == "s") ? brickheight :                           // Stretcher (Corner)
(a_brick == "D") ? brickheight :                           // Stretcher Blank Spot
(a_brick == "H") ? brickheight :                           // Header
(a_brick == "h") ? brickheight :                           // Header (Corner)
(a_brick == "d") ? brickheight :                           // Header Blank Spot
(a_brick == "Z") ? (brickheight * 2) + mortarwidth :                             // Quoin Stretcher
(a_brick == "X") ? (brickheight * 2) + mortarwidth :                             // Quoin Header 
(a_brick == "B") ? (((brickheight * 3) + (mortarwidth * 2)) * 2) + mortarwidth : // Quoin Sailor
(a_brick == "N") ? (((brickheight * 3) + (mortarwidth * 2)) * 2) + mortarwidth : // Quoin Soldier
(a_brick == "z") ? brickheight :                           // Quoin Stretcher Spacer Spot
(a_brick == "x") ? brickheight :                           // Quoin Header Spacer Spot
(a_brick == "b") ? brickheight :                           // Quoin Sailor Spacer Spot
(a_brick == "n") ? brickheight :                           // Quoin Soldier Spacer Spot
(a_brick == "R") ? brickwidth :                            // Shiner
(a_brick == "T") ? brickwidth :                            // Shiner Blank Spot
(a_brick == "r") ? brickwidth :                            // Rowlock
(a_brick == "t") ? brickwidth :                            // Rowlock Blank Spot
(a_brick == "Q") ? brickheight :                           // Queen Closer
(a_brick == "J") ? (brickheight * 3) + (mortarwidth * 2) : // Sailor
(a_brick == "j") ? bricklength :                           // Sailor Blank Spot
(a_brick == "K") ? (brickheight * 3) + (mortarwidth * 2) : // Soldier
(a_brick == "k") ? bricklength :                           // Soldier Blank Spot
(a_brick == "0") ? brickheight :                           // Full Stretcher Size Blank
(a_brick == "1") ? brickheight :                           // 1/10th Stretcher Size Blank
(a_brick == "2") ? brickheight :                           // 2/10th Stretcher Size Blank
(a_brick == "3") ? brickheight :                           // 3/10th Stretcher Size Blank
(a_brick == "4") ? brickheight :                           // 4/10th Stretcher Size Blank
(a_brick == "5") ? brickheight :                           // 5/10th Stretcher Size Blank
(a_brick == "6") ? brickheight :                           // 6/10th Stretcher Size Blank
(a_brick == "7") ? brickheight :                           // 7/10th Stretcher Size Blank
(a_brick == "8") ? brickheight :                           // 8/10th Stretcher Size Blank
(a_brick == "9") ? brickheight :                           // 9/10th Stretcher Size Blank
(a_brick == "M") ? brickheight :                           // Full Mortar Width
(a_brick == "m") ? brickheight :                           // 1/2 Mortar Width
(a_brick == "O") ? brickheight :                           // 3/4 Stretcher Lap/Offset Brick
(a_brick == "G") ? brickheight :                           // 1/2 Stretcher Lap/Offset Brick
(a_brick == "o") ? brickheight :                           // 1/4 Stretcher Lap/Offset Brick
(a_brick == "Y") ? brickheight :                           // 2/3 Stretcher Lap/Offset Brick
(a_brick == "y") ? brickheight :                           // 1/3 Stretcher Lap/Offset Brick
(a_brick == "P") ? brickwidth :                            // 3/4 Shiner Lap/Offset Brick
(a_brick == "g") ? brickwidth :                            // 1/2 Shiner Lap/Offset Brick
(a_brick == "p") ? brickwidth :                            // 1/4 Shiner Lap/Offset Brick
(a_brick == "U") ? brickwidth :                            // 2/3 Shiner Lap/Offset Brick
(a_brick == "u") ? brickwidth :                            // 1/3 Shiner Lap/Offset Brick
0
) ;


//
// Get the Z-axis dimension of a specific brick type:
//
// NOTE: This function keeps the wall depth in an equal plane so headers etc won't stick out the back of the wall.
//
function get_brick_width(a_brick, bricklength, brickheight, brickwidth, mortarwidth) =
(
(a_brick == undef) ? 0 :
(a_brick == "S") ? brickwidth :       // Strecher
(a_brick == "s") ? brickwidth :       // Stretcher (Corner)
(a_brick == "D") ? brickwidth :       // Strecher Blank Spot
(a_brick == "H") ? brickwidth :       // Header
(a_brick == "h") ? brickwidth :       // Header (Corner)
(a_brick == "d") ? brickwidth :       // Header Blank Spot
(a_brick == "Z") ? brickwidth :       // Quoin Stretcher
(a_brick == "X") ? brickwidth :       // Quoin Header 
(a_brick == "B") ? brickwidth :       // Quoin Sailor
(a_brick == "N") ? brickwidth :       // Quoin Soldier
(a_brick == "z") ? brickwidth :       // Quoin Stretcher (Spacer Spot)
(a_brick == "x") ? brickwidth :       // Quoin Header  (Spacer Spot)
(a_brick == "b") ? brickwidth :       // Quoin Sailor (Spacer Spot)
(a_brick == "n") ? brickwidth :       // Quoin Soldier (Spacer Spot)
(a_brick == "R") ? brickwidth :       // Shiner
(a_brick == "T") ? brickwidth :       // Shiner Blank Spot
(a_brick == "r") ? brickwidth :       // Rowlock
(a_brick == "t") ? brickwidth :       // Rowlock Blank Spot
(a_brick == "Q") ? brickwidth :       // Queen Closer
(a_brick == "J") ? brickwidth :       // Sailor
(a_brick == "j") ? brickwidth :       // Sailor Blank Spot
(a_brick == "K") ? brickwidth :       // Soldier
(a_brick == "k") ? brickwidth :       // Soldier Blank Spot
(a_brick == "0") ? brickwidth :       // Full Stretcher size Blank
(a_brick == "1") ? brickwidth :       // 1/10th Stretcher size Blank
(a_brick == "2") ? brickwidth :       // 2/10th Stretcher Size Blank
(a_brick == "3") ? brickwidth :       // 3/10th Stretcher Size Blank
(a_brick == "4") ? brickwidth :       // 4/10th Stretcher Size Blank
(a_brick == "5") ? brickwidth :       // 5/10th Stretcher Size Blank
(a_brick == "6") ? brickwidth :       // 6/10th Stretcher Size Blank
(a_brick == "7") ? brickwidth :       // 7/10th Stretcher Size Blank
(a_brick == "8") ? brickwidth :       // 8/10th Stretcher Size Blank
(a_brick == "9") ? brickwidth :       // 9/10th Stretcher Size Blank
(a_brick == "M") ? brickwidth :       // Full Mortar Width
(a_brick == "m") ? brickwidth :       // 1/2 Mortar Width
(a_brick == "O") ? brickwidth :       // 3/4 Stretcher Lap/Offset Brick
(a_brick == "G") ? brickwidth :       // 1/2 Stretcher Lap/Offset Brick
(a_brick == "o") ? brickwidth :       // 1/4 Stretcher Lap/Offset Brick
(a_brick == "Y") ? brickwidth :       // 2/3 Stretcher Lap/Offset Brick
(a_brick == "y") ? brickwidth :       // 1/3 Stretcher Lap/Offset Brick
(a_brick == "P") ? brickwidth :       // 3/4 Shiner Lap/Offset Brick
(a_brick == "g") ? brickwidth :       // 1/2 Shiner Lap/Offset Brick
(a_brick == "p") ? brickwidth :       // 1/4 Shiner Lap/Offset Brick
(a_brick == "U") ? brickwidth :       // 2/3 Shiner Lap/Offset Brick
(a_brick == "u") ? brickwidth :       // 1/3 Shiner Lap/Offset Brick
0
) ;


//
// Return if the brick type is an offset type
//
function is_offset_type(a_brick) =
(
(a_brick == undef) ? false :
(a_brick == "Q") ? true : // Queen Closer Lap/Offset Brick
(a_brick == "O") ? true : // Stretcher 3/4 Lap/Offset Brick
(a_brick == "G") ? true : // Stretcher 1/2 Lap/Offset Brick
(a_brick == "o") ? true : // Stretcher 1/4 Lap/Offset Brick
(a_brick == "Y") ? true : // Stretcher 2/3 Lap/Offset Brick
(a_brick == "y") ? true : // Stretcher 1/3 Lap/Offset Brick
false
) ;


//
// Return if the brick type is a spacer type (i.e. Sailor and Soldier spacers):
//
function is_spacer_type(a_brick) =
(
(a_brick == undef) ? false :
(a_brick == "j") ? true : // Sailor Blank Spot
(a_brick == "k") ? true : // Soldier Blank Spot
(a_brick == "z") ? true : // Quoin Stretcher Blank Spot
(a_brick == "x") ? true : // Quoin Header Blank Spot
(a_brick == "b") ? true : // Quoin Sailor Blank Spot
(a_brick == "n") ? true : // Quoin Soldier Blank Spot
false
) ;


//
// Return true if the brick type is a blank space:
//
function is_blank_type(a_brick) =
(
(a_brick == undef) ? true :
(a_brick == "D") ? true : // Stretcher Blank Spot
(a_brick == "d") ? true : // Header Blank Spot
(a_brick == "T") ? true : // Shiner Blank Spot
(a_brick == "t") ? true : // Rowlock Blank Spot
(a_brick == "0") ? true : // Full Stretcher Size Blank
(a_brick == "1") ? true : // 1/10th Stretcher Size Blank
(a_brick == "2") ? true : // 2/10th Stretcher Size Blank
(a_brick == "3") ? true : // 3/10th Stretcher Size Blank
(a_brick == "4") ? true : // 4/10th Stretcher Size Blank
(a_brick == "5") ? true : // 5/10th Stretcher Size Blank
(a_brick == "6") ? true : // 6/10th Stretcher Size Blank
(a_brick == "7") ? true : // 7/10th Stretcher Size Blank
(a_brick == "8") ? true : // 8/10th Stretcher Size Blank
(a_brick == "9") ? true : // 9/10th Stretcher Size Blank
false
) ;


//
// Return true if the brick is extra mortar space:
//
function is_mortar_type(a_brick) =
(
(a_brick == undef) ? true :
(a_brick == "M") ? true : // Full Mortar width
(a_brick == "m") ? true : // 1/2 Mortar width
false
) ;


//
// is this a brick type that should never have mortar on top:
//
function never_mortar_top(a_brick) =
(
(a_brick == undef) ? true :
(a_brick == "R") ? true : // Shiner
(a_brick == "r") ? true : // Rowlock
(a_brick == "P") ? true : // 3/4 Shiner Lap/Offset Brick
(a_brick == "g") ? true : // 1/2 Shiner Lap/Offset Brick
(a_brick == "p") ? true : // 1/4 Shiner Lap/Offset Brick
(a_brick == "U") ? true : // 2/3 Shiner Lap/Offset Brick
(a_brick == "u") ? true : // 1/3 Shiner Lap/Offset Brick
false
) ;

//
//
// Function that returns true if the brick type is a corner brick
//
function is_corner_type(a_brick) =
(
(a_brick == "s") ? true :
(a_brick == "h") ? true :
(a_brick == "Z") ? true :
(a_brick == "X") ? true :
(a_brick == "B") ? true :
(a_brick == "N") ? true :
(a_brick == "z") ? true :
(a_brick == "x") ? true :
(a_brick == "b") ? true :
(a_brick == "n") ? true :
false
) ;


//
// Function returns true if the brick type is a Quoin type brick
//
function is_quoin_type(a_brick) =
(
(a_brick == "Z") ? true :
(a_brick == "X") ? true :
(a_brick == "B") ? true :
(a_brick == "N") ? true :
(a_brick == "z") ? true :
(a_brick == "x") ? true :
(a_brick == "b") ? true :
(a_brick == "n") ? true :
false
);


//
// Convert an uppercase character to lowercase:
//
function char_to_lower(a_char) = chr(let(c=ord(a_char)) c<91 && c>64 ?c+32:c);


//
// Module that draws a blank (shouldn't do anything)
//
module create_blank(bricklength, brickheight, brickwidth, mortarwidth, bricktype, wallpos, wallheight, maxwallheight, mortardepth, is_last_brick)
{
//echo(str("  create_blank(", bricktype, ") dims = ", [ bricklength, brickheight, brickwidth ]));
//DEBUG:
//translate([ wallpos, wallheight ,0 ]) color("green", 1.0) cube([ bricklength, brickheight, brickwidth]);
}


//
// Module that draws a brick
//
module create_brick(bricklength, brickheight, brickwidth, mortarwidth, bricktype, wallpos, wallheight, maxwallheight, mortardepth, brickcolor, add_texture, is_last_brick)
{
if ((bricklength == 0) && (brickheight == 0) && (brickwidth == 0))
  {
  assert(false, str("Unknown brick '", bricktype, "' found in pattern string!!!"));
  }

adjust_height=(wallheight+brickheight) > maxwallheight ? (maxwallheight - wallheight) : brickheight;

//echo(str("  create_brick(", bricktype, ") dims = ", [ bricklength, adjust_height, brickwidth ]));
do_texture=(add_texture == undef) ? "n" : char_to_lower(add_texture);

difference()
  {
  union()
    {
//if (is_spacer_type(bricktype) == false)
//  {
    if (do_texture == "t") // Texture map bricks:
      {
      texture_file=str(openbricks_file_prefix, round(rands(1,20,1)[0]), ".dat");
    
          translate([ wallpos, wallheight , brickwidth ]) color(brickcolor, 1.0)
            if (is_quoin_type(bricktype) == false) // Only add texture if not a quoin brick:
              {
              intersection()
                {
                cube([ bricklength, adjust_height, 1]);
                surface(file = texture_file, center = false, convexity = 5);
                }
              }
          translate([ wallpos, wallheight , 0 ]) color(brickcolor, 1.0)
            cube([ bricklength, adjust_height, brickwidth]);
      }
    else if (do_texture == "r") // Rounded bricks:
      {
      o=openbricks_radius;
      w=bricklength - openbricks_radius;
      h=adjust_height - openbricks_radius;
      t=brickwidth - openbricks_radius;

      translate([ wallpos, wallheight , 0 ])
        color(brickcolor, 1.0)
          hull($fn=openbricks_resolution) //defining $fn here constrains the resolution to the hull
            {
            translate([o,o,o]) sphere(openbricks_radius);
            translate([w,o,o]) sphere(openbricks_radius);
            translate([w,h,o]) sphere(openbricks_radius);
            translate([o,h,o]) sphere(openbricks_radius);
            translate([o,o,t]) sphere(openbricks_radius);
            translate([w,o,t]) sphere(openbricks_radius);
            translate([w,h,t]) sphere(openbricks_radius);
            translate([o,h,t]) sphere(openbricks_radius);
            }
      }
    else
      {
      translate([ wallpos, wallheight , 0 ]) // Z was 0
        color(brickcolor, 1.0)
          cube([ bricklength, adjust_height, brickwidth]);
      }
//  }

    mortar_sheet(wallpos, wallheight, 0, bricklength+((is_last_brick == false) ? mortarwidth : 0), adjust_height + (((wallheight+brickheight) >= maxwallheight) ? 0 : ((never_mortar_top(bricktype)) ? 0 : mortarwidth)), brickwidth*mortardepth, bricktype);
    }
  }
}


//
// Create LHS corner brick
//
module processleftcorner(bricklength, brickheight, brickwidth, mortarwidth, cornertype, wallpos, maxwallwidth, wallheight, maxwallheight, mortardepth, repeat_control, do_texture)
{
//echo(str("Process LEFT corner type '",cornertype,"'"));

cx=get_brick_length(cornertype, bricklength, brickheight, brickwidth, mortarwidth);
cy=get_brick_height(cornertype, bricklength, brickheight, brickwidth, mortarwidth);
cz=get_brick_width(cornertype, bricklength, brickheight, brickwidth, mortarwidth);

//echo(str("  wallpos = ", wallpos, " Current = ", cornertype, " dims = ", [ cx, cy, cz]));
//echo(str("Next wallpos = ", wallpos+cx+mortarwidth));

if (is_spacer_type(cornertype) == false) // Only draw a brick if the type is not a spacer type:
  create_brick(cx, cy, cz, mortarwidth, cornertype, wallpos, wallheight, maxwallheight, mortardepth, "firebrick", do_texture, false);
}


//
// Create RHS corner brick
//
module processrightcorner(bricklength, brickheight, brickwidth, mortarwidth, cornertype, wallpos, maxwallwidth, wallheight, maxwallheight, mortardepth, repeat_control, do_texture)
{
//echo("");
//echo(str("Process RIGHT corner type '",cornertype,"'"));

cx=get_brick_length(cornertype, bricklength, brickheight, brickwidth, mortarwidth);
cy=get_brick_height(cornertype, bricklength, brickheight, brickwidth, mortarwidth);
cz=get_brick_width(cornertype, bricklength, brickheight, brickwidth, mortarwidth);

//echo(str("  wallpos = ", wallpos, " Current = ", cornertype, " dims = ", [ cx, cy, cz]));
//echo(str("Final wallpos = ", wallpos+cx));

if (is_spacer_type(cornertype) == false)
  create_brick(cx, cy, cz, mortarwidth, cornertype, wallpos, wallheight, maxwallheight, mortardepth, "firebrick", do_texture, true);
}


//
// Create offset brick
//
module processoffsetbrick(bricklength, brickheight, brickwidth, mortarwidth, cornertype, wallpos, maxwallwidth, wallheight, maxwallheight, mortardepth, repeat_control, do_texture)
{
//echo(str("Process OFFSET corner type '",cornertype,"'"));

cx=get_brick_length(cornertype, bricklength, brickheight, brickwidth, mortarwidth);
cy=get_brick_height(cornertype, bricklength, brickheight, brickwidth, mortarwidth);
cz=get_brick_width(cornertype, bricklength, brickheight, brickwidth, mortarwidth);

//echo(str("  wallpos = ", wallpos, " Current = ", cornertype, " dims = ", [ cx, cy, cz]));
//echo(str("Next wallpos = ", wallpos+cx+mortarwidth));

create_brick(cx, cy, cz, mortarwidth, cornertype, wallpos, wallheight, maxwallheight, mortardepth, "orange", do_texture, false);
}


//
// Create the mortar sheet and ensure a small overlap:
//
module mortar_sheet(x, y, z, sheet_length, sheet_height, sheet_width, bricktype)
{
//echo("Entering mortar_sheet()", x, y, z, sheet_length, sheet_height, sheet_width, bricktype)
if ((is_mortar_type(bricktype) == true) || (is_spacer_type(bricktype) == false))
  {
  translate([-openbricks_eps+x, -openbricks_eps+y, -openbricks_eps])
    cube([sheet_length+(2*openbricks_eps), sheet_height+(2*openbricks_eps), sheet_width+(2*openbricks_eps)]);
  }
}


//
// Module that determines if the current brick type in the pattern needs to be drawn and at what size
//
module processpattern(bricklength, brickheight, brickwidth, mortarwidth, brickindex, brickpattern, wallpos, maxwallwidth, wallheight, maxwallheight, mortardepth, repeat_control, rhs_corner, do_texture)
{
//echo("");

current_brick=get_current_brick(brickpattern, brickindex);
cx=get_brick_length(current_brick, bricklength, brickheight, brickwidth, mortarwidth);
cy=get_brick_height(current_brick, bricklength, brickheight, brickwidth, mortarwidth);
cz=get_brick_width(current_brick, bricklength, brickheight, brickwidth, mortarwidth);

nextbrickindex=increase_brickindex(brickpattern, brickindex, repeat_control);
next_brick=get_current_brick(brickpattern, nextbrickindex);
nx=get_brick_length(next_brick, bricklength, brickheight, brickwidth, mortarwidth);
ny=get_brick_height(next_brick, bricklength, brickheight, brickwidth, mortarwidth);
nz=get_brick_width(next_brick, bricklength, brickheight, brickwidth, mortarwidth);

//echo(str("  wallpos = ", wallpos, " maxwall = ", maxwallwidth, " Current = ", current_brick, " dims = ", [ cx, cy, cz ]));

// Do we have space for another brick?
if ((wallpos + cx) < maxwallwidth) // Yes we do:
  {
  make_blank=is_blank_type(current_brick);
  extra_mortar=is_mortar_type(current_brick);

  if (extra_mortar == true)
    {
    mortar_sheet(wallpos, wallheight, 0, cx, ((wallheight+cy) >= maxwallheight ? (maxwallheight - wallheight) : cy + mortarwidth), (cz * mortardepth), current_brick);
    }
  else
  if (make_blank == false)
    {
    if (is_spacer_type(current_brick) == false)
      create_brick(cx, cy, cz, mortarwidth, current_brick, wallpos, wallheight, maxwallheight, mortardepth, is_offset_type(current_brick) ? "orange" : "yellow", do_texture, ((nextbrickindex != undef) && ((is_blank_type(next_brick) == true) || (is_mortar_type(next_brick))) ? true : false));
    }
  else
    {
    // Create a blank spot in the wall:
    create_blank(cx, cy, cz, mortarwidth, current_brick, wallpos, wallheight, maxwallheight, mortardepth);
    }

  // Enter recursion only if there is a next brick to process:
  if (nextbrickindex != undef)
    processpattern(bricklength, brickheight, brickwidth, mortarwidth, nextbrickindex, brickpattern, (wallpos + cx + (extra_mortar == true ? 0 : ((is_mortar_type(next_brick) == true) ? 0 : mortarwidth))), maxwallwidth, wallheight, maxwallheight, mortardepth, repeat_control, rhs_corner, do_texture);

  // Create the end corner if we have one:
  if (nextbrickindex == undef)
    {
    if (rhs_corner != undef)
      processrightcorner(bricklength, brickheight, brickwidth, mortarwidth, rhs_corner, (wallpos + cx + (extra_mortar == true ? 0 : mortarwidth)), maxwallwidth, wallheight, maxwallheight, mortardepth, repeat_control, do_texture);
    }
  }
else // No we don't:
  {
  // maxwallwidth reached
  //echo(str("  maxwallwidth reached"));

  if ((maxwallwidth - wallpos) > 0)
    {
    //echo(str("Brick space left = ", maxwallwidth - wallpos));

    // Create a special width brick of the type indicated by spacerbrick:
    sx=(maxwallwidth - wallpos);

    //echo(str("Creating spacer with dimensions = ", [ sx, brickheight, brickwidth ]));
    create_brick(sx, brickheight, brickwidth, mortarwidth, "S", wallpos, wallheight, maxwallheight, mortardepth, "magenta", do_texture);
    }

  // Create the end corner if we have one:
  if (rhs_corner != undef)
    processrightcorner(bricklength, brickheight, brickwidth, mortarwidth, rhs_corner, maxwallwidth+mortarwidth, maxwallwidth, wallheight, maxwallheight, mortardepth, repeat_control, do_texture);
  }
}






////////////////////////
// Standard Variables //
////////////////////////


openbricks_eps = 0.001;     // Used for ensuring objects overlap
openbricks_radius = 0.25;    // Used as radius for rounded bricks
openbricks_resolution = 15; // Used as resolution for rounding bricks
openbricks_file_prefix = "textures/texture"; // Where to find the textures. Code will add a sequence number plus ".dat"


//////////
// MAIN //
//////////


module openbricks(wall_length, wall_height, brick_pattern, a_brick_length, a_brick_height, a_brick_width, a_mortar_length, a_mortar_width, repeat_control, a_texture)
{
difference()
  {
  union()
    {

    for (y = [ 0 : (a_brick_height + a_mortar_length) * len(brick_pattern) : wall_height])
      {
      wall_pos = 0;
    
      // Iterate across the pattern strings:
      for (x = [ 0 : (len(brick_pattern) - 1) ])
        {
        current_height = y + ((a_brick_height + a_mortar_length) * x);
    
        if (current_height <  wall_height)
          {
          //echo("");
          //echo(str("==== NEW ROW of '", brick_pattern[x], "' pattern ===="));
    
          brick_pattern_len=len(brick_pattern[x]) - 1;
    
          has_lhs_corner=is_corner_type(brick_pattern[x][0]) ? true : false ;
          has_rhs_corner=is_corner_type(brick_pattern[x][brick_pattern_len]) ? true : false ;
          //echo(str("offset brick(",has_offset_brick,") : ", brick_pattern[x][((has_lhs_corner == true) ? 1 : 0)]));
          has_offset_brick=(brick_pattern_len > 0) ? ( is_offset_type(brick_pattern[x][((has_lhs_corner == true) ? 1 : 0)]) ? true : false ) : false;
    
          start_index=has_lhs_corner ? ((has_offset_brick) ? 2 : 1 ) : ((has_offset_brick) ? 1 : 0);
          end_index=has_rhs_corner ? ( (brick_pattern_len - 1) > 0 ? brick_pattern_len - 1 : 0 ) : brick_pattern_len;
    
          //echo(str("start = ", start_index));
          //echo(str("end   = ", end_index));
    
          // create a new brick pattern that doesn't contain the beginning nor ending corner character
          shortened_pattern = [ if (start_index <= end_index) for (i = [start_index : end_index]) brick_pattern[x][i] ];
    
          lhs_corner_length=(has_lhs_corner) ? (get_brick_length(brick_pattern[x][0], a_brick_length, a_brick_height, a_brick_width, a_mortar_length) + a_mortar_length) : 0;
          offset_brick_length=(has_offset_brick) ? (get_brick_length(brick_pattern[x][((has_lhs_corner == true) ? 1 : 0)], a_brick_length, a_brick_height, a_brick_width, a_mortar_length) + a_mortar_length) : 0;
          rhs_corner_length=(has_rhs_corner) ? (get_brick_length(brick_pattern[x][brick_pattern_len], a_brick_length, a_brick_height, a_brick_width, a_mortar_length) + a_mortar_length) : 0;
    
          if (has_lhs_corner)
            processleftcorner(a_brick_length, a_brick_height, a_brick_width, a_mortar_length, brick_pattern[x][0], wall_pos, wall_length, current_height, wall_height, a_mortar_width, repeat_control, a_texture);
    
          if (has_offset_brick)
            processoffsetbrick(a_brick_length, a_brick_height, a_brick_width, a_mortar_length, brick_pattern[x][((has_lhs_corner == true) ? 1 : 0)], wall_pos + lhs_corner_length, wall_length, current_height, wall_height, a_mortar_width, repeat_control, a_texture);
    
    
          if (len(shortened_pattern) >= 1)
            {
            //echo(str("Sub String = ", shortened_pattern));
    
            // This method will recurse through an entire single string pattern:
            processpattern(a_brick_length, a_brick_height, a_brick_width, a_mortar_length, 0, shortened_pattern, wall_pos + lhs_corner_length + offset_brick_length, wall_length - rhs_corner_length, current_height, wall_height, a_mortar_width, repeat_control, has_rhs_corner ? brick_pattern[x][brick_pattern_len] : undef, a_texture);
            }
    
          // RHS corner logic incorporated in processpattern() method to ensure wall_pos for non-repeating patterns is correct
    
          //echo("==== END OF ROW ====");
          }
        }
      }
    
//    // One big mortar sheet:
//    if (repeat_control == true)
//      mortar_sheet(0, 0, 0, wall_length, wall_height, (a_brick_width * a_mortar_width), "S");
    } // union()
  } // difference()
}

// [EOF]
