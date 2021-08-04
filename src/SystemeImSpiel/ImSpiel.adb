pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with Wachstum, InDerStadtBauen, Karte, BefehleImSpiel, Optionen, Sichtbarkeit, Verbesserungen, ForschungAllgemein, KI, Ladezeiten, Speichern, Laden, StadtProduktion, EinheitenAllgemein, SiegBedingungen, RasseEntfernen,
     DiplomatischerZustand;

package body ImSpiel is

   function ImSpiel
     return Integer
   is begin
      
      SichtbarkeitsprüfungNotwendig := True;
      
      SpielSchleife:
      loop
         RassenSchleife:
         for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
            
            RückgabeRassen := EinzelneRassenDurchgehen (RasseExtern => RasseSchleifenwert);
            
            case
              RückgabeRassen
            is
               when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
                  return RückgabeRassen;
                  
               when RassenSchleifeVerlassenKonstante =>
                  exit RassenSchleife;
               
               when others =>
                  null;
            end case;
            
         end loop RassenSchleife;
               
         case
           GlobaleVariablen.RasseAmZugNachLaden
         is
            when GlobaleDatentypen.Leer =>   
               BerechnungenNachZugendeAllerSpieler;
               
            when others =>
               null;
         end case;
         
         if
           GlobaleVariablen.Rundengrenze > GlobaleVariablen.RundenAnzahl
         then
            return GlobaleKonstanten.HauptmenüKonstante;
               
         else
            null;
         end if;         
         
         SichtbarkeitsprüfungNotwendig := False;
            
      end loop SpielSchleife;
            
   end ImSpiel;
   
   
   
   function EinzelneRassenDurchgehen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
      
      case
        GlobaleVariablen.RassenImSpiel (RasseExtern)
      is
         when GlobaleDatentypen.Leer =>
            return GlobaleKonstanten.StartNormalKonstante;
            
         when others =>
            null;
      end case;
      
      if
        GlobaleVariablen.Grenzen (RasseExtern).RassenRundengrenze < GlobaleVariablen.RundenAnzahl
        and
          GlobaleVariablen.Grenzen (RasseExtern).RassenRundengrenze > 0
      then
         RasseEntfernen.RasseEntfernen (RasseExtern => RasseExtern);
         return GlobaleKonstanten.StartNormalKonstante;
         
      else
         null;
      end if;
            
      if
        GlobaleVariablen.RasseAmZugNachLaden = GlobaleDatentypen.Leer
        or
          RasseExtern = GlobaleVariablen.RasseAmZugNachLaden
      then
         GlobaleVariablen.RasseAmZugNachLaden := GlobaleDatentypen.Leer;
            
         case
           GlobaleVariablen.RassenImSpiel (RasseExtern)
         is                     
            when GlobaleDatentypen.Spieler_Mensch =>
               if
                 SichtbarkeitsprüfungNotwendig
               then
                  Sichtbarkeit.SichtbarkeitsprüfungFürRasse (RasseExtern => RasseExtern);
                  
               else
                  null;
               end if;
                     
               RückgabeWert := MenschlicherSpieler (RasseExtern => RasseExtern);
               if
                 (RückgabeWert = GlobaleKonstanten.SpielBeendenKonstante
                  or
                    RückgabeWert = GlobaleKonstanten.HauptmenüKonstante)
                 and
                   NochSpielerVorhanden (RasseExtern => RasseExtern) = True
               then                        
                  RasseEntfernen.RasseAufKISetzen (RasseExtern => RasseExtern);
                        
               elsif
                 RückgabeWert = GlobaleKonstanten.SpielBeendenKonstante
                 or
                   RückgabeWert = GlobaleKonstanten.HauptmenüKonstante
               then
                  return RückgabeWert;

               elsif
                 RückgabeWert = RassenSchleifeVerlassenKonstante
               then
                  return RassenSchleifeVerlassenKonstante;
                        
               else
                  null;
               end if;
                 
               -- Ist die KI, der Fall Leer kann ja gar nicht mehr auftreten.
            when others =>
               if
                 SichtbarkeitsprüfungNotwendig
               then
                  Sichtbarkeit.SichtbarkeitsprüfungFürRasse (RasseExtern => RasseExtern);
                        
               else
                  null;
               end if;
               Ladezeiten.KIZeiten (RasseExtern, GlobaleDatentypen.Anfangswert) := Clock;
               KI.KI (RasseExtern => RasseExtern);
               Ladezeiten.KIZeiten (RasseExtern, GlobaleDatentypen.Endwert) := Clock;
         end case;

      else
         null;
      end if;
      
      return GlobaleKonstanten.StartNormalKonstante;
      
   end EinzelneRassenDurchgehen;



   function MenschlicherSpieler
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
      
      SpielerSchleife:
      loop
         
         Karte.AnzeigeKarte (RasseExtern => RasseExtern);
         AktuellerBefehlSpieler := BefehleImSpiel.Befehle (RasseExtern => RasseExtern);
         
         case
           AktuellerBefehlSpieler
         is
            when GlobaleKonstanten.StartNormalKonstante =>
               null;

               -- Speichern
            when GlobaleKonstanten.SpeichernKonstante =>
               GlobaleVariablen.RasseAmZugNachLaden := RasseExtern;
               Speichern.SpeichernNeu (AutospeichernExtern => False);
               
               -- Laden
            when GlobaleKonstanten.LadenKonstante =>
               if
                 Laden.LadenNeu = True
               then
                  return RassenSchleifeVerlassenKonstante;

               else
                  null;
               end if;
               
               -- Optionen
            when GlobaleKonstanten.OptionenKonstante =>
               RückgabeOptionen := Optionen.Optionen;
               if
                 RückgabeOptionen = GlobaleKonstanten.SpielBeendenKonstante
                 or
                   RückgabeOptionen = GlobaleKonstanten.HauptmenüKonstante
               then
                  return RückgabeOptionen;
                                    
               else
                  null;
               end if;
               
               -- Spiel beenden oder Hauptmenü
            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return AktuellerBefehlSpieler;

               -- Runde beenden
            when GlobaleKonstanten.RundeBeendenKonstante =>
               return GlobaleKonstanten.StartNormalKonstante;      
                  
            when others =>
               null;
         end case;
                     
      end loop SpielerSchleife;
      
   end MenschlicherSpieler;



   procedure BerechnungenNachZugendeAllerSpieler
   is begin
            
      Ladezeiten.EinzelneZeiten (Ladezeiten.Zwischen_Runden, GlobaleDatentypen.Anfangswert) := Clock;
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
            
            case
              GlobaleVariablen.Diplomatie (RasseSchleifenwert, RasseZweiSchleifenwert).AktuellerZustand
            is
               when GlobaleDatentypen.Unbekannt =>
                  null;
                  
               when others =>
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
            end case;
            
         end loop RassenZweiSchleife;
         
      end loop RassenSchleife;
      
      SiegBedingungen.SiegBedingungen;
      Ladezeiten.EinzelneZeiten (Ladezeiten.Zwischen_Runden, GlobaleDatentypen.Endwert) := Clock;
      
      Ladezeiten.AnzeigeKIZeit (WelcheZeitExtern => GlobaleDatentypen.Leer);
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => Ladezeiten.Zwischen_Runden);      
      
   end BerechnungenNachZugendeAllerSpieler;
   
   
   
   function NochSpielerVorhanden
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseSchleifenwert = RasseExtern
           or
             GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) /= GlobaleDatentypen.Spieler_Mensch
         then
            null;
            
         else
            return True;
         end if;
         
      end loop RassenSchleife;
      
      return False;
      
   end NochSpielerVorhanden;

end ImSpiel;
