pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with Karte, BefehleImSpiel, Optionen, Sichtbarkeit, KI, Ladezeiten, Speichern, Laden, RasseEntfernen, ZwischenDenRunden;

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
               ZwischenDenRunden.BerechnungenNachZugendeAllerSpieler;
               
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
                  Karte.SichtweiteBewegungsfeldFestlegen;
                  
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
               
            when GlobaleDatentypen.Spieler_KI =>
               if
                 SichtbarkeitsprüfungNotwendig
               then
                  Sichtbarkeit.SichtbarkeitsprüfungFürRasse (RasseExtern => RasseExtern);
                  Karte.SichtweiteBewegungsfeldFestlegen;
                        
               else
                  null;
               end if;
               Ladezeiten.KIZeiten (RasseExtern, GlobaleDatentypen.Anfangswert) := Clock;
               KI.KI (RasseExtern => RasseExtern);
               Ladezeiten.KIZeiten (RasseExtern, GlobaleDatentypen.Endwert) := Clock;
               
            when GlobaleDatentypen.Leer =>
               null;
               -- Dieser Fall sollte hier niemals eintreten.
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
         
         case
           GlobaleVariablen.RassenImSpiel (RasseExtern)
         is
            when GlobaleDatentypen.Spieler_Mensch =>
               null;
               
            when others =>
               return GlobaleKonstanten.HauptmenüKonstante;
         end case;
         
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
