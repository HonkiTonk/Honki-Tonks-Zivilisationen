with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package BetriebssystemKonstanten is
   pragma Elaborate_Body;
   
   -- Linux
   
   -- Linux
   
   
   
   -- Windows
   type VerboteneWindowsnamenArray is array (1 .. 24) of Unbounded_Wide_Wide_String;
   VerboteneWindowsnamen : constant VerboteneWindowsnamenArray := (
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
                                                                   24 => To_Unbounded_Wide_Wide_String (Source => "LPT9")
                                                                  );
   
   
   -- Windows

end BetriebssystemKonstanten;
