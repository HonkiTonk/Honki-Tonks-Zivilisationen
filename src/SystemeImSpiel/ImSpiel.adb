pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with Karte, BefehleImSpiel, Optionen, KI, Ladezeiten, Speichern, Laden, RasseEntfernen, ZwischenDenRunden;

package body ImSpiel is

   function ImSpiel
     return Integer
   is begin
            
      Karte.SichtweiteBewegungsfeldFestlegen;
      
      SpielSchleife:
      loop
         RassenSchleife:
         for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
            
            RückgabeRassen := RasseImSpiel (RasseExtern => RasseSchleifenwert);
            
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
               
         if
           GlobaleVariablen.RasseAmZugNachLaden = GlobaleDatentypen.Leer
           and
             ZwischenDenRunden.BerechnungenNachZugendeAllerSpieler = True
         then
            return GlobaleKonstanten.HauptmenüKonstante;
            
         else
            null;
         end if;
         
         if
           GlobaleVariablen.Rundengrenze > GlobaleVariablen.RundenAnzahl
         then
            return GlobaleKonstanten.HauptmenüKonstante;
            
         else
            null;
         end if;
            
      end loop SpielSchleife;
            
   end ImSpiel;
   
   
   
   function RasseImSpiel
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
      
      if
        GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Leer
      then
         return GlobaleKonstanten.StartNormalKonstante;
      
      elsif
        GlobaleVariablen.Grenzen (RasseExtern).RassenRundengrenze < GlobaleVariablen.RundenAnzahl
        and
          GlobaleVariablen.Grenzen (RasseExtern).RassenRundengrenze > 0
      then
         RasseEntfernen.RasseEntfernen (RasseExtern => RasseExtern);
         return GlobaleKonstanten.StartNormalKonstante;
         
      else
         return RasseDurchgehen (RasseExtern => RasseExtern);
      end if;
      
   end RasseImSpiel;
   
   
   
   function RasseDurchgehen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
            
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
               return MenschlicherSpieler (RasseExtern => RasseExtern);
               
            when GlobaleDatentypen.Spieler_KI =>
               KISpieler (RasseExtern => RasseExtern);
               
            when GlobaleDatentypen.Leer =>
               -- Dieser Fall sollte hier niemals eintreten.
               raise Program_Error;
         end case;

      else
         null;
      end if;
      
      return GlobaleKonstanten.StartNormalKonstante;
      
   end RasseDurchgehen;
   
   
   
   procedure KISpieler
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      Ladezeiten.KIZeiten (RasseExtern, GlobaleDatentypen.Anfangswert) := Clock;
      KI.KI (RasseExtern => RasseExtern);
      Ladezeiten.KIZeiten (RasseExtern, GlobaleDatentypen.Endwert) := Clock;
      
   end KISpieler;
   
   
   
   function MenschlicherSpieler
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
                           
      RückgabeWert := MenschAmZug (RasseExtern => RasseExtern);
      
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
      
      return GlobaleKonstanten.StartNormalKonstante;
      
   end MenschlicherSpieler;



   function MenschAmZug
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
      
      SpielerSchleife:
      loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseExtern)
         is
            when GlobaleDatentypen.Spieler_Mensch =>
               Karte.AnzeigeKarte (RasseExtern => RasseExtern);
               AktuellerBefehlSpieler := BefehleImSpiel.Befehle (RasseExtern => RasseExtern);
               
            when others =>
               -- Sollte niemals auftreten? Könnte auftreten wenn der Spieler eliminiert wird oder auf KI gesetzt wird? Mal ein besseres System bauen.
               return GlobaleKonstanten.HauptmenüKonstante;
         end case;
         
         case
           AktuellerBefehlSpieler
         is
            when GlobaleKonstanten.StartNormalKonstante =>
               null;

            when GlobaleKonstanten.SpeichernKonstante =>
               GlobaleVariablen.RasseAmZugNachLaden := RasseExtern;
               Speichern.SpeichernNeu (AutospeichernExtern => False);
               
            when GlobaleKonstanten.LadenKonstante =>
               if
                 Laden.LadenNeu = True
               then
                  return RassenSchleifeVerlassenKonstante;

               else
                  null;
               end if;
               
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
               
            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return AktuellerBefehlSpieler;

            when GlobaleKonstanten.RundeBeendenKonstante =>
               return GlobaleKonstanten.StartNormalKonstante;
                  
            when others =>
               null;
         end case;
                     
      end loop SpielerSchleife;
      
   end MenschAmZug;
   
   
   
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
