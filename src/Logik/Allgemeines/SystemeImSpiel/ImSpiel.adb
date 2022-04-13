pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with EinheitenKonstanten;
with GrafikTonDatentypen;

with Optionen;
with LadezeitenDatentypen;
with Speichern;
with Laden;
with RasseEntfernen;
with ZwischenDenRunden;
with AuswahlMenues;
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
      InteraktionGrafiktask.FensterVerändert := InteraktionGrafiktask.Fenster_Verändert_Enum;
      
      SpielSchleife:
      loop
         RassenSchleife:
         for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
            
            RückgabeRassen := RasseImSpiel (RasseExtern => RasseSchleifenwert);
            
            case
              RückgabeRassen
            is
               when SystemDatentypen.Hauptmenü_Beenden_Enum'Range =>
                  return RückgabeRassen;
                  
               when SystemDatentypen.Schleife_Verlassen_Enum =>
                  exit RassenSchleife;
                  
               when SystemDatentypen.Start_Weiter_Enum =>
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
            return SystemDatentypen.Hauptmenü_Enum;
            
         elsif
           GlobaleVariablen.Rundengrenze > GlobaleVariablen.RundenAnzahl
         then
            return SystemDatentypen.Hauptmenü_Enum;
            
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
        GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Leer_Spieler_Enum
      then
         return SystemDatentypen.Start_Weiter_Enum;
      
      elsif
        GlobaleVariablen.Grenzen (RasseExtern).RassenRundengrenze < GlobaleVariablen.RundenAnzahl
        and
          GlobaleVariablen.Grenzen (RasseExtern).RassenRundengrenze > 0
      then
         RasseEntfernen.RasseEntfernen (RasseExtern => RasseExtern);
         return SystemDatentypen.Start_Weiter_Enum;
         
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
            when SystemDatentypen.Spieler_Mensch_Enum =>
               return MenschlicherSpieler (RasseExtern => RasseExtern);
               
            when SystemDatentypen.Spieler_KI_Enum =>
               KISpieler (RasseExtern => RasseExtern);
               
            when SystemDatentypen.Leer_Spieler_Enum =>
               Fehler.LogikFehler (FehlermeldungExtern => "ImSpiel.RasseDurchgehen - Rasse ist Leer.");
         end case;

      else
         null;
      end if;
      
      return SystemDatentypen.Start_Weiter_Enum;
      
   end RasseDurchgehen;
   
   
   
   procedure KISpieler
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      LadezeitenDatentypen.KIZeiten (RasseExtern, SystemDatentypen.Anfangswert_Enum) := Clock;
      KI.KI (RasseExtern => RasseExtern);
      LadezeitenDatentypen.KIZeiten (RasseExtern, SystemDatentypen.Endwert_Enum) := Clock;
      
   end KISpieler;
   
   
   
   function MenschlicherSpieler
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
                           
      RückgabeWert := MenschAmZug (RasseExtern => RasseExtern);
      
      if
        (RückgabeWert = SystemDatentypen.Spiel_Beenden_Enum
         or
           RückgabeWert = SystemDatentypen.Hauptmenü_Enum)
        and
          NochSpielerVorhanden (RasseExtern => RasseExtern) = True
      then
         RasseEntfernen.RasseAufKISetzen (RasseExtern => RasseExtern);
                        
      elsif
        RückgabeWert = SystemDatentypen.Spiel_Beenden_Enum
        or
          RückgabeWert = SystemDatentypen.Hauptmenü_Enum
          or
            RückgabeWert = SystemDatentypen.Schleife_Verlassen_Enum
      then
         return RückgabeWert;
                        
      else
         null;
      end if;
      
      return SystemDatentypen.Start_Weiter_Enum;
      
   end MenschlicherSpieler;



   function MenschAmZug
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      InteraktionLogiktask.AktuelleRasseÄndern (RasseExtern => RasseExtern);
      
      SpielerSchleife:
      loop
         
         InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikTonDatentypen.Grafik_Weltkarte_Enum);
         
         case
           GlobaleVariablen.RassenImSpiel (RasseExtern)
         is
            when SystemDatentypen.Spieler_Mensch_Enum =>
               AktuellerBefehlSpieler := Befehle (RasseExtern => RasseExtern);
               
            when others =>
               -- Sollte niemals auftreten? Könnte auftreten wenn der Spieler eliminiert wird oder auf KI gesetzt wird? Mal ein besseres System bauen.
               Fehler.LogikFehler (FehlermeldungExtern => "ImSpiel.MenschAmZug - Nicht von Mensch belegt.");
         end case;
         
         case
           AktuellerBefehlSpieler
         is
            when SystemDatentypen.Start_Weiter_Enum =>
               null;
               
            when SystemDatentypen.Runde_Beenden_Enum =>
               RückgabeMenschAmZug := AktuellerBefehlSpieler;
               exit SpielerSchleife;
               
            when SystemDatentypen.Spielmenü_Enum =>
               RückgabeSpielmenü := Spielmenü (RasseExtern => RasseExtern);

               if
                 RückgabeSpielmenü = SystemDatentypen.Laden_Enum
               then
                  RückgabeMenschAmZug := SystemDatentypen.Schleife_Verlassen_Enum;
                  exit SpielerSchleife;
                  
               elsif
                 RückgabeSpielmenü in SystemDatentypen.Hauptmenü_Beenden_Enum'Range
               then
                  RückgabeMenschAmZug := RückgabeSpielmenü;
                  exit SpielerSchleife;
                  
               elsif
                 RückgabeSpielmenü = SystemDatentypen.Start_Weiter_Enum
               then
                  null;
                  
               else
                  Fehler.LogikFehler (FehlermeldungExtern => "ImSpiel.MenschAmZug - Keine gültige Menürückgabe.");
               end if;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "ImSpiel.MenschAmZug - Kein gültiger Befehl.");
         end case;
                     
      end loop SpielerSchleife;
      
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikTonDatentypen.Grafik_Pause_Enum);
      InteraktionLogiktask.AktuelleRasseÄndern (RasseExtern => SystemDatentypen.Keine_Rasse_Enum);
      
      return RückgabeMenschAmZug;
      
   end MenschAmZug;



   function Spielmenü
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SpielmenüSchleife:
      loop
         
         AuswahlSpielmenü := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => SystemDatentypen.Spiel_Menü_Enum);

         case
           AuswahlSpielmenü
         is
            when SystemDatentypen.Speichern_Enum =>
               GlobaleVariablen.RasseAmZugNachLaden := RasseExtern;
               Speichern.SpeichernNeu (AutospeichernExtern => False);
               
            when SystemDatentypen.Laden_Enum =>
               if
                 Laden.LadenNeu = True
               then
                  return SystemDatentypen.Laden_Enum;

               else
                  null;
               end if;
               
            when SystemDatentypen.Optionen_Enum =>
               RückgabeOptionen := Optionen.Optionen;
               
               if
                 RückgabeOptionen in SystemDatentypen.Hauptmenü_Beenden_Enum'Range
               then
                  return RückgabeOptionen;
                  
               else
                  null;
               end if;
               
            when SystemDatentypen.Hauptmenü_Beenden_Enum'Range | SystemDatentypen.Start_Weiter_Enum =>
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
             GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) /= SystemDatentypen.Spieler_Mensch_Enum
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
         when GrafikTonDatentypen.Grafik_Konsole_Enum =>
            return BefehleKonsole.Befehle (RasseExtern => RasseExtern);
            
         when GrafikTonDatentypen.Grafik_SFML_Enum =>
            return BefehleSFML.Befehle (RasseExtern => RasseExtern);
      end case;
      
   end Befehle;

end ImSpiel;
