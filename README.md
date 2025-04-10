# Welcome to OpenBricks!

OpenBricks is an OpenSCAD module that allows you to draw a wall with a specific brick pattern (bond).
The idea for this module was taken from the .NET "Bricks Arch" program by the Beckenham and West Wickham Model Railway Club ( http://www.bwwmrc.co.uk/bricks/index.shtml )

## Usage
openbricks( wall_length, wall_height, brick_pattern, standard_brick_length, standard_brick_height, standard_brick_width, standard_mortar_width, standard_mortar_depth, repeat_brick_pattern , texture_type);
| Parameter | Description |
| :--- | :--- |
| wall_length | The total length of the wall to be generated |
| wall_height | The total height of the wall to be generated |
| brick_pattern | an array of strings. Each string is a pattern for a row. See below for information on the patterns |
| standard_brick_length | Length of the bricks to create |
| standard_brick_height | Height of the bricks to create |
| standard_brick_width | Width of the bricks to create |
| standard_mortar_width | Width/Height of a mortar line between two bricks |
| standard_mortar_depth | Factor of brick height used to generate the mortar lines below the front of the brick  |
| repeat_brick_pattern | true: repeat pattern to match wall_length,<br>false: don't repeat the pattern for wall length. Wall can end up being be shorter than specified wall_length |
| texture_type | "n": simple cubes,<br>"r": cubes with rounded corners and vertices,<br>"t": add random texture to face of bricks |

Make sure the standard brick length/width are a proper ratio of each other or it'll be difficult to generate proper repeating bonds and/or mortar lines will align resulting in a bad looking bond.

<img src="https://en.wikipedia.org/wiki/Brickwork#/media/File:Brick_laying_2.jpg" alt="Brick dimension ratio">

## Patterns

The brick pattern should be an array of strings, where each position in a string can be any combination of the available parameters.

The first string in the array correspondes to the bottom row of bricks being generated. The first character of the string corresponds with the left hand side 
corner. The last character corresponds with the right hand side corner. The characters in between the two corners make up the bricks between the two corners.
Depending on the **repeat_brick_pattern** parameter. When **false**, these characters are placed exactly once on the entire row. When **true** they
are repeated until **wall_length** is reached.

Some bricks are marked as *Corner*, *Blank Spot*, *Spacer Spot*, or *Lap/Offset*.

Bricks marked as *Corner* should be used in either the first or last position of the pattern to create the specific type of brick at the corner of the wall. Using
these special brick types will let you ensure that a brick at the corner is a specific type. If you use a non-*Corner* type bricks as first and last characters in
he pattern, and **repeat_brick_pattern** is **true** you will not be able to know if the corner brick will be a stretcher or a header or even a full sized brick.
*Corner* bricks are drawn in the Fire Red color in the OpenSCAD preview window.

The *Blank Spot* marked bricks generate an open space in the wall the size and orientation of their corresponding type of regular brick. Bricks preceding a blank spot
will automatically not get a mortar line added. If you still want a mortar line drawn you'll have to force it with one of the mortar line patterns ("M" or "m").
For example: pattern "SMDDDMS" Will draw a stretcher brick, a full mortar line then 3 stretcher lengths of open space followed by a full mortar line then a stretcher.

A *Spacer Spot* type brick is used to reserve space for bricks that protrude into other rows. This helps generate walls that have Soldiers and Sailors in them. It also
helps generate walls where you are using the larger Quoin corner bricks. If you use a Soldier, Sailor or a Quoin brick in a row, the next few rows will need the
corresponding *Spacer Spot* in the pattern to skip placing bricks within the Soldier, Sailor or Quoin brick.

A *Lap/Offset* brick is a brick used to get the proper offset to create a specific a bond. If a *Lap/Offset* brick type is used in the second position of the pattern
and **repeat_brick_pattern** is **true** this brick will not repeat as part of the pattern. *Lap/Offset* bricks are drawn in the Orange color in the OpenSCAD preview window.

NOTE: Even if **texture_type** is set to "t", Quoin bricks will not get a texture mapped on them.

| Pattern | Brick Type | Remarks |
| :--- | :--- | :--- |
| S | Strecher | |
| s | Stretcher (Corner) | Won't repeat if used in first or last position |
| D | Strecher (Blank Spot) | |
| H | Header | |
| h | Header (Corner) | |
| d | Header (Blank Spot) | |
| Z | Quoin Stretcher | |
| X | Quoin Header  | |
| B | Quoin Sailor | |
| N | Quoin Soldier | |
| z | Quoin Stretcher (Spacer Spot) | |
| x | Quoin Header  (Spacer Spot) | |
| b | Quoin Sailor (Spacer Spot) | |
| n | Quoin Soldier (Spacer Spot) | |
| R | Shiner | Will draw without mortar above it |
| T | Shiner (Blank Spot) | |
| r | Rowlock | Will draw without mortar above it |
| t | Rowlock (Blank Spot) | |
| Q | Queen Closer (Lap/Offset)| Use this to create offsets. Won't repeat if second character in pattern |
| J | Sailor | |
| j | Sailor (Blank Spot) | |
| K | Soldier | |
| k | Soldier (Blank Spot) | |
| 0 | Full Stretcher size (Blank Spot) | |
| 1 | 1/10th Stretcher size (Blank Spot) | |
| 2 | 2/10th Stretcher Size (Blank Spot) | |
| 3 | 3/10th Stretcher Size (Blank Spot) | |
| 4 | 4/10th Stretcher Size (Blank Spot) | |
| 5 | 5/10th Stretcher Size (Blank Spot) | |
| 6 | 6/10th Stretcher Size (Blank Spot) | |
| 7 | 7/10th Stretcher Size (Blank Spot) | |
| 8 | 8/10th Stretcher Size (Blank Spot) | |
| 9 | 9/10th Stretcher Size (Blank Spot) | |
| M | Full Mortar Width | Adds an full width mortar line |
| m | 1/2 Mortar Width | Adds a mortar line half the normal mortar width |
| O | 3/4 Lap/Offset Brick | Won't repeat if second character in pattern |
| G | 1/2 Lap/Offset Brick | Won't repeat if second character in pattern |
| o | 1/4 Lap/Offset Brick | Won't repeat if second character in pattern |
| Y | 2/3 Lap/Offset Brick | Won't repeat if second character in pattern |
| y | 1/3 Lap/Offset Brick | Won't repeat if second character in pattern |
| P | 3/4 Shiner Lap/Offset Brick | Won't repeat if second character in pattern |
| g | 1/2 Shiner Lap/Offset Brick | Won't repeat if second character in pattern |
| p | 1/4 Shiner Lap/Offset Brick | Won't repeat if second character in pattern |
| U | 2/3 Shiner Lap/Offset Brick | Won't repeat if second character in pattern |
| u | 1/3 Shiner Lap/Offset Brick | Won't repeat if second character in pattern |

## Standard Variables

There are some standard global variables defined in the OpenBricks module:

**openbricks_eps** is used throughout the code to ensure objects properly overlap for making unions. Default value is *0.001*.<br>
**openbricks_radius** is used as the radius for drawing the rounded bricks when **texture_type** is set to "r". Default values is *0.25*<br>
**openbricks_resolution** is used to set the resolution for rounding the corners of bricks when **texture_type** is set to *"r"*. Default value is *15*. The higher the number the higher the rounding quality rendering is.<br>
**openbricks_file_prefix** configures where the textures for the brick surfaces are located. The Code will add a seuence number plus the ".dat" file extension. Default value is *"textures/texture"*<br>

## Example pattern

One of the simplest patterns you can make with **repeat_brick_pattern** set to **true** is as follows:

    // Strecher bond:
    my_brick_pattern = [ "sSh", "hSs" ]

Which will give you a wall with only stretchers that are half laid on top of each other by alternating the start of the row with a stretcher or a header brick. This is what's called a *stretcher bond*. Notice the use of the Corner stretcher ("s") and corner header ("h") in the first and last position in each of the two pattern strings. Even though **repeat_brick_pattern** is set to **true** these corner types in their placement within the pattern string ensures they are not repeated as part of the brick pattern within the row itself. If **wall_width** is not a proper brick length the module will generate an odd sided brick (shown in purple in the OpenSCAD preview window) before it places the final corner brick.

    // Common Bond (Flemish every 6th):
    my_brick_pattern = [ "sSh", "hSs", "sSh", "hSs","sSh", "hQSHs" ];

The *Common Bond* pattern above will create a stretcher bond for 5 rows followed by a row of Flemmish Bond. The Flemmish Bond row starts with a Queen Closer brick ("Q") in the second position of the pattern ensures the Header brick ("H") will be always centered over the mortar line between two stretcher bricks ion the row below. Note that the Queen Closer brick is not repeated as part of the pattern since it's an *Lap/Offset* type brick and in the second position. If you placed the Queen Closer brick between the Stretcher and Header bricks in the pattern it would repeat and the bond would not be a Flemmish Bond anymore. 

The best way to figure out how openbricks works is to copy the example code below and play with the my_brick_pattern array of strings. Set the dimensions of the wall not too large and create a pattern. Toggle on/off the **reapeat_brick_pattern** argument to openbricks() and see how that influences the generation of the wall. Then play with adding different types of bricks in the various pattern strings. Add more strings to the array to see how the amount of pattern strings influences the pattern of bricks in the wall.

## Example Usage

The below code snippet shows a complex example of a wall being generated with different types of bonds and bricks and a wall opening for a window. We scale this down to milimeters via scale(25.4) before scaling it down to HO scale (1:87). 

    //////////////////////////////////////
    // Example use of openbricks module //
    //////////////////////////////////////
    
    use <openbricks.scad>;
    
    // Quoin corners with window opening:
    my_brick_pattern = [
    "XHSSSSSHZ",
    "xSSSSSSz",
    "ZSSSSSSB",
    "zHSSSSSHb",
    "BSSSSSSHQb",
    "bQSHSHSHSHHb",
    "bHSHHSHHSHHQb",
    "bQSHHSHHSSHb",
    "bHSSrrrrrrSGZ",
    "bSSHttttttGSz",
    "ZSHQttttttSSoX",
    "zQSHttttttoSSx",
    "hQHSSttttttQGSQs",
    "sSSQttttttSGSh",
    "hQHSSttttttQGSQs",
    "sSSQttttttSGSh",
    "hQHSSttttttQGSQs",
    "sSSQttttttSGSh",
    "hQHSSKKKKKKQGSQs",
    "sSSQkkkkkkGSSh",
    "hQHSSkkkkkkQGSQs",
    "sYSSSSSMmYyh",
    "hSSSSSSHQs",
    "sYSSSSSMmYyh",
    ];
    
    // Repeat the brick pattern until wall width is reached:
    repeat_brick_pattern = false;
    
    // Brick dimensions in inches:
    std_mortar_width = (3/8);
    std_brick_width   = 7+(5/8);
    std_brick_height  = 2.25;
    std_brick_depth   = 3+(5/8);
    
    // Mortar depth as a factor of std_brick_depth:
    std_mortar_depth = 0.7;
    
    // Width of wall in inches:
    my_wall_width = 8*12;
    
    my_wall_rows = 24;
    
    // Height of wall in inches calculated from my_wall_rows:
    my_wall_height = (std_brick_height*my_wall_rows)+(std_mortar_width*(my_wall_rows-1));
    
    // Add texture (t) or round bricks (r) or normal (n) bricks:
    my_texture = "n";
    
    //////////
    // MAIN //
    //////////
    
    scale(25.4)  // Printing scale (to millimeters)
      scale(1/87)  // Modeling scale (HO)
      openbricks( my_wall_width, my_wall_height, my_brick_pattern, std_brick_width, std_brick_height, std_brick_depth, std_mortar_width, std_mortar_depth, repeat_brick_pattern, my_texture );
    
    // [EOF]


