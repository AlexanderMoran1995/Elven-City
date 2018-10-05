//Alex Moran cs355 povray project
// elven city spring 2017

//Full credit for the dragon models goes to Rune johansen 
// here is a link to his site: http://runevision.com/graphics/
//Everything else i made using the povray website and lohmueller's website

##include "colors.inc"
#include "textures.inc"     
#include "stones.inc"   
#include "shapes.inc"
#include "shapes2.inc"
#include "shapes3.inc"   
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "woods.inc" 

#include "Candle_2.inc" 
 


#version 3.5 
global_settings { assumed_gamma 1.6 }

// camera -----------------------------------------------------------
#declare Cam0 = camera {//ultra_wide_angle angle 90    // view inside cirty from dragon perspective
                        angle 90
                        location  <0.6 , 1.5 ,6.5>
                        look_at   <-0.4 , 0.5 , 5.5>}
#declare Cam1 = camera {//ultra_wide_angle angle 90   // view of scene from city side
                        angle 70
                        location  <1.4 , 3 ,-3>
                        look_at   <1.2 , 2 , 0.0>}  
#declare Cam2 = camera {//ultra_wide_angle angle 90    // sky view of inside city
                        angle 90
                        location  <-0.45 , 3 ,1.2>
                        look_at   <-0.45 , 0 , 1.2>} 
#declare Cam3 = camera {//ultra_wide_angle angle 90    // view of scene from tower side
                       angle 70
                        location  <2.5 , 3.2 ,15.5>
                        look_at   <2.7 , 0.2 , 8.75>} 
#declare Cam4 = camera {//ultra_wide_angle angle 90    // closeup of ground dragon to show fire detail
                        angle 70
                        location  <0.5 , 0.5 ,4.72>
                        look_at   <0.0 , 0.5 , 4.92>}      
#declare Cam5 = camera {//ultra_wide_angle angle 90     //Closeup of tower and airborn dragon
                        angle 70
                        location  <1.0 , 3.6 ,3.35>
                        look_at   <1.0 , 3.53 , 3.65>}
#declare Cam6 = camera {//ultra_wide_angle angle 90     // full view of scene 
                        angle 70
                        location  <5.8 , 4.8 ,1.6>
                        look_at   <2.2 , 2.75 , 3.9>}                                                                                                                                                
camera{Cam6}                             
// sun -------------------------------------------------------------
light_source{<1500,2500,-2500> color rgb< 1.0, 0.7, 0.25>  }  //  light orange
light_source{<-1500,2500,-2500> color rgb< 1, 0.80, 0.55>  }// very light brown
                 

// sky ---------------------------------------------------------------
// sky textures --------------------------------------------------------
#declare T_Clouds  =
texture {
    pigment { bozo
        turbulence 1.5
        octaves 10
        omega 0.5
        lambda 2.5
        color_map { [0.0 color rgbf<1, 1, 1, 1> ]
                    [0.2 color rgbf<0.85, 0.85, 0.85, 0.00>*1.5 ]
                    [0.5 color rgbf<0.95, 0.95, 0.95, 0.90>*1.12  ]
                    [0.6 color rgbf<1, 1, 1, 1> ]
                    [1.0 color rgbf<1, 1, 1, 1> ] }
    }

    finish {ambient 0.95 diffuse 0.1}
}

//--------------------------------------------------------------------
union { // make sky planes: 

 plane { <0,1,0>, 500 hollow //!!!!
        texture { bozo scale 1
                  texture_map{ 
                       [ 0.0  T_Clouds ]
                       [ 0.5  T_Clouds ]
                       [ 0.6  pigment{color rgbf<1,1,1,1> }] 
                       [ 1.0  pigment{color rgbf<1,1,1,1> }] 
                      } 
                       scale <500,1,1000>} translate<-400,0,300> } 

 plane { <0,1,0> , 10000  hollow
        texture{ pigment {color rgb<0.24,0.38,0.7>*0.50}
                 finish {ambient 1 diffuse 0}}}
scale<1.5,1,1.25>  
rotate<0,0,0> translate<0,0,0>}                          // end of sky
//--------------------------------------------------------------------

// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   50
      color      rgb<1,1,1>*0.75
      fog_offset 0.1
      fog_alt    1.5
      turbulence 1.8
    }
//-----------------------------------------------// end of ground fog
//--------------------------------------------------------------------


//  Water-------------------------------------------------------------

plane{<0,1,0>, 0 
      texture{pigment { rgb <0.2, 0.2, 0.2> } 
              normal { bozo 1.75 
                       turbulence 0.9 translate<0,0,-2>}
              finish { ambient 0.15 diffuse 0.65 
                       brilliance 6.0 phong 0.8 phong_size 120
                       reflection 0.6}
              scale <2.0,1,0.3>*0.20  rotate<0,10,0>
             }
     }
//-----------------------------------------------------// End of Water     

// Land---------------------------------------------------------------
height_field{ png "Mount2.png" smooth double_illuminate
              // file types: 
              // gif | tga | pot | png | pgm | ppm | jpeg | tiff | sys
              // [water_level N] // truncate/clip below N (0.0 ... 1.0)
              translate<-0.5,-0.0,-0.5>
              scale<9, 1.5, 9>*2 
               
                rotate<0,0,0> scale 0.5 translate<0,0,0>
              
                 //------------------------------------------------------------- 
 texture{ pigment{ color rgb< 1, 0.80, 0.55>*0.3}
          normal { pigment_pattern{ crackle turbulence 0.2
                                    colour_map {[0.00, rgb 0]
                                                [0.25, rgb 1]
                                                [0.95, rgb 1]
                                                [1.00, rgb 0]}
                                    scale 0.15} 1}

           finish  { phong 0.5 specular 0.22 }
         }// end of texture ----------------
//------------------------------------------------------------ 

                     
              rotate<0,-110,0>
              translate<1,0,11>
            } // end of height_field ----------------------------------
//--------------------------------------------------------//End of Land  
       
//Bridge--------------------------------------------------------------- 
box { <0.00, 0.00, 0.00>,< 0.30, 0.05, 1.00>   
             
               
                texture{ pigment{ color White }
                normal { pigment_pattern{
                             brick color rgb 0.2, color rgb 0.8 
                             scale 0.007  turbulence 0.9
                           } // end pigment_pattern
                         1} // end normal 
               finish { specular 0.1 diffuse 0.9 phong 1 }
               } // end of texture
         

      scale<1,1,1>*2.2  rotate<0,0,0>  translate<-1,-0.06,3.9>  }
// ------------------------------------------------------//End of Bridge 
//Foundation------------------------------------------------------------


  object{ // Round_Box(A, B, WireRadius, UseMerge)
        Round_Box(<-1,0,-1>,<1,0,1>, 0.25   , 0)  
         
                              texture{ pigment{ color White }
                normal { pigment_pattern{
                             brick color rgb 0.2, color rgb 0.8 
                             scale 0.007  turbulence 0.9
                           } // end pigment_pattern
                         1} // end normal 
               finish { specular 0.1 diffuse 0.9 phong 1 }
               } // end of texture
                
        scale<1,1,1>*2  rotate<0, 0,0> translate<-0.5,-0.4,2.3>
      } // ------------------------------------------/End of Foundation
    
                   #declare Brick_Scale     = <  0.064,0.065,0.140>; 
#declare Brick_Translate = < 0.00,-0.20,  0.30>*3;
#declare Brick_Intensity = 0.95; 
                   
                  #declare Wall_Texture_1 = // sand stone
         texture { pigment{ color rgb< 0.90, 0.78, 0.60>}
                   normal { pigment_pattern{ brick 
                                             color rgb 0.2, 
                                             color rgb 0.8 
                                             scale Brick_Scale 
                                             translate Brick_Translate
                                             rotate<0,0,0>} Brick_Intensity}
                   finish { phong 0.1 }
                 } // end of texture 
                  
#declare Wall_Texture_2 = // sand stone
         texture { pigment{ color rgb< 0.90, 0.78, 0.60>*0.95}
                            // color rgb< 0.4,1,0.0>} // test_color
                   normal { pigment_pattern{ brick 
                                             color rgb 0.2, 
                                             color rgb 0.8 
                                             scale Brick_Scale*0.55
                                             translate Brick_Translate
                                             rotate<0,90,0>} Brick_Intensity}
                   finish { phong 0.1}
                 } // end of texture                   
                  
    
//-------------------- arch -------------------------
#declare Arch = difference{
 box {<-1.1,0,-0.1>,< 1.1,1.1,0.1>}
 cylinder {<0,0,-0.11>,<0,0,0.11>,0.9 }
 texture {Wall_Texture_2  }  }
         
//--------------------------------------------------

//-------------(pillar) --------------------
#declare Pillar = union{
 torus{0.10,0.05 translate<0,1.45,0>}
 torus{0.12,0.05 translate<0,0.04,0>}
 cone {<0,0,0>,0.12,<0,1.5,0>,0.1}
 texture{pigment{ color rgb< 0.85, 0.78, 0.60>*0.8}
         normal {bumps 0.4 scale 0.007}
         finish {diffuse 0.9 phong 1}}
}//--------------------------------------------------- 
#declare Arches =
union{// --------arch upon columns -------------------
object{Pillar translate<-1,0,-1>}
object{Pillar translate< 1,0,-1>}
object{Pillar translate<-1,0, 1>}
object{Pillar translate< 1,0, 1>}
object{Arch rotate<0, 0,0> translate< 0,1.5, 1>}
object{Arch rotate<0, 0,0> translate< 0,1.5,-1>}
object{Arch rotate<0,90,0> translate< 1,1.5, 0>}
object{Arch rotate<0,90,0> translate<-1,1.5, 0>}
} // -------------------------------------------------

#declare Steps =
union{ // -------------------- stairs ----------------
box{<-1.20,0.30,-1.20>,<1.20,0.45,1.20>}
box{<-1.50,0.15,-1.50>,<1.50,0.30,1.50>}
box{<-1.80,0.00,-1.80>,<1.80,0.15,1.80>}
 texture{T_Stone8 scale 0.3 pigment{quick_color White}
         normal {bumps 0.4 scale 0.007}
         finish {diffuse 0.9 phong 1}}
 }//--------------------- end of the stairs-----------
 // -------- all together -------------------
union{object{Arches translate<-4.5,0.65,23>}
      object{Steps translate<-4.5,0.65,23>}
      scale <1,1,1>*0.13
      rotate<0,0,0>
      translate<0.1,0.20,-0.72>
      }// end of union
//---------------------------------- end  
             
//Shrine top-------------------------------------------             
object{ Pyramid  // base size <-1,-1,-1>,<1,1,1>
        scale <1,1,1>*1
                 material{ texture { Dark_Green_Glass } // end of texture 
                   interior{ I_Glass } // end of interior
                 } // end of material -------------------



        scale <1,1,1>*0.225  rotate<0, 0,0> translate<-0.49,0.8,2.28>  
      } // end of object
//-------------------------------------------------------------

#declare Tower_Base = 
    
object{ Hexagon  
        scale <3.2,1.1,1.1>*1
        texture{Wall_Texture_2
      }} // end of object 
      
      
object {Tower_Base scale <1,1,1>*0.2 rotate<0,0,90> translate<-1.7,0.6,3.68> }
object {Tower_Base scale <1,1,1>*0.2 rotate<0,0,90> translate<0.95,0.6,3.68> }
object {Tower_Base scale <1,1,1>*0.2 rotate<0,0,90> translate<0.95,0.6,1> }
object {Tower_Base scale <1,1,1>*0.2 rotate<0,0,90> translate<-1.7,0.6,1> }
       
object {Tower_Base scale <1,1,1>*0.5 rotate<0,0,90> translate<0.2,1.8,11.5> }       
//---------------------------------------------------------------------------------
      
//Walls---------------------------------------------------------------------------       
object{Arch scale <1,1,1>*1.1 rotate<0, 090,0> translate< -1.725,0, 2.38>}             
object{Arch scale <1,1,1>*1.1 rotate<0, 0,0> translate< -0.375,0, 3.6825>}      
object{Arch scale <1,1,1>*1.1 rotate<0, 90,0> translate< 0.96,0, 2.4>}      
object{Arch scale <1,1,1>*1.1 rotate<0, 0,0> translate< -0.375,0, 1.0>} 
//----------------------------------------------------End of Walls
      
                 
#declare Tower_Middle_Round =                
                 
object { //Round_Cylinder(point A, point B, Radius, EdgeRadius, UseMerge)
         Round_Cylinder(<0,0,0>, <0,1.5,0>, 0.50 ,       0.20,   0)  
         
         texture{Wall_Texture_2}
         scale<1,1,1>*1  rotate<0,0,0>}
       
 object {Tower_Middle_Round scale<2.8,0.12,2.8>*0.2  translate<-1.7,1.21,1.0>} 
 object {Tower_Middle_Round scale<2.8,0.12,2.8>*0.2  translate<-1.7,1.21,3.68>}
 object {Tower_Middle_Round scale<2.8,0.12,2.8>*0.2  translate<0.95,1.21,3.68>}
 object {Tower_Middle_Round scale<2.8,0.12,2.8>*0.2  translate<0.95,1.21,1>}
  
 object {Tower_Middle_Round scale<2.8,0.12,2.8>*0.5  translate<0.20,3.33,11.50>}
   
       
               
                                                                     
#declare Tower_Middle_Hex =    
       
object{ Round_N_Tube_Polygon ( // A round polygon tube ring with N corners 
                            6, // number of corners must be >= 3 !!!
                            0.0750,// tube radius < base width
                            1.1,     // base width (center to edge middle)
                            0.250,      // corner torus segment major radius
                            1, // 1 = filled, 0 = ring
                            1 // 0 uses union; 1 uses merge for transparent
                          ) //-------------------------------------------------
           material{ texture { Dark_Green_Glass } // end of texture 
                   interior{ I_Glass } // end of interior
                 } // end of material -------------------

  
      texture{ pigment{ color rgb<0.125,0.5,1>}
               finish { phong 1}
             } // end of texture
  
      rotate<90,90,0>
      translate<0,0,0>  
      scale <1,1,1>*1
} // end of object ---------------------------------------------------------- 

object {Tower_Middle_Hex translate< 5.27,7.0,5.56>   scale <1,1,1>*0.18 } 
object {Tower_Middle_Hex translate< 5.27,7.0,20.45>  scale <1,1,1>*0.18 } 
object {Tower_Middle_Hex translate< -9.45,7.0,20.45> scale <1,1,1>*0.18 } 
object {Tower_Middle_Hex translate< -9.45,7.0,5.56>  scale <1,1,1>*0.18 }  

object {Tower_Middle_Hex translate< 0.40,6.84,23.0> scale<1,1,1>*0.5 }



 #declare TowerArches =
union{// --------arch upon columns -------------------
object{Pillar translate<-0.5,0,-1.30>}
object{Pillar translate< 0.5,0,-1.30>}
object{Pillar translate<-1.025,0, -0.42>}
object{Pillar translate< 1.025,0, -0.42>} 
object{Pillar translate< 0.50,0, 0.5>}
object{Pillar translate<-0.50,0,0.5>}
object{Arch  scale <1,1,1>*0.5 rotate<0, 0,0> translate< 0,1.4, 0.5>}
object{Arch  scale <1,1,1>*0.5 rotate<0, 0,0> translate< 0,1.4,-1.30>}
object{Arch  scale <1,1,1>*0.5 rotate<0,60,0> translate< 0.78,1.4, 0.05>}
object{Arch  scale <1,1,1>*0.5 rotate<0,120,0> translate<-0.78,1.4, 0.05>}  
object{Arch  scale <1,1,1>*0.5 rotate<0,120,0> translate< 0.75,1.4, -0.85>}
object{Arch  scale <1,1,1>*0.5 rotate<0,60,0> translate<-0.78,1.4, -0.85>}
} // -------------------------------------------------

object{TowerArches scale <1,1,1>*0.18  translate<-1.7,1.27,1.075> }                
object{TowerArches scale <1,1,1>*0.18  translate<0.936,1.27,1.075> }             
object{TowerArches scale <1,1,1>*0.18  translate<-1.7,1.27,3.76> }                
object{TowerArches scale <1,1,1>*0.18  translate<0.936,1.27,3.76> }

object{TowerArches scale <1,1,1>*0.5   translate<0.2,3.45,11.7> } 



      
#declare Tower_Top =

sphere {<0,0,0>,0.5
        texture{ pigment{ color rgb <0.25,1,2.0>}
                 normal {bumps 0.4 scale 0.007}
         finish {diffuse 0.9 phong 0.25}}
        clipped_by{ sphere{<0,0,0>,0.5 translate<0.5,0,-0> inverse}} 
        rotate <0,0,0>
        translate <0,0,0> 
        scale <1,1,1>*1
        rotate <0,0,270> }
        
object {Tower_Top translate <-4.275,8.24,2.518>scale <2,1,2>*0.2 }         
object {Tower_Top translate <2.338,8.24,2.518> scale <2,1,2>*0.2 }         
object {Tower_Top translate <2.339,8.24,9.21>  scale <2,1,2>*0.2 }         
object {Tower_Top translate <-4.25,8.24,9.215> scale <2,1,2>*0.2 }
 
object {Tower_Top translate <0.20,9.1,11.5>    scale <2,1,2>*0.5 }
                                                                                                                                         
 //---------------------------------------------------------------------------------------                     
                
 #declare Brazier =
       
       lathe{  // rotates a 2-D outline of points around the Y axis to create a 3-D shape
  linear_spline //  linear_spline | quadratic_spline | cubic_spline
  12,      // number of points,
  <2.0, 1.0>, // list of <x,y> points,
  <2.0,-1.0>, 
  <3.0,-1.0>,
  <3.4,-2.0>,
  <4.0,-1.1>,
  <3.6,-0.9>,
  <2.6, 0.0>,
  <3.6, 0.9>,
  <4.0, 1.1>,
  <3.4, 2.0>,
  <3.0, 1.0>,
  <2.0, 1.0>    
  // sturm
  texture {  Chrome_Metal
             pigment{ color rgb<0.94,0.93,0.75>*0.25} 
             finish { phong 1 reflection { 0.3 metallic 0.75} }
          } // end of texture
  scale<1,1,1>*1 
  rotate<0,0,0> 
  translate<0,0,0>
 } // ----------------------------------------------- end of lathe object
 
  object {Brazier scale<0.1,0.1,0.1>*0.22 translate<0.938,1.29,1.0>} 
  object {Brazier scale<0.1,0.1,0.1>*0.22 translate<-1.70,1.29,1.0>}
  object {Brazier scale<0.1,0.1,0.1>*0.22 translate<0.938,1.29,3.68>}
  object {Brazier scale<0.1,0.1,0.1>*0.22 translate<-1.70,1.29,3.68>} 
  
  object {Brazier scale<0.1,0.1,0.1>*0.25 translate<-0.50,0.40,2.25>}
    
 
 
  #declare Flame =
 
 object{ Candle_2( 0.3,  // Shining_On, 0= off, >0 = intensity of candle light 
                  0, // Flame_Shadow, // >0 = intensity ; 0 = off
                  1,  // Candle_Height, relative to diameter (d=1) 
                  2.5,  // Candle_Intensity,  
                  2.7   // Candle_Flame_Scale
                  4, // Fade_Distance, //  3 ~ 5    
                  3 // Fade_Power //   2,3,4
                 ) // -------------------------
        scale 1
        rotate<0,0,0>
        translate<0,0,0> 
      } 
#declare Flame2 =
              
object{ Candle_2( 0.3,  // Shining_On, 0= off, >0 = intensity of candle light 
                  0, // Flame_Shadow, // >0 = intensity ; 0 = off
                  1,  // Candle_Height, relative to diameter (d=1) 
                  4.5,  // Candle_Intensity,  
                  3.7   // Candle_Flame_Scale
                  4, // Fade_Distance, //  3 ~ 5    
                  3 // Fade_Power //   2,3,4
                 ) // -------------------------
        scale 1
        rotate<0,0,0>
        translate<0,0,0> 
      }                 
#declare Dragon_Fire =

object{ Candle_2( 0.5,  // Shining_On, 0= off, >0 = intensity of candle light 
                  0, // Flame_Shadow, // >0 = intensity ; 0 = off
                  2,  // Candle_Height, relative to diameter (d=1) 
                  20.5,  // Candle_Intensity,  
                  2.0   // Candle_Flame_Scale
                  5, // Fade_Distance, //  3 ~ 5    
                  3 // Fade_Power //   2,3,4
                 ) // -------------------------
        scale <1,1,1>*1
        rotate<0,0,0>
        translate<0,0,0> 
      }                            
      
object {Flame2 scale .1 translate<-0.5,0.1,2.25>}

object {Flame scale .1 translate<0.94,1.10,1.0>} 
object {Flame scale .1 translate<0.94,1.10,3.67>}
object {Flame scale .1 translate<-1.7,1.10,3.7>}
object {Flame scale .1 translate<-1.7,1.10,1.0>}
 
object {Dragon_Fire scale <1.2,2.2,1.5>*0.1 rotate<70,-5,0> translate<-0.6,0.34,4.05>}                     
object {Dragon_Fire scale <1.2,2.2,1.5>*0.1 rotate<70,35,0> translate<2.05,0.9,5.62>}                                   
                                                                 
         
           
 #declare Front_Gate =       
                   
isosurface { //-------------------------------------------------------------
  function{
    f_mesh1(
       x,y,z,
       0.3, // distance between neighboring threads in the x direction,
       0.3, // distance between neighboring threads in the z direction,
       0.20, // relative thickness in the x and z directions,
       0.005, // amplitude of the weaving effect,
       0.30  // relative thickness in the y direction
    )
  }          
 contained_by {box {<-1,-1,-1>,<1,1,1>}}
 threshold 0.01
 max_gradient 8
 
                           
          texture { T_Chrome_1A
                   //normal { bumps 0.1 scale 0.15} 
                   finish { phong 1}
                 } // end of texture   
 

 rotate<90,0,0>
 scale 1
 translate< 0,0,0>
}  

#declare Solid_Gate =

 isosurface { //-------------------------------------------------------------
  function{
    f_mesh1(
       x,y,z,
       0.3, // distance between neighboring threads in the x direction,
       0.3, // distance between neighboring threads in the z direction,
       0.06, // relative thickness in the x and z directions,
       0.005, // amplitude of the weaving effect,
       0.16  // relative thickness in the y direction
    )
  }          
 contained_by {box {<-1,-1,-1>,<1,1,1>}}
 threshold 0.01
 max_gradient 8
 
 
          texture { T_Chrome_1A
                   //normal { bumps 0.1 scale 0.15} 
                   finish { phong 1}
                 } // end of texture 
 rotate<0,0,0>
 scale 1
 translate<0,0,0>
} // end of isosurface ------------------------------------------------------- 




object {Front_Gate scale 0.5 translate< 0.11,0.60,3.65>}
object {Front_Gate scale 0.5 translate< -0.94,0.60,3.65>}

object {Solid_Gate rotate<90,0,0> scale 0.5 translate< 0.08,0.60,1.0>} 
object {Solid_Gate rotate<90,0,0> scale 0.5 translate< -0.85,0.60,1.0>}
object {Solid_Gate rotate<0,0,90> scale 0.5 translate< -1.68,0.60,2.9>}
object {Solid_Gate rotate<0,0,90> scale 0.5 translate< -1.68,0.60,1.90>} 
object {Solid_Gate rotate<0,0,90> scale 0.5 translate< 0.95,0.60,2.9>} 
object {Solid_Gate rotate<0,0,90> scale 0.5 translate< 0.95,0.60,1.90>}
        
        
            
//DRAGON 1__________________________________________________________________________   


#declare Clock = clock+0.15;

#declare Mclock = sin(Clock*2*pi);

#declare Bodycolor          = <0.8,0.2,0.1>;
#declare Tummycolor         = <0.9,0.8,0.2>;

#declare Mouthopen = 30-Mclock*4; // 0 - 60
#declare Eyeopen = 8; // 0 - 10, default: 8

#declare Righthindlegrot = 70; // 25;
#declare Righthindkneerot = 130; // 80
#declare Righthindheelrot = 100; // 85
#declare Righthindfootrot   = 0;  // 0
#declare Righthindgrip = 5; // 0 - 10
#declare Righthindplanefoot = off;

#declare Lefthindlegrot = 70; // 25
#declare Lefthindkneerot = 130; // 80
#declare Lefthindheelrot = 100; // 85
#declare Lefthindfootrot   = 0;  // 0
#declare Lefthindgrip = 5; // 0 - 10
#declare Lefthindplanefoot = off;

#declare Rightforelegrot = 40; // 70
#declare Rightforeelbowrot = 110; // 90
#declare Rightforefootrot   = 0;  // 0
#declare Rightforegrip = 5; // 0 - 10
#declare Rightforeplanefoot = off;

#declare Leftforelegrot = 40; // 70
#declare Leftforeelbowrot = 110; // 90
#declare Leftforefootrot   = 0;  // 0
#declare Leftforegrip = 5; // 0 - 10
#declare Leftforeplanefoot = off;

#declare Wingrot = 90-Mclock*45; // 0 - 90, 0 = vertical, 90 = horizontal
#declare Wingbend = sin((Clock+1/4)*2*pi)*5+5; // 0 - 10
#declare Wingfold = 0; // 0 - 10

#declare Bodyrot = <0,0,0>;

#declare Body01 = <0,0,0>;
#declare Body02 = <0,0,0>;
#declare Body03 = <0,0,0>;
#declare Body04 = <0,0,0>;
#declare Body05 = <0,0,0>;
#declare Body06 = <0,0,0>;
#declare Body07 = <0,0,0>;
#declare Body08 = <0,0,0>;
#declare Body09 = <-1,0,0>*(Mclock/2+0.5);
#declare Body10 = <-3,0,0>*(Mclock/2+0.5);

#declare Neck01 = <-4,0,0>*(Mclock/2+0.5);
#declare Neck02 = <-5,0,0>*(Mclock/2+0.5);
#declare Neck03 = <-4,0,0>*(Mclock/2+0.5);
#declare Neck04 = <-3,0,0>*(Mclock/2+0.5);
#declare Neck05 = <-2,0,0>*(Mclock/2+0.5);
#declare Neck06 = <-1,0,0>*(Mclock/2+0.5);
#declare Neck07 = <+1,0,0>*(Mclock/2+0.5);
#declare Neck08 = <+3,0,0>*(Mclock/2+0.5);
#declare Neck09 = <+5,0,0>*(Mclock/2+0.5);
#declare Neck10 = <+6,0,0>*(Mclock/2+0.5);
#declare Headrot = <+5,0,0>*(Mclock/2+0.5);

#declare Tail01 = <+1,0,0>*(Mclock/2+0.5);
#declare Tail02 = <+1,0,0>*(Mclock/2+0.5);
#declare Tail03 = <+1,0,0>*(Mclock/2+0.5);
#declare Tail04 = <+1,0,0>*(Mclock/2+0.5);
#declare Tail05 = <+1,0,0>*(Mclock/2+0.5);
#declare Tail06 = <+1,0,0>*(Mclock/2+0.5);
#declare Tail07 = <+1,0,0>*(Mclock/2+0.5);
#declare Tail08 = <+1,0,0>*(Mclock/2+0.5);
#declare Tail09 = <+2,0,0>*(Mclock/2+0.5);
#declare Tail10 = <+2,0,0>*(Mclock/2+0.5);
#declare Tail11 = <+2,0,0>*(Mclock/2+0.5);
#declare Tail12 = <+2,0,0>*(Mclock/2+0.5);
#declare Tail13 = <+2,0,0>*(Mclock/2+0.5);
#declare Tail14 = <+2,0,0>*(Mclock/2+0.5);
#declare Tail15 = <+2,0,0>*(Mclock/2+0.5);
#declare Tail16 = <+2,0,0>*(Mclock/2+0.5);

#include "reddragon.inc"  
  
object {Dragon translate <180,60,-500.0> rotate <0,-135,0> scale <1,1,1>*0.015} 



//DRAGON 2___________________________________________________________________

#declare Bodycolor          = <0.8,0.2,0.1>;
#declare Tummycolor         = <0.9,0.8,0.2>;

#declare Mouthopen          = 30; // 0 - 60
#declare Eyeopen            = 8;  // 0 - 10, default: 8

#declare Righthindlegrot    = 25; // 25
#declare Righthindkneerot   = 80; // 80
#declare Righthindheelrot   = 85; // 85
#declare Righthindfootrot   = 0;  // 0
#declare Righthindgrip      = 0;  // 0 - 10
#declare Righthindplanefoot = 1;  // 0 - 1

#declare Lefthindlegrot     = 25; // 25
#declare Lefthindkneerot    = 80; // 80
#declare Lefthindheelrot    = 85; // 85
#declare Lefthindfootrot    = 0;  // 0
#declare Lefthindgrip       = 0;  // 0 - 10
#declare Lefthindplanefoot  = 1;  // 0 - 1

#declare Rightforelegrot    = 70; // 70
#declare Rightforeelbowrot  = 90; // 90
#declare Rightforefootrot   = 0;  // 0
#declare Rightforegrip      = 0;  // 0 - 10
#declare Rightforeplanefoot = 1;  // 0 - 1

#declare Leftforelegrot     = 70; // 70
#declare Leftforeelbowrot   = 90; // 90
#declare Leftforefootrot    = 0;  // 0
#declare Leftforegrip       = 0;  // 0 - 10
#declare Leftforeplanefoot  = 1;  // 0 - 1

#declare Wingrot            = 35; // 0 - 90, 90 = horizontal, 0 = vertical
#declare Wingbend           = 5;  // 0 - 10
#declare Wingfold           = 9;  // 0 - 10

#declare Bodyrot = <0,0,0>;

#declare Body01 = <+02,0,0>;
#declare Body02 = <+02,0,0>;
#declare Body03 = <+02,0,0>;
#declare Body04 = <+02,0,0>;
#declare Body05 = <+02,0,0>;
#declare Body06 = <+02,0,0>;
#declare Body07 = <+02,0,0>;
#declare Body08 = <+02,0,0>;
#declare Body09 = <-10,0,0>;
#declare Body10 = <-16,0,0>;

#declare Neck01 = <-20,0,0>;
#declare Neck02 = <-25,0,0>;
#declare Neck03 = <-20,0,0>;
#declare Neck04 = <-15,0,0>;
#declare Neck05 = <-10,0,0>;
#declare Neck06 = <-05,0,0>;
#declare Neck07 = <+05,0,0>;
#declare Neck08 = <+15,0,0>;
#declare Neck09 = <+25,0,0>;
#declare Neck10 = <+35,0,0>;

#declare Headrot = <+25,0,0>;

#declare Tail01 = <+2,0,0>;
#declare Tail02 = <+2,0,0>;
#declare Tail03 = <+2,0,0>;
#declare Tail04 = <+2,0,0>;
#declare Tail05 = <+2,0,0>;
#declare Tail06 = <+2,0,0>;
#declare Tail07 = <+2,0,0>;
#declare Tail08 = <+2,0,0>;
#declare Tail09 = <+2,0,0>;
#declare Tail10 = <+2,0,0>;
#declare Tail11 = <+2,0,0>;
#declare Tail12 = <+2,0,0>;
#declare Tail13 = <+2,0,0>;
#declare Tail14 = <+2,0,0>;
#declare Tail15 = <+2,0,0>;
#declare Tail16 = <+2,0,0>;

#include "reddragon.inc"

object {Dragon translate <40,2.5,-350> rotate <0,180,0> scale <1,1,1>*0.017}

//___________________________________________________________________________________

//---------------------------------------------------------------------------HOUSES//

#declare House_Base =                           

object{ Round_Pyramid_N_in( // defined by incircle radii 
       
        8 , // number of side faces 
        <0,00,0>, 1.20, <0,0.70,0>, 1.20, // A, radius A, B, radius B, 
        0.10, // wire radius or border radius 
        1,    // 1 = filled, 0 = wireframe
        0     // 0 = union, 1 = merge for transparent materials           
        ) //------------------------------------------------------------
          
        texture{ T_Stone23    
        normal {bumps 0.8 scale 0.007}
        finish {diffuse 0.9 phong 1} 
        rotate<0,0,0> scale 0.5 translate<0,0,0>
       } // end of texture 

        scale <0.7,1.75,0.7>*0.2 
        rotate <0,0,0>
        translate< 0.6, 0, 2>
       } // end of object ------------------------------------------------------------------ 
       

//RIGHT       
object {House_Base translate <0,0,0>}
object {House_Base translate <-0.5,0,0>} 
object {House_Base translate <-0.5,0,1>}
object {House_Base translate <0.0,0,1>}
object {House_Base translate <0.0,0,0.5>} 
object {House_Base translate <0.0,0,-0.5>}
object {House_Base translate <-0.4,0,-0.8>}


//LEFT                                
object {House_Base translate <-1.6,0,0>}
object {House_Base translate <-2.1,0,0>} 
object {House_Base translate <-2.1,0,1>}    
object {House_Base translate <-1.6,0,1>} 
object {House_Base translate <-2.1,0,0.5>}
object {House_Base translate <-2.1,0,-0.5>} 
object {House_Base translate <-1.7,0,-0.8>}   


#declare Pointy_Roof =

object{ Round_Pyramid_N_out( // defined by circumcircle radii 
                             8 , // number of side faces 
                             <0,00,0>, 1.30, <0,1.00,0>, 0.00 , // A, radius A, B, radius B, 
                             0.10, // wire radius or border radius 
                             1,   // 1 = filled, 0 = wireframe
                             0   // 0 = union, 1 = merge for transparent materials           
                           ) //------------------------------------------------------------

                 // scale your object first!!!
          texture{ pigment{ brick color Grey                   // color mortar
                                 color rgb< 0.25, 1, 2>  // color brick
                           brick_size <0.25, 0.0525, 0.125> // format in x ,y and z- direction 
                           mortar 0.01                      // size of the mortar 
                           scale 3
                        } // end of pigment
                  normal {wrinkles 0.75 scale 0.01}
                  finish {ambient 0.15 diffuse 0.95 phong 0.2} 
                  rotate<0,0,0>  translate< 0.01, 0.00, 0.00>
               } // end of texture


         scale <0.8,1.2,0.8>*0.2 
         rotate <0,20,0>
         translate< 0.1, 0.18, 2.0>
       } // end of object ------------------------------------------------------------------   
//---------------------------------------------------------------------------------- 

object {Pointy_Roof translate <0,0.08,0>} 
object {Pointy_Roof translate <0.5,0.08,0.5>} 
object {Pointy_Roof translate <0.0,0.08,1.0>} 
object {Pointy_Roof translate <-1.1,0.08,0>} 
object {Pointy_Roof translate <-1.6,0.08,0.5>} 
object {Pointy_Roof translate <-1.1,0.08,1.0>}
object {Pointy_Roof translate <-1.6,0.08,-0.5>} 
object {Pointy_Roof translate <0.5,0.08,-0.5>} 


                                                                                    
    
#declare Round_Roof =
  sphere {<0,0,0>,0.5
        texture{ pigment{ brick color Grey                   // color mortar
                                 color rgb< 0.25, 1, 2>  // color brick
                           brick_size <0.25, 0.0525, 0.125> // format in x ,y and z- direction 
                           mortar 0.01                      // size of the mortar 
                           scale 3
                        } // end of pigment
                  normal {wrinkles 0.75 scale 0.01}
                  finish {ambient 0.15 diffuse 0.95 phong 0.2} 
                  rotate<0,0,0>  translate< 0.01, 0.00, 0.00>
               } // end of texture
        clipped_by{ sphere{<0,0,0>,0.5 translate<0.5,0,-0> inverse}} 
        rotate <0,0,270>
        translate <1.51,1.0,5.0> 
        scale <2,1,2>*0.2 }
        
              
 object {Round_Roof translate <0,0.1,0>}
 object {Round_Roof translate <0,0.1,1>} 
 object {Round_Roof translate <-0.4,0.1,-0.8>} 
 object {Round_Roof translate <-2.1,0.1,0>} 
 object {Round_Roof translate <-2.1,0.1,1>}
 object {Round_Roof translate <-1.7,0.1,-0.8>}    
                                        
//----------------------------------------------------------------------------------------- 
//----------------------------------------------------------------------------------------- 

      
                                         
                       
    
                 

                        
                    
       
                                                                                         
       
                                                                                                                                                              