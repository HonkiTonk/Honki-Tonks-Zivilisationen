pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;
with OptionenVariablen;

package body Wuerdigung is

   procedure Würdigung
   is begin
      
      -- Genau wie Informationen muss das hier eh geändert werden um mit den seperaten Tasks zu funktionieren!
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            WürdigungTerminal;
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            WürdigungSFML;
      end case;
      
   end Würdigung;
   
   
   
   procedure WürdigungTerminal
   is begin
      
      -- Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
      --                                          TextDateiExtern        => GlobaleTexte.Würdigungen,
      --                                          ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => 1,
      --                                          LetzteZeileExtern      => 1,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Leer,
      --                                          AbstandMitteExtern     => GlobaleTexte.Neue_Zeile,
      --                                          AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);
      
      -- New_Line;
      -- Eingabe.WartenEingabe;
      
      null;
      
   end WürdigungTerminal;
   
   
   
   procedure WürdigungSFML
   is begin
      
      null;
      
   end WürdigungSFML;

end Wuerdigung;
