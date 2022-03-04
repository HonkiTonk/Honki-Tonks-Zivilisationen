pragma SPARK_Mode (On);

with Ada.Calendar; use Ada.Calendar;

with EinheitenKonstanten;

with Optionen;
with LadezeitenDatentypen;
with Speichern;
with Laden;
with RasseEntfernen;
with ZwischenDenRunden;
with AuswahlMenue;
with InteraktionLogiktask;
with Fehler;
with InteraktionGrafiktask;
with BefehleKonsole;
with BefehleSFML;

with KI;

package body ImSpiel is

   function ImSpiel
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      -- Muss hier einmal auf True gesetzt werden, damit die eventuell geänderten Kartenfeldergrößen neu/korrekt berechnet werden vom Grafiktask.
      InteraktionGrafiktask.FensterVerändert := InteraktionGrafiktask.Fenster_Verändert;
      
      SpielSchleife:
      loop
         RassenSchleife:
         for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
            
            RückgabeRassen := RasseImSpiel (RasseExtern => RasseSchleifenwert);
            
            case
              RückgabeRassen
            is
               when SystemKonstanten.SpielBeendenKonstante | SystemKonstanten.HauptmenüKonstante =>
                  return RückgabeRassen;
                  
               when SystemKonstanten.SchleifeVerlassenKonstante =>
                  exit RassenSchleife;
                  
               when SystemKonstanten.StartWeiterKonstante =>
                  null;
               
               when others =>
                  Fehler.LogikFehler (FehlermeldungExtern => "ImSpiel.ImSpiel - Falsche Rückgabe.");
            end case;
            
         end loop RassenSchleife;
               
         if
           GlobaleVariablen.RasseAmZugNachLaden = EinheitenKonstanten.LeerRasse
           and
             ZwischenDenRunden.BerechnungenNachZugendeAllerSpieler = True
         then
            return SystemKonstanten.HauptmenüKonstante;
            
         elsif
           GlobaleVariablen.Rundengrenze > GlobaleVariablen.RundenAnzahl
         then
            return SystemKonstanten.HauptmenüKonstante;
            
         else
            null;
         end if;
            
      end loop SpielSchleife;
            
   end ImSpiel;
   
   
   
   function RasseImSpiel
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemKonstanten.LeerSpielerKonstante
      then
         return SystemKonstanten.StartWeiterKonstante;
      
      elsif
        GlobaleVariablen.Grenzen (RasseExtern).RassenRundengrenze < GlobaleVariablen.RundenAnzahl
        and
          GlobaleVariablen.Grenzen (RasseExtern).RassenRundengrenze > 0
      then
         RasseEntfernen.RasseEntfernen (RasseExtern => RasseExtern);
         return SystemKonstanten.StartWeiterKonstante;
         
      else
         return RasseDurchgehen (RasseExtern => RasseExtern);
      end if;
      
   end RasseImSpiel;
   
   
   
   function RasseDurchgehen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
            
      if
        GlobaleVariablen.RasseAmZugNachLaden = EinheitenKonstanten.LeerRasse
        or
          RasseExtern = GlobaleVariablen.RasseAmZugNachLaden
      then
         GlobaleVariablen.RasseAmZugNachLaden := EinheitenKonstanten.LeerRasse;
            
         case
           GlobaleVariablen.RassenImSpiel (RasseExtern)
         is
            when SystemKonstanten.SpielerMenschKonstante =>
               return MenschlicherSpieler (RasseExtern => RasseExtern);
               
            when SystemKonstanten.SpielerKIKonstante =>
               KISpieler (RasseExtern => RasseExtern);
               
            when SystemKonstanten.LeerSpielerKonstante =>
               Fehler.LogikFehler (FehlermeldungExtern => "ImSpiel.RasseDurchgehen - Rasse ist Leer.");
         end case;

      else
         null;
      end if;
      
      return SystemKonstanten.StartWeiterKonstante;
      
   end RasseDurchgehen;
   
   
   
   procedure KISpieler
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      LadezeitenDatentypen.KIZeiten (RasseExtern, SystemDatentypen.Anfangswert) := Clock;
      KI.KI (RasseExtern => RasseExtern);
      LadezeitenDatentypen.KIZeiten (RasseExtern, SystemDatentypen.Endwert) := Clock;
      
   end KISpieler;
   
   
   
   function MenschlicherSpieler
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
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
          or
            RückgabeWert = SystemKonstanten.SchleifeVerlassenKonstante
      then
         return RückgabeWert;
                        
      else
         null;
      end if;
      
      return SystemKonstanten.StartWeiterKonstante;
      
   end MenschlicherSpieler;



   function MenschAmZug
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      InteraktionLogiktask.AktuelleRasseÄndern (RasseExtern => RasseExtern);
      
      SpielerSchleife:
      loop
         
         InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Weltkarte);
         
         case
           GlobaleVariablen.RassenImSpiel (RasseExtern)
         is
            when SystemKonstanten.SpielerMenschKonstante =>
               AktuellerBefehlSpieler := Befehle (RasseExtern => RasseExtern);
               
            when others =>
               -- Sollte niemals auftreten? Könnte auftreten wenn der Spieler eliminiert wird oder auf KI gesetzt wird? Mal ein besseres System bauen.
               Fehler.LogikFehler (FehlermeldungExtern => "ImSpiel.MenschAmZug - Nicht von Mensch belegt.");
         end case;
         
         case
           AktuellerBefehlSpieler
         is
            when SystemKonstanten.StartWeiterKonstante =>
               null;
               
            when SystemKonstanten.RundeBeendenKonstante =>
               RückgabeMenschAmZug := AktuellerBefehlSpieler;
               exit SpielerSchleife;
               
            when SystemKonstanten.SpielmenüKonstante =>
               RückgabeSpielmenü := Spielmenü (RasseExtern => RasseExtern);

               if
                 RückgabeSpielmenü = SystemKonstanten.LadenKonstante
               then
                  RückgabeMenschAmZug := SystemKonstanten.SchleifeVerlassenKonstante;
                  exit SpielerSchleife;
                  
               elsif
                 RückgabeSpielmenü in SystemDatentypen.Hauptmenü_Beenden_Enum'Range
               then
                  RückgabeMenschAmZug := RückgabeSpielmenü;
                  exit SpielerSchleife;
                  
               elsif
                 RückgabeSpielmenü = SystemKonstanten.StartWeiterKonstante
               then
                  null;
                  
               else
                  Fehler.LogikFehler (FehlermeldungExtern => "ImSpiel.MenschAmZug - Keine gültige Menürückgabe.");
               end if;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "ImSpiel.MenschAmZug - Kein gültiger Befehl.");
         end case;
                     
      end loop SpielerSchleife;
      
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Pause);
      InteraktionLogiktask.AktuelleRasseÄndern (RasseExtern => SystemKonstanten.LeerRasse);
      
      return RückgabeMenschAmZug;
      
   end MenschAmZug;



   function Spielmenü
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SpielmenüSchleife:
      loop
         
         AuswahlSpielmenü := AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Spiel_Menü);

         case
           AuswahlSpielmenü
         is
            when SystemKonstanten.SpeichernKonstante =>
               GlobaleVariablen.RasseAmZugNachLaden := RasseExtern;
               Speichern.SpeichernNeu (AutospeichernExtern => False);
               
            when SystemKonstanten.LadenKonstante =>
               if
                 Laden.LadenNeu = True
               then
                  return SystemKonstanten.LadenKonstante;

               else
                  null;
               end if;
               
            when SystemKonstanten.OptionenKonstante =>
               RückgabeOptionen := Optionen.Optionen;
               
               if
                 RückgabeOptionen in SystemDatentypen.Hauptmenü_Beenden_Enum'Range
               then
                  return RückgabeOptionen;
                  
               else
                  null;
               end if;
               
            when SystemDatentypen.Hauptmenü_Beenden_Enum'Range | SystemKonstanten.StartWeiterKonstante =>
               return AuswahlSpielmenü;
                  
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "ImSpiel.Spielmenü - Keine gültige Menürückgabe.");
         end case;
      
      end loop SpielmenüSchleife;
   
   end Spielmenü;
   
   
   
   function NochSpielerVorhanden
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseSchleifenwert = RasseExtern
           or
             GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) /= SystemKonstanten.SpielerMenschKonstante
         then
            null;
            
         else
            return True;
         end if;
         
      end loop RassenSchleife;
      
      return False;
      
   end NochSpielerVorhanden;
   
   
   
   function Befehle
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Grafik_Konsole =>
            return BefehleKonsole.BefehleKonsole (RasseExtern => RasseExtern);
            
         when SystemDatentypen.Grafik_SFML =>
            return BefehleSFML.BefehleSFML (RasseExtern => RasseExtern);
      end case;
      
   end Befehle;

end ImSpiel;
