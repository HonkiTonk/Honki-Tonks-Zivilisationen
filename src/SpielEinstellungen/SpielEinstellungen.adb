pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Calendar;
use Ada.Wide_Wide_Text_IO, Ada.Calendar;

with GlobaleKonstanten, GlobaleVariablen, GlobaleDatentypen;

with ImSpiel, KartenGenerator, Ladezeiten, SpielEinstellungenKarten, SpielEinstellungenRasseSpieler, SpielEinstellungenSonstiges;

package body SpielEinstellungen is

   function SpielEinstellungenAuswahl
     return Integer
   is begin

      HauptAuswahl := GlobaleKonstanten.AuswahlKartengröße;

      AuswahlSchleife:
      loop

         case
           HauptAuswahl
         is
            when GlobaleKonstanten.AuswahlKartengröße =>
               HauptAuswahl := SpielEinstellungenKarten.KartengrößeWählen;

            when GlobaleKonstanten.AuswahlKartenart =>
               HauptAuswahl := SpielEinstellungenKarten.KartenartWählen;
               
            when GlobaleKonstanten.AuswahlKartenform =>
               HauptAuswahl := SpielEinstellungenKarten.KartenformWählen;

            when GlobaleKonstanten.AuswahlKartentemperatur =>
               HauptAuswahl := SpielEinstellungenKarten.KartentemperaturWählen;
               
            when GlobaleKonstanten.AuswahlKartenressourcen =>
               HauptAuswahl := SpielEinstellungenKarten.KartenressourcenWählen;
               
            when GlobaleKonstanten.AuswahlSpieleranzahl =>
               HauptAuswahl := SpielEinstellungenRasseSpieler.SpieleranzahlWählen;

            when GlobaleKonstanten.AuswahlBelegung =>
               HauptAuswahl := SpielEinstellungenRasseSpieler.SpielerbelegungWählen;

            when GlobaleKonstanten.AuswahlSchwierigkeitsgrad =>
               HauptAuswahl := SpielEinstellungenSonstiges.SchwierigkeitsgradFestlegen;
               
            when GlobaleKonstanten.AuswahlFertig =>
               exit AuswahlSchleife;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return HauptAuswahl;

            when others =>
               null;
         end case;

      end loop AuswahlSchleife;

      return AutomatischeEinstellungen;
              
   end SpielEinstellungenAuswahl;
   
   
   
   function AutomatischeEinstellungen
     return Integer
   is begin
      
      KartenGenerator.KartenGenerator;
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Spieler_Platzieren, GlobaleDatentypen.Anfangswert) := Clock;
      SpielEinstellungenRasseSpieler.StartwerteErmitteln;
      RassenVorhanden := False;
      
      SicherheitsSchleife:
      for RassenSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RassenSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when GlobaleDatentypen.Spieler_Mensch | GlobaleDatentypen.Spieler_KI =>
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
            Put_Line ("SpielEinstellungen.SpielEinstellungenAuswahl es wurden keine Rassen platziert!");
            return GlobaleKonstanten.SpielBeendenKonstante;
      end case;
         
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Spieler_Platzieren, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Spieler_Platzieren);

      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Gesamtzeit);
         
      return ImSpiel.ImSpiel;
      
   end AutomatischeEinstellungen;

end SpielEinstellungen;
