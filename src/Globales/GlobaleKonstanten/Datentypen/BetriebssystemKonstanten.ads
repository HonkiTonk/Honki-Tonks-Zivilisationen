with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextArrays;

package BetriebssystemKonstanten is
   pragma Elaborate_Body;
   
   -- Allgemein
   -- Die folgenden Zeichen sind Kopien aus Ada.Characters.Wide_Wide_Latin_1 und werden verwendet um das lokale Pragma "pragma Restrictions (No_Implementation_Units)" benutzen zu können!
   NUL : constant Wide_Wide_Character := Wide_Wide_Character'Val (0);
   SOH : constant Wide_Wide_Character := Wide_Wide_Character'Val (1);
   STX : constant Wide_Wide_Character := Wide_Wide_Character'Val (2);
   ETX : constant Wide_Wide_Character := Wide_Wide_Character'Val (3);
   EOT : constant Wide_Wide_Character := Wide_Wide_Character'Val (4);
   ENQ : constant Wide_Wide_Character := Wide_Wide_Character'Val (5);
   ACK : constant Wide_Wide_Character := Wide_Wide_Character'Val (6);
   BEL : constant Wide_Wide_Character := Wide_Wide_Character'Val (7);
   BS : constant Wide_Wide_Character := Wide_Wide_Character'Val (8);
   HT : constant Wide_Wide_Character := Wide_Wide_Character'Val (9);
   LF : constant Wide_Wide_Character := Wide_Wide_Character'Val (10);
   VT : constant Wide_Wide_Character := Wide_Wide_Character'Val (11);
   FF : constant Wide_Wide_Character := Wide_Wide_Character'Val (12);
   CR : constant Wide_Wide_Character := Wide_Wide_Character'Val (13);
   SO : constant Wide_Wide_Character := Wide_Wide_Character'Val (14);
   SI : constant Wide_Wide_Character := Wide_Wide_Character'Val (15);

   DLE : constant Wide_Wide_Character := Wide_Wide_Character'Val (16);
   DC1 : constant Wide_Wide_Character := Wide_Wide_Character'Val (17);
   DC2 : constant Wide_Wide_Character := Wide_Wide_Character'Val (18);
   DC3 : constant Wide_Wide_Character := Wide_Wide_Character'Val (19);
   DC4 : constant Wide_Wide_Character := Wide_Wide_Character'Val (20);
   NAK : constant Wide_Wide_Character := Wide_Wide_Character'Val (21);
   SYN : constant Wide_Wide_Character := Wide_Wide_Character'Val (22);
   ETB : constant Wide_Wide_Character := Wide_Wide_Character'Val (23);
   CAN : constant Wide_Wide_Character := Wide_Wide_Character'Val (24);
   EM : constant Wide_Wide_Character := Wide_Wide_Character'Val (25);
   SUB : constant Wide_Wide_Character := Wide_Wide_Character'Val (26);
   ESC : constant Wide_Wide_Character := Wide_Wide_Character'Val (27);
   FS : constant Wide_Wide_Character := Wide_Wide_Character'Val (28);
   GS : constant Wide_Wide_Character := Wide_Wide_Character'Val (29);
   RS : constant Wide_Wide_Character := Wide_Wide_Character'Val (30);
   US : constant Wide_Wide_Character := Wide_Wide_Character'Val (31);
   DEL : constant Wide_Wide_Character := Wide_Wide_Character'Val (127);
   
   Leerzeichen : constant Wide_Wide_Character := ' ';
   Bindestrich : constant Wide_Wide_Character := '-';
   Unterstrich : constant Wide_Wide_Character := '_';
   Punkt : constant Wide_Wide_Character := '.';
   
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
