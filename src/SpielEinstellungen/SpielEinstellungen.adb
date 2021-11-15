pragma SPARK_Mode (On);

with Ada.Calendar; use Ada.Calendar;

with GlobaleVariablen;

with ImSpiel;
with KartenGenerator;
with Ladezeiten;
with SpielEinstellungenKarten;
with SpielEinstellungenRasseSpieler;
with SpielEinstellungenSonstiges;

package body SpielEinstellungen is

   function SpielEinstellungenAuswahl
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin

      Auswahl := SystemDatentypen.Auswahl_Kartengröße;

      AuswahlSchleife:
      loop

         case
           Auswahl
         is
            when SystemDatentypen.Auswahl_Kartengröße =>
               Auswahl := SpielEinstellungenKarten.KartengrößeWählen;

            when SystemDatentypen.Auswahl_Kartenart =>
               Auswahl := SpielEinstellungenKarten.KartenartWählen;
               
            when SystemDatentypen.Auswahl_Kartenform =>
               Auswahl := SpielEinstellungenKarten.KartenformWählen;

            when SystemDatentypen.Auswahl_Kartentemperatur =>
               Auswahl := SpielEinstellungenKarten.KartentemperaturWählen;
               
            when SystemDatentypen.Auswahl_Kartenressourcen =>
               Auswahl := SpielEinstellungenKarten.KartenressourcenWählen;

            when SystemDatentypen.Auswahl_Rassen =>
               Auswahl := SpielEinstellungenRasseSpieler.RassenWählen;

            when SystemDatentypen.Auswahl_Schwierigkeitsgrad =>
               Auswahl := SpielEinstellungenSonstiges.SchwierigkeitsgradFestlegen;
               
            when SystemDatentypen.Start_Weiter =>
               exit AuswahlSchleife;

            when SystemDatentypen.Zurück_Beenden_Enum'Range =>
               return Auswahl;

            when others =>
               null;
         end case;

      end loop AuswahlSchleife;

      return AutomatischeEinstellungen;
              
   end SpielEinstellungenAuswahl;
   
   
   
   function AutomatischeEinstellungen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      KartenGenerator.KartenGenerator;
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Spieler_Platzieren, SystemDatentypen.Anfangswert) := Clock;
      SpielEinstellungenRasseSpieler.StartwerteErmitteln;
      RassenVorhanden := False;
      
      SicherheitsSchleife:
      for RassenSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RassenSchleifenwert)
         is
            when SystemDatentypen.Leer =>
               null;
               
            when SystemDatentypen.Spieler_Mensch | SystemDatentypen.Spieler_KI =>
               RassenVorhanden := True;
               exit SicherheitsSchleife;
         end case;
         
      end loop SicherheitsSchleife;
      
      case
        RassenVorhanden
      is
         when True =>
            null;
            
         when False =>
            raise Program_Error;
      end case;
         
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Spieler_Platzieren, SystemDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Spieler_Platzieren);

      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Gesamtzeit);
      
      return ImSpiel.ImSpiel;
      
   end AutomatischeEinstellungen;

end SpielEinstellungen;
