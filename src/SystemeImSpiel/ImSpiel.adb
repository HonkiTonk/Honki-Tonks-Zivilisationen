pragma SPARK_Mode (On);

with Ada.Calendar; use Ada.Calendar;

with SystemDatentypen; use SystemDatentypen;

with Karte;
with BefehleImSpiel;
with Optionen;
with Ladezeiten;
with Speichern;
with Laden;
with RasseEntfernen;
with ZwischenDenRunden;

with KI;

package body ImSpiel is

   function ImSpiel
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      Karte.SichtweiteBewegungsfeldFestlegen;
      
      SpielSchleife:
      loop
         RassenSchleife:
         for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
            
            RückgabeRassen := RasseImSpiel (RasseExtern => RasseSchleifenwert);
            
            case
              RückgabeRassen
            is
               when SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante =>
                  null;
                 -- return RückgabeRassen;
                  
               when RassenSchleifeVerlassenKonstante =>
                  exit RassenSchleife;
               
               when others =>
                  null;
            end case;
            
         end loop RassenSchleife;
               
         if
           GlobaleVariablen.RasseAmZugNachLaden = SystemDatentypen.Keine_Rasse
           and
             ZwischenDenRunden.BerechnungenNachZugendeAllerSpieler = True
         then
            return SystemDatentypen.Hauptmenü;
            
         else
            null;
         end if;
         
         if
           GlobaleVariablen.Rundengrenze > GlobaleVariablen.RundenAnzahl
         then
            return SystemDatentypen.Hauptmenü;
            
         else
            null;
         end if;
            
      end loop SpielSchleife;
            
   end ImSpiel;
   
   
   
   function RasseImSpiel
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
      
      if
        GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Leer
      then
         return SystemKonstanten.StartNormalKonstante;
      
      elsif
        GlobaleVariablen.Grenzen (RasseExtern).RassenRundengrenze < GlobaleVariablen.RundenAnzahl
        and
          GlobaleVariablen.Grenzen (RasseExtern).RassenRundengrenze > 0
      then
         RasseEntfernen.RasseEntfernen (RasseExtern => RasseExtern);
         return SystemKonstanten.StartNormalKonstante;
         
      else
         return RasseDurchgehen (RasseExtern => RasseExtern);
      end if;
      
   end RasseImSpiel;
   
   
   
   function RasseDurchgehen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
            
      if
        GlobaleVariablen.RasseAmZugNachLaden = SystemDatentypen.Keine_Rasse
        or
          RasseExtern = GlobaleVariablen.RasseAmZugNachLaden
      then
         GlobaleVariablen.RasseAmZugNachLaden := SystemDatentypen.Keine_Rasse;
            
         case
           GlobaleVariablen.RassenImSpiel (RasseExtern)
         is
            when SonstigeDatentypen.Spieler_Mensch =>
               return MenschlicherSpieler (RasseExtern => RasseExtern);
               
            when SonstigeDatentypen.Spieler_KI =>
               KISpieler (RasseExtern => RasseExtern);
               
            when SonstigeDatentypen.Leer =>
               -- Dieser Fall sollte hier niemals eintreten.
               raise Program_Error;
         end case;

      else
         null;
      end if;
      
      return SystemKonstanten.StartNormalKonstante;
      
   end RasseDurchgehen;
   
   
   
   procedure KISpieler
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      Ladezeiten.KIZeiten (RasseExtern, SystemDatentypen.Anfangswert) := Clock;
      KI.KI (RasseExtern => RasseExtern);
      Ladezeiten.KIZeiten (RasseExtern, SystemDatentypen.Endwert) := Clock;
      
   end KISpieler;
   
   
   
   function MenschlicherSpieler
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
                           
      RückgabeWert := MenschAmZug (RasseExtern => RasseExtern);
      
      if
        (RückgabeWert = SystemKonstanten.SpielBeendenKonstante
         or
           RückgabeWert = SystemKonstanten.HauptmenüKonstante)
        and
          NochSpielerVorhanden (RasseExtern => RasseExtern) = True
      then
         RasseEntfernen.RasseAufKISetzen (RasseExtern => RasseExtern);
                        
      elsif
        RückgabeWert = SystemKonstanten.SpielBeendenKonstante
        or
          RückgabeWert = SystemKonstanten.HauptmenüKonstante
      then
         return RückgabeWert;

      elsif
        RückgabeWert = RassenSchleifeVerlassenKonstante
      then
         return RassenSchleifeVerlassenKonstante;
                        
      else
         null;
      end if;
      
      return SystemKonstanten.StartNormalKonstante;
      
   end MenschlicherSpieler;



   -- Hier einen zweiten Task aufmachen der das Fenster verwaltet?
   function MenschAmZug
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
      
      SpielerSchleife:
      loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseExtern)
         is
            when SonstigeDatentypen.Spieler_Mensch =>
               Karte.AnzeigeKarte (RasseExtern => RasseExtern);
               AktuellerBefehlSpieler := BefehleImSpiel.Befehle (RasseExtern => RasseExtern);
               
            when others =>
               -- Sollte niemals auftreten? Könnte auftreten wenn der Spieler eliminiert wird oder auf KI gesetzt wird? Mal ein besseres System bauen.
               raise Program_Error;
         end case;
         
         case
           AktuellerBefehlSpieler
         is
            when SystemKonstanten.StartNormalKonstante =>
               null;

            when SystemKonstanten.SpeichernKonstante =>
               GlobaleVariablen.RasseAmZugNachLaden := RasseExtern;
               Speichern.SpeichernNeu (AutospeichernExtern => False);
               
            when SystemKonstanten.LadenKonstante =>
               if
                 Laden.LadenNeu = True
               then
                  return RassenSchleifeVerlassenKonstante;

               else
                  null;
               end if;
               
            when SystemKonstanten.OptionenKonstante =>
               RückgabeOptionen := Optionen.Optionen;
               if
                 RückgabeOptionen = SystemKonstanten.SpielBeendenKonstante
                 or
                   RückgabeOptionen = SystemKonstanten.HauptmenüKonstante
               then
                  return RückgabeOptionen;
                                    
               else
                  null;
               end if;
               
            when SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante =>
               return AktuellerBefehlSpieler;

            when SystemKonstanten.RundeBeendenKonstante =>
               return SystemKonstanten.StartNormalKonstante;
                  
            when others =>
               null;
         end case;
                     
      end loop SpielerSchleife;
      
   end MenschAmZug;
   
   
   
   function NochSpielerVorhanden
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseSchleifenwert = RasseExtern
           or
             GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) /= SonstigeDatentypen.Spieler_Mensch
         then
            null;
            
         else
            return True;
         end if;
         
      end loop RassenSchleife;
      
      return False;
      
   end NochSpielerVorhanden;

end ImSpiel;
