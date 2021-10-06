pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Calendar; use Ada.Calendar;

with GlobaleVariablen;
with SystemDatentypen;
with SystemKonstanten;
with SonstigeDatentypen;

with ImSpiel;
with KartenGenerator;
with Ladezeiten;
with SpielEinstellungenKarten;
with SpielEinstellungenRasseSpieler;
with SpielEinstellungenSonstiges;

package body SpielEinstellungen is

   function SpielEinstellungenAuswahl
     return Integer
   is begin

      HauptAuswahl := SystemKonstanten.AuswahlKartengröße;

      AuswahlSchleife:
      loop

         case
           HauptAuswahl
         is
            when SystemKonstanten.AuswahlKartengröße =>
               HauptAuswahl := SpielEinstellungenKarten.KartengrößeWählen;

            when SystemKonstanten.AuswahlKartenart =>
               HauptAuswahl := SpielEinstellungenKarten.KartenartWählen;
               
            when SystemKonstanten.AuswahlKartenform =>
               HauptAuswahl := SpielEinstellungenKarten.KartenformWählen;

            when SystemKonstanten.AuswahlKartentemperatur =>
               HauptAuswahl := SpielEinstellungenKarten.KartentemperaturWählen;
               
            when SystemKonstanten.AuswahlKartenressourcen =>
               HauptAuswahl := SpielEinstellungenKarten.KartenressourcenWählen;
               
            when SystemKonstanten.AuswahlSpieleranzahl =>
               HauptAuswahl := SpielEinstellungenRasseSpieler.SpieleranzahlWählen;

            when SystemKonstanten.AuswahlBelegung =>
               HauptAuswahl := SpielEinstellungenRasseSpieler.SpielerbelegungWählen;

            when SystemKonstanten.AuswahlSchwierigkeitsgrad =>
               HauptAuswahl := SpielEinstellungenSonstiges.SchwierigkeitsgradFestlegen;
               
            when SystemKonstanten.AuswahlFertig =>
               exit AuswahlSchleife;

            when SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante =>
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
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Spieler_Platzieren, SystemDatentypen.Anfangswert) := Clock;
      SpielEinstellungenRasseSpieler.StartwerteErmitteln;
      RassenVorhanden := False;
      
      SicherheitsSchleife:
      for RassenSchleifenwert in SonstigeDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RassenSchleifenwert)
         is
            when SonstigeDatentypen.Leer =>
               null;
               
            when SonstigeDatentypen.Spieler_Mensch | SonstigeDatentypen.Spieler_KI =>
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
            raise Program_Error;
      end case;
         
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Spieler_Platzieren, SystemDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Spieler_Platzieren);

      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Gesamtzeit);
         
      return ImSpiel.ImSpiel;
      
   end AutomatischeEinstellungen;

end SpielEinstellungen;
