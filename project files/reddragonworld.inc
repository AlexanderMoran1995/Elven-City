// POV-Ray 3.1 Include File
// File used for "reddragon.pov" and "reddragonflying.pov"
// copyright February 1999 Rune S. Johansen
//
// This is the scene for the dragon,
// including landscape, background, fog, and light.

light_source {<-2,+3,+1>*1000000 color 1}

fog {
   fog_type 2
   distance 1500
   color <0.7,0.7,0.7,0.3,0.0>
   fog_offset 0
   fog_alt    100
   turbulence 0.0
}

sky_sphere {
   pigment {
      gradient y
      turbulence 0.05
      octaves 7
      lambda 5.0
      omega 0.6
      color_map {
         [0.00 color <1.0,1.0,1.0>]
         [0.30 color <1.0,0.9,1.0>]
         [0.50 color <0.8,0.6,0.7>]
         [0.57 color <0.6,0.1,0.9>]
         [0.73 color <0.4,0.0,0.8>]
         [1.00 color <0.0,0.0,0.7>]
      }
      translate -0.5*y
      scale 4
   }
}

height_field {
   tga "reddragonhf1.tga"
   translate <-0.5,-0.1,-0.5>
   scale <20000,400,20000>
   pigment {
      spotted
      scale 0.1
      color_map {
         [0 rgb 0.4]
         [1 rgb 0.6]
      }
   }
   normal {
      bumps 1
      scale <1,5,1>*200
   }
   rotate 45*y
}

height_field {
   tga "reddragonhf1.tga"
   translate <-0.5,-0.2,-0.5>
   scale <1000,50,1000>
   pigment {
      spotted
      scale 0.01
      color_map {
         [0 rgb 0.6]
         [1 rgb 0.7]
      }
   }
   normal {
      crackle 25
      scale <30,6,30>
   }
   rotate y*-30
}

height_field {
   tga "reddragonhf2.tga"
   translate <-0.5,-0.6,-0.5>
   scale <3000,40,3000>
   pigment {
      bumps
      scale 0.3*<1,5,1>
      color_map {
         [0.0, color <0.3,0.7,0.0>]
         [1.0, color <0.5,0.4,0.2>]
      }
   }
   normal {bumps 2 scale 0.1*<1,5,1>}
}

plane {
   y, 0
   pigment {
      spotted
      scale 2
      turbulence 0.5
      color_map {
         [0.0 color <1.0,0.9,0.5>*0.6]
         [0.2 color <1.0,0.9,0.5>*0.8]
         [1.0 color <1.0,0.9,0.5>*1.0]
      }
   }
   normal {
      crackle 5
      scale 10
      turbulence 0.5
      slope_map {
         [0.0, <-1,+1>]
         [0.2, <+0,+1>]
         [0.2, <+0,+0>]
         [1.0, <+0,+0>]
      }
   }
}

#declare Seed = seed(321);
#declare Number = 100;
#declare Count = 0;
#while (Count<Number)
union {
   cone {
      20*y, 20, 80*y, 1
      texture {
         pigment {color <0.1,0.5,0.0>}
         normal {bumps 2 scale <3,1,3>}
      }
   }
   cone {
      -1*y, 2.9, 21*y, 2.6
      pigment {color <3,2,1>}
      normal {bumps 2 scale <1,1,1>}
   }
   translate (3000+(rand(Seed)*2-1)*1000)*x
   rotate (30+(rand(Seed)*2-1)*15)*y
}
#declare Count = Count+1;
#end

#declare Seed = seed(654);
#declare Number = 30;
#declare Count = 0;
#while (Count<Number)
sphere {
   0, 1
   scale <12,16,13>
   texture {
      pigment {color <0.2,0.4,0.2>}
      normal {bumps 2 scale 1}
   }
   translate (1000+(rand(Seed)*2-1)*500)*x
   rotate (40+(rand(Seed)*2-1)*15)*y
}
#declare Count = Count+1;
#end
