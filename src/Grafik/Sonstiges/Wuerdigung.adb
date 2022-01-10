pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with GlobaleTexte;
with GlobaleVariablen;
with SystemDatentypen;

with Eingabe;
with Anzeige;

package body Wuerdigung is

   procedure Würdigung
   is begin
      
      -- Genau wie Informationen muss das hier eh geändert werden um mit den seperaten Tasks zu funktionieren!
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Grafik_Konsole =>
            WürdigungKonsole;
            
         when SystemDatentypen.Grafik_SFML =>
            WürdigungSFML;
      end case;
      
   end Würdigung;
   
   
   
   procedure WürdigungKonsole
   is begin
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Würdigungen,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 1,
                                     LetzteZeileExtern      => 1,
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Neue_Zeile,
                                     AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);
      
      New_Line;
      Eingabe.WartenEingabe;
      
   end WürdigungKonsole;
   
   
   
   procedure WürdigungSFML
   is begin
      
      null;
      
   end WürdigungSFML;

end Wuerdigung;
