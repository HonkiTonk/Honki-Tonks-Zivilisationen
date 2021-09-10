pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleDatentypen, GlobaleVariablen, GlobaleKonstanten;
use GlobaleDatentypen;

with SchreibeWichtiges;
with LeseWichtiges;

with Wachstum, Verbesserungen, ForschungAllgemein, StadtProduktion, EinheitenAllgemein, SiegBedingungen, DiplomatischerZustand, StadtMeldungenSetzen, EinheitenMeldungenSetzen, EinheitInUmgebung,
     Ladezeiten, Speichern, Auswahl;

package body ZwischenDenRunden is

   function BerechnungenNachZugendeAllerSpieler
     return Boolean
   is begin
      
      Ladezeiten.EinzelneZeiten (Ladezeiten.Zwischen_Runden, GlobaleDatentypen.Anfangswert) := Clock;
      
      if
        WeiterSpielen = False
      then
         case
           SiegBedingungen.SiegBedingungen
         is
            when False =>
               null;
            
            when True =>
               if
                 Auswahl.AuswahlJaNein (FrageZeileExtern => 34) = GlobaleKonstanten.JaKonstante
               then
                  WeiterSpielen := True;
                                 
               else
                  return True;
               end if;
         end case;
         
      else
         null;
      end if;
      
      StadtMeldungenSetzen.StadtMeldungenSetzenRundenEnde;
      EinheitenMeldungenSetzen.EinheitenMeldungenSetzenRundenEnde;
      EinheitInUmgebung.EinheitInUmgebung;
      
      EinheitenAllgemein.HeilungBewegungspunkteNeueRundeErmitteln;
      Verbesserungen.VerbesserungFertiggestellt;
      Wachstum.Wachstum;
      StadtProduktion.StadtProduktionPrüfen ((GlobaleDatentypen.Leer, 0));
      GeldForschungMengeSetzen;
      ForschungAllgemein.ForschungFortschritt;
      
      case
        GlobaleVariablen.RundenAnzahl
      is
         when Positive'Last =>
            null;
            
         when others =>
            GlobaleVariablen.RundenAnzahl := GlobaleVariablen.RundenAnzahl + 1;
      end case;
      
      KIVorhanden := False;
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Spieler_KI
         then
            KIVorhanden := True;
            Ladezeiten.AnzeigeKIZeit (WelcheZeitExtern => RasseSchleifenwert);
            
         else
            Ladezeiten.KIZeiten (RasseSchleifenwert, GlobaleDatentypen.Anfangswert) := Clock;
            Ladezeiten.KIZeiten (RasseSchleifenwert, GlobaleDatentypen.Endwert) := Ladezeiten.KIZeiten (RasseSchleifenwert, GlobaleDatentypen.Anfangswert);
         end if;
         
         RassenZweiSchleife:
         for RasseZweiSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
            
            if
              GlobaleVariablen.Diplomatie (RasseSchleifenwert, RasseZweiSchleifenwert).AktuellerZustand = GlobaleDatentypen.Unbekannt
              or
                RasseSchleifenwert = RasseZweiSchleifenwert
                or
                  GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Leer
              or
                GlobaleVariablen.RassenImSpiel (RasseZweiSchleifenwert) = GlobaleDatentypen.Leer
            then
               null;
                  
            else
               case
                 GlobaleVariablen.Diplomatie (RasseSchleifenwert, RasseZweiSchleifenwert).ZeitSeitLetzterÄnderung
               is
                  when Natural'Last =>
                     null;
                     
                  when others =>
                     GlobaleVariablen.Diplomatie (RasseSchleifenwert, RasseZweiSchleifenwert).ZeitSeitLetzterÄnderung := GlobaleVariablen.Diplomatie (RasseSchleifenwert, RasseZweiSchleifenwert).ZeitSeitLetzterÄnderung + 1;
               end case;
            
               DiplomatischerZustand.SympathieÄndern (EigeneRasseExtern => RasseSchleifenwert,
                                                       FremdeRasseExtern => RasseZweiSchleifenwert,
                                                       ÄnderungExtern    => 1);
            end if;
            
         end loop RassenZweiSchleife;
         
      end loop RassenSchleife;

      -- Autospeichern muss hier immer als Letztes kommen, sonst werden eventuelle Änderungen nicht gespeichert.
      if
        GlobaleVariablen.NutzerEinstellungen.AnzahlAutosave = 0
      then
         null;

      else
         Speichern.AutoSpeichern;
      end if;    
            
      case
        KIVorhanden
      is
         when True =>
            Ladezeiten.AnzeigeKIZeit (WelcheZeitExtern => GlobaleDatentypen.Leer);
            
         when False =>
            null;
      end case;
      
      Ladezeiten.EinzelneZeiten (Ladezeiten.Zwischen_Runden, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => Ladezeiten.Zwischen_Runden);
      
      return False;
      
   end BerechnungenNachZugendeAllerSpieler;
   
   
   
   procedure GeldForschungMengeSetzen
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
            
            when others =>
               SchreibeWichtiges.Geldmenge (RasseExtern         => RasseSchleifenwert,
                                            GeldZugewinnExtern  => Integer (LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseSchleifenwert)),
                                            RechnenSetzenExtern => True);
               
               SchreibeWichtiges.Forschungsmenge (RasseExtern             => RasseSchleifenwert,
                                                  ForschungZugewinnExtern => LeseWichtiges.GesamteForschungsrate (RasseExtern => RasseSchleifenwert),
                                                  RechnenSetzenExtern     => True);
         end case;
         
      end loop RassenSchleife;
      
   end GeldForschungMengeSetzen;

end ZwischenDenRunden;
