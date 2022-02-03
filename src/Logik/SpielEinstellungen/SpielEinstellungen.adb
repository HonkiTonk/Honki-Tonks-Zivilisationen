pragma SPARK_Mode (On);

with Ada.Calendar; use Ada.Calendar;

with GlobaleVariablen;
with SystemKonstanten;

with ImSpiel;
with KartenGenerator;
with LadezeitenDatentypen;
with SpielEinstellungenKarten;
with SpielEinstellungenRasseSpieler;
with SpielEinstellungenSonstiges;
with Fehler;
with Ladezeiten;

package body SpielEinstellungen is

   function SpielEinstellungenAuswahl
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin

      Auswahl := SystemKonstanten.AuswahlKartengrößeKonstante;

      AuswahlSchleife:
      loop

         case
           Auswahl
         is
            when SystemKonstanten.AuswahlKartengrößeKonstante =>
               Auswahl := SpielEinstellungenKarten.KartengrößeWählen;

            when SystemKonstanten.AuswahlKartenartKonstante =>
               Auswahl := SpielEinstellungenKarten.KartenartWählen;
               
            when SystemKonstanten.AuswahlKartenformKonstante =>
               Auswahl := SpielEinstellungenKarten.KartenformWählen;

            when SystemKonstanten.AuswahlKartentemperaturKonstante =>
               Auswahl := SpielEinstellungenKarten.KartentemperaturWählen;
               
            when SystemKonstanten.AuswahlKartenressourcenKonstante =>
               Auswahl := SpielEinstellungenKarten.KartenressourcenWählen;

            when SystemKonstanten.AuswahlRassenKonstante =>
               Auswahl := SpielEinstellungenRasseSpieler.RassenWählen;

            when SystemKonstanten.AuswahlSchwierigkeitsgradKonstante =>
               Auswahl := SpielEinstellungenSonstiges.SchwierigkeitsgradFestlegen;
               
            when SystemKonstanten.StartWeiterKonstante =>
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
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Spieler_Platzieren, SystemDatentypen.Anfangswert) := Clock;
      SpielEinstellungenRasseSpieler.StartwerteErmitteln;
      RassenVorhanden := False;
      
      SicherheitsSchleife:
      for RassenSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RassenSchleifenwert)
         is
            when SystemKonstanten.LeerSpielerKonstante =>
               null;
               
            when SystemKonstanten.SpielerMenschKonstante | SystemKonstanten.SpielerKIKonstante =>
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
            Fehler.LogikStopp (FehlermeldungExtern => "SpielEinstellungen.AutomatischeEinstellungen - Es konnte keine Rasse platziert werden.");
      end case;
         
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Spieler_Platzieren, SystemDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Spieler_Platzieren);

      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Gesamtzeit);
      
      return ImSpiel.ImSpiel;
      
   end AutomatischeEinstellungen;

end SpielEinstellungen;
