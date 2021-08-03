pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleVariablen, GlobaleKonstanten, GlobaleDatentypen, GlobaleTexte;

with Auswahl, ZufallGeneratorenSpieleinstellungen;

package body SpielEinstellungenSonstiges is

   function SchwierigkeitsgradFestlegen
     return Integer
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
               GlobaleVariablen.Schwierigkeitsgrad := GlobaleDatentypen.Schwierigkeitsgrad_Verwendet_Enum'Val (SchwierigkeitAuswahl);
               return GlobaleKonstanten.AuswahlFertig;

            when 4 =>
               GlobaleVariablen.Schwierigkeitsgrad := ZufallGeneratorenSpieleinstellungen.ZufälligerSchwiewrigkeitsgrad;
               return GlobaleKonstanten.AuswahlFertig;
               
            when GlobaleKonstanten.ZurückKonstante =>
               return GlobaleKonstanten.AuswahlBelegung;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return SchwierigkeitAuswahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop SpieleranzahlSchleife;
      
   end SchwierigkeitsgradFestlegen;

end SpielEinstellungenSonstiges;
