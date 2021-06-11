pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleVariablen, GlobaleKonstanten;

with Wachstum, InDerStadtBauen, Karte, BefehleImSpiel, Optionen, Sichtbarkeit, Verbesserungen, ForschungAllgemein, KI, Ladezeiten, Speichern, Laden, StadtProduktion, EinheitenAllgemein;

package body ImSpiel is

   function ImSpiel
     return Integer
   is begin
      
      SpielSchleife:
      loop         
         RassenSchleife:
         for RasseSchleifenwert in GlobaleDatentypen.Rassen'Range loop
            
            if
              GlobaleVariablen.RasseAmZugNachLaden = 0
              or
                RasseSchleifenwert = GlobaleVariablen.RasseAmZugNachLaden
            then
               GlobaleVariablen.RasseAmZugNachLaden := 0;
               case
                 GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
               is -- Einmal muss am Anfang die Sichtbarkeit geprüft werden, sonst crasht das Spiel
                  when 0 =>
                     null;
                  
                  when others =>
                     Sichtbarkeit.SichtbarkeitsprüfungFürRasse (RasseExtern => RasseSchleifenwert);
               end case;
            
               case
                 GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
               is -- 0 = Nicht belegt, 1 = Menschlicher Spieler, 2 = KI
                  when 0 =>
                     null;
                     
                  when 1 =>
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
                  
                  when 2 =>
                     Ladezeiten.KIZeiten (Positive (RasseSchleifenwert), 1) := Clock;
                     KI.KI (RasseExtern => RasseSchleifenwert);
                     Ladezeiten.KIZeiten (Positive (RasseSchleifenwert), 2) := Clock;
                     
                  when others =>
                     null;
               end case;

            else
               null;
            end if;
            
         end loop RassenSchleife;
               
         case
           GlobaleVariablen.RasseAmZugNachLaden
         is
            when 0 =>   
               BerechnungenNachZugendeAllerSpieler;
               
            when others =>
               null;
         end case;
            
      end loop SpielSchleife;
            
   end ImSpiel;



   function MenschlicherSpieler
     (RasseExtern : in GlobaleDatentypen.Rassen)
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

            when GlobaleKonstanten.SpeichernKonstante => -- Speichern
               GlobaleVariablen.RasseAmZugNachLaden := RasseExtern;
               Speichern.SpeichernNeu (AutospeichernExtern => False);
               
            when GlobaleKonstanten.LadenKonstante => -- Laden
               if
                 Laden.LadenNeu = True
               then
                  return -300;

               else
                  null;
               end if;
               
            when GlobaleKonstanten.OptionenKonstante => -- Optionen
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
               
            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante => -- Spiel beenden oder Hauptmenü
               return AktuellerBefehlSpieler;

            when -1_000 => -- Runde beenden
               return GlobaleKonstanten.StartNormalKonstante;      
                  
            when others =>
               Sichtbarkeit.SichtbarkeitsprüfungFürRasse (RasseExtern => RasseExtern);
         end case;
                     
      end loop SpielerSchleife;
      
   end MenschlicherSpieler;



   procedure BerechnungenNachZugendeAllerSpieler
   is begin
            
      Ladezeiten.EinzelneZeiten (2, 1) := Clock;
      EinheitenAllgemein.HeilungBewegungspunkteNeueRundeErmitteln;
      Verbesserungen.VerbesserungFertiggestellt;
      Wachstum.Wachstum;
      InDerStadtBauen.BauzeitAlle;
      StadtProduktion.StadtProduktionPrüfen ((0, 0));
      ForschungAllgemein.ForschungFortschritt;
      
      case
        GlobaleVariablen.RundenAnzahl
      is
         when Positive'Last =>
            null;
            
         when others =>
            GlobaleVariablen.RundenAnzahl := GlobaleVariablen.RundenAnzahl + 1;
      end case;

      case
        GlobaleVariablen.AnzahlAutosave
      is
         when 0 =>
            null;

         when others =>
            Speichern.AutoSpeichern;
      end case;      
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen'Range loop
         
         if
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = 2
         then            
            Ladezeiten.AnzeigeKIZeit (WelcheZeitExtern => Positive (RasseSchleifenwert));
            
         else
            Ladezeiten.KIZeiten (Positive (RasseSchleifenwert), 1) := Clock;
            Ladezeiten.KIZeiten (Positive (RasseSchleifenwert), 2) := Ladezeiten.KIZeiten (Positive (RasseSchleifenwert), 1);
         end if;
         
      end loop RassenSchleife;      
      Ladezeiten.EinzelneZeiten (2, 2) := Clock;
      
      Ladezeiten.AnzeigeKIZeit (WelcheZeitExtern => 19);
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => 2);      
      
   end BerechnungenNachZugendeAllerSpieler;

end ImSpiel;
