pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleKonstanten;

with Wachstum, InDerStadtBauen, Karte, BefehleImSpiel, Optionen, Sichtbarkeit, Verbesserungen, ForschungAllgemein, KI, Ladezeiten, Speichern, Laden, StadtProduktion, EinheitenAllgemein;

package body ImSpiel is

   function ImSpiel
     return Integer
   is begin
      
      SichtbarkeitsprüfungNotwendig := True;
      
      SpielSchleife:
      loop         
         RassenSchleife:
         for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
            
            if
              GlobaleVariablen.RasseAmZugNachLaden = GlobaleDatentypen.Leer
              or
                RasseSchleifenwert = GlobaleVariablen.RasseAmZugNachLaden
            then
               GlobaleVariablen.RasseAmZugNachLaden := GlobaleDatentypen.Leer;
            
               case
                 GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
               is
                  when GlobaleDatentypen.Leer =>
                     null;
                     
                  when GlobaleDatentypen.Spieler_Mensch =>
                     if
                       SichtbarkeitsprüfungNotwendig
                     then
                        Sichtbarkeit.SichtbarkeitsprüfungFürRasse (RasseExtern => RasseSchleifenwert);
                        
                     else
                        null;
                     end if;
                     
                     RückgabeWert := MenschlicherSpieler (RasseExtern => RasseSchleifenwert);
                     if
                       RückgabeWert = GlobaleKonstanten.SpielBeendenKonstante
                       or
                         RückgabeWert = GlobaleKonstanten.HauptmenüKonstante
                     then
                        return RückgabeWert;

                     elsif
                       RückgabeWert = -300
                     then
                        exit RassenSchleife;
                        
                     else
                        null;
                     end if;
                  
                  when GlobaleDatentypen.Spieler_KI =>
                     if
                       SichtbarkeitsprüfungNotwendig
                     then
                        Sichtbarkeit.SichtbarkeitsprüfungFürRasse (RasseExtern => RasseSchleifenwert);
                        
                     else
                        null;
                     end if;
                     Ladezeiten.KIZeiten (GlobaleDatentypen.Rassen_Enum'Pos (RasseSchleifenwert), GlobaleDatentypen.Anfangswert) := Clock;
                     KI.KI (RasseExtern => RasseSchleifenwert);
                     Ladezeiten.KIZeiten (GlobaleDatentypen.Rassen_Enum'Pos (RasseSchleifenwert), GlobaleDatentypen.Endwert) := Clock;
               end case;

            else
               null;
            end if;
            
         end loop RassenSchleife;
               
         case
           GlobaleVariablen.RasseAmZugNachLaden
         is
            when GlobaleDatentypen.Leer =>   
               BerechnungenNachZugendeAllerSpieler;
               
            when others =>
               null;
         end case;
         
         SichtbarkeitsprüfungNotwendig := False;
            
      end loop SpielSchleife;
            
   end ImSpiel;



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
                  return -300;

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
            when -1_000 =>
               return GlobaleKonstanten.StartNormalKonstante;      
                  
            when others =>
               Sichtbarkeit.SichtbarkeitsprüfungFürRasse (RasseExtern => RasseExtern);
         end case;
                     
      end loop SpielerSchleife;
      
   end MenschlicherSpieler;



   procedure BerechnungenNachZugendeAllerSpieler
   is begin
            
      Ladezeiten.EinzelneZeiten (2, GlobaleDatentypen.Anfangswert) := Clock;
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
            Ladezeiten.AnzeigeKIZeit (WelcheZeitExtern => GlobaleDatentypen.Rassen_Enum'Pos (RasseSchleifenwert));
            
         else
            Ladezeiten.KIZeiten (GlobaleDatentypen.Rassen_Enum'Pos (RasseSchleifenwert), GlobaleDatentypen.Anfangswert) := Clock;
            Ladezeiten.KIZeiten (GlobaleDatentypen.Rassen_Enum'Pos (RasseSchleifenwert), GlobaleDatentypen.Endwert)
              := Ladezeiten.KIZeiten (GlobaleDatentypen.Rassen_Enum'Pos (RasseSchleifenwert), GlobaleDatentypen.Anfangswert);
         end if;
         
      end loop RassenSchleife;      
      Ladezeiten.EinzelneZeiten (2, GlobaleDatentypen.Endwert) := Clock;
      
      Ladezeiten.AnzeigeKIZeit (WelcheZeitExtern => 19);
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => 2);      
      
   end BerechnungenNachZugendeAllerSpieler;

end ImSpiel;
