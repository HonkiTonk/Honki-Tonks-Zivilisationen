with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextArrays;

package BetriebssystemKonstanten is
   pragma Elaborate_Body;
   
   -- Allgemein
   VerboteneNamen : constant TextArrays.AllgemeinesTextArray (1 .. 2) := (
                                                                          1 => To_Unbounded_Wide_Wide_String (Source => "."),
                                                                          2 => To_Unbounded_Wide_Wide_String (Source => "..")
                                                                         );
   -- Allgemein
   
   
   
   -- Linux
   
   -- Linux
   
   
   
   -- Windows
   VerboteneWindowsnamenGroß : constant TextArrays.AllgemeinesTextArray (1 .. 25) := (
                                                                                       1 => To_Unbounded_Wide_Wide_String (Source => "AUX"),
                                                                                       2 => To_Unbounded_Wide_Wide_String (Source => "CLOCK$"),
                                                                                       3 => To_Unbounded_Wide_Wide_String (Source => "CON"),
                                                                                       4 => To_Unbounded_Wide_Wide_String (Source => "PRN"),
                                                                                       5 => To_Unbounded_Wide_Wide_String (Source => "COM0"),
                                                                                       6 => To_Unbounded_Wide_Wide_String (Source => "COM1"),
                                                                                       7 => To_Unbounded_Wide_Wide_String (Source => "COM2"),
                                                                                       8 => To_Unbounded_Wide_Wide_String (Source => "COM3"),
                                                                                       9 => To_Unbounded_Wide_Wide_String (Source => "COM4"),
                                                                                       10 => To_Unbounded_Wide_Wide_String (Source => "COM5"),
                                                                                       11 => To_Unbounded_Wide_Wide_String (Source => "COM6"),
                                                                                       12 => To_Unbounded_Wide_Wide_String (Source => "COM7"),
                                                                                       13 => To_Unbounded_Wide_Wide_String (Source => "COM8"),
                                                                                       14 => To_Unbounded_Wide_Wide_String (Source => "COM9"),
                                                                                       15 => To_Unbounded_Wide_Wide_String (Source => "LPT0"),
                                                                                       16 => To_Unbounded_Wide_Wide_String (Source => "LPT1"),
                                                                                       17 => To_Unbounded_Wide_Wide_String (Source => "LPT2"),
                                                                                       18 => To_Unbounded_Wide_Wide_String (Source => "LPT3"),
                                                                                       19 => To_Unbounded_Wide_Wide_String (Source => "LPT4"),
                                                                                       20 => To_Unbounded_Wide_Wide_String (Source => "LPT5"),
                                                                                       21 => To_Unbounded_Wide_Wide_String (Source => "LPT6"),
                                                                                       22 => To_Unbounded_Wide_Wide_String (Source => "LPT7"),
                                                                                       23 => To_Unbounded_Wide_Wide_String (Source => "LPT8"),
                                                                                       24 => To_Unbounded_Wide_Wide_String (Source => "LPT9"),
                                                                                       25 => To_Unbounded_Wide_Wide_String (Source => "NUL")
                                                                                      );
   
   VerboteneWindowsnamenKlein : constant TextArrays.AllgemeinesTextArray (VerboteneWindowsnamenGroß'Range) := (
                                                                                                                1 => To_Unbounded_Wide_Wide_String (Source => "aux"),
                                                                                                                2 => To_Unbounded_Wide_Wide_String (Source => "clock$"),
                                                                                                                3 => To_Unbounded_Wide_Wide_String (Source => "con"),
                                                                                                                4 => To_Unbounded_Wide_Wide_String (Source => "prn"),
                                                                                                                5 => To_Unbounded_Wide_Wide_String (Source => "com0"),
                                                                                                                6 => To_Unbounded_Wide_Wide_String (Source => "com1"),
                                                                                                                7 => To_Unbounded_Wide_Wide_String (Source => "com2"),
                                                                                                                8 => To_Unbounded_Wide_Wide_String (Source => "com3"),
                                                                                                                9 => To_Unbounded_Wide_Wide_String (Source => "com4"),
                                                                                                                10 => To_Unbounded_Wide_Wide_String (Source => "com5"),
                                                                                                                11 => To_Unbounded_Wide_Wide_String (Source => "com6"),
                                                                                                                12 => To_Unbounded_Wide_Wide_String (Source => "com7"),
                                                                                                                13 => To_Unbounded_Wide_Wide_String (Source => "com8"),
                                                                                                                14 => To_Unbounded_Wide_Wide_String (Source => "com9"),
                                                                                                                15 => To_Unbounded_Wide_Wide_String (Source => "lpt0"),
                                                                                                                16 => To_Unbounded_Wide_Wide_String (Source => "lpt1"),
                                                                                                                17 => To_Unbounded_Wide_Wide_String (Source => "lpt2"),
                                                                                                                18 => To_Unbounded_Wide_Wide_String (Source => "lpt3"),
                                                                                                                19 => To_Unbounded_Wide_Wide_String (Source => "lpt4"),
                                                                                                                20 => To_Unbounded_Wide_Wide_String (Source => "lpt5"),
                                                                                                                21 => To_Unbounded_Wide_Wide_String (Source => "lpt6"),
                                                                                                                22 => To_Unbounded_Wide_Wide_String (Source => "lpt7"),
                                                                                                                23 => To_Unbounded_Wide_Wide_String (Source => "lpt8"),
                                                                                                                24 => To_Unbounded_Wide_Wide_String (Source => "lpt9"),
                                                                                                                25 => To_Unbounded_Wide_Wide_String (Source => "nul")
                                                                                                               );
   
   
   -- Windows

end BetriebssystemKonstanten;
