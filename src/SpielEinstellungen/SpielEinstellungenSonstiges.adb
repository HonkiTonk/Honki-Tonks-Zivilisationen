pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_9; use Ada.Characters.Wide_Wide_Latin_9;

with GlobaleVariablen;
with SystemKonstanten;
with GlobaleTexte;

with Auswahl;
with ZufallGeneratorenSpieleinstellungen;

package body SpielEinstellungenSonstiges is

   function SchwierigkeitsgradFestlegen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SpieleranzahlSchleife:
      loop

         SchwierigkeitAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Spiel_Einstellungen,
                                                  TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                                  FrageZeileExtern  => 64,
                                                  ErsteZeileExtern  => 65,
                                                  LetzteZeileExtern => 71);
         
         case
           SchwierigkeitAuswahl
         is
            when 1 .. 3 =>
               GlobaleVariablen.Schwierigkeitsgrad := SystemDatentypen.Schwierigkeitsgrad_Verwendet_Enum'Val (SchwierigkeitAuswahl);
               return SystemKonstanten.AuswahlFertig;

            when 4 =>
               GlobaleVariablen.Schwierigkeitsgrad := ZufallGeneratorenSpieleinstellungen.ZufälligerSchwiewrigkeitsgrad;
               return SystemKonstanten.AuswahlFertig;
               
            when SystemDatentypen.Zurück =>
               return SystemKonstanten.AuswahlBelegung;

            when SystemDatentypen.Spiel_Beenden | SystemDatentypen.Hauptmenü =>
               return SchwierigkeitAuswahl;
               
            when SystemDatentypen.Leer =>
               null;
               
            when others =>
               raise Program_Error;
         end case;
         
      end loop SpieleranzahlSchleife;
      
   end SchwierigkeitsgradFestlegen;

end SpielEinstellungenSonstiges;
