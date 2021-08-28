pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

with Wachstum, InDerStadtBauen, Verbesserungen, ForschungAllgemein, StadtProduktion, EinheitenAllgemein, SiegBedingungen, DiplomatischerZustand, StadtMeldungenSetzen, EinheitenMeldungenSetzen, EinheitInUmgebung,
     Ladezeiten, Speichern;

package body ZwischenDenRunden is

   procedure BerechnungenNachZugendeAllerSpieler
   is begin
      
      Ladezeiten.EinzelneZeiten (Ladezeiten.Zwischen_Runden, GlobaleDatentypen.Anfangswert) := Clock;
      StadtMeldungenSetzen.StadtMeldungenSetzenRundenEnde;
      EinheitenMeldungenSetzen.EinheitenMeldungenSetzenRundenEnde;
      EinheitInUmgebung.EinheitInUmgebung;
      
      EinheitenAllgemein.HeilungBewegungspunkteNeueRundeErmitteln;
      Verbesserungen.VerbesserungFertiggestellt;
      Wachstum.Wachstum;
      InDerStadtBauen.BauzeitAlle;
      StadtProduktion.StadtProduktionPrüfen ((GlobaleDatentypen.Leer, 0));
      ForschungAllgemein.ForschungFortschritt;
      
      case
        GlobaleVariablen.RundenAnzahl
      is
         when Positive'Last =>
            null;
            
         when others =>
            GlobaleVariablen.RundenAnzahl := GlobaleVariablen.RundenAnzahl + 1;
      end case;

      if
        GlobaleVariablen.NutzerEinstellungen.AnzahlAutosave = 0
      then
         null;

      else
         Speichern.AutoSpeichern;
      end if;      
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Spieler_KI
         then            
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
               if
                 GlobaleVariablen.Diplomatie (RasseSchleifenwert, RasseZweiSchleifenwert).ZeitSeitLetzterÄnderung + 1 > Natural'Last
               then
                  GlobaleVariablen.Diplomatie (RasseSchleifenwert, RasseZweiSchleifenwert).ZeitSeitLetzterÄnderung := Natural'Last;
               
               else
                  GlobaleVariablen.Diplomatie (RasseSchleifenwert, RasseZweiSchleifenwert).ZeitSeitLetzterÄnderung := GlobaleVariablen.Diplomatie (RasseSchleifenwert, RasseZweiSchleifenwert).ZeitSeitLetzterÄnderung + 1;
               end if;
            
               DiplomatischerZustand.SympathieÄndern (EigeneRasseExtern => RasseSchleifenwert,
                                                       FremdeRasseExtern => RasseZweiSchleifenwert,
                                                       ÄnderungExtern    => 1);
            end if;
            
         end loop RassenZweiSchleife;
         
      end loop RassenSchleife;
      
      SiegBedingungen.SiegBedingungen;
      Ladezeiten.EinzelneZeiten (Ladezeiten.Zwischen_Runden, GlobaleDatentypen.Endwert) := Clock;
      
      Ladezeiten.AnzeigeKIZeit (WelcheZeitExtern => GlobaleDatentypen.Leer);
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => Ladezeiten.Zwischen_Runden);      
      
   end BerechnungenNachZugendeAllerSpieler;

end ZwischenDenRunden;
