pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with RueckgabeDatentypen; use RueckgabeDatentypen;
with SystemDatentypen;
with EinheitenKonstanten;
with GrafikDatentypen;
with OptionenVariablen;
with SpielVariablen;
with MenueDatentypen;

with Optionen;
with Ladezeiten;
with Speichern;
with Laden;
with RasseEntfernen;
with ZwischenDenRunden;
with AuswahlMenues;
with Fehler;
with InteraktionGrafiktask;
with BefehleTerminal;
with BefehleSFML;

with KI;

package body ImSpiel is

   function ImSpiel
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      -- Muss hier einmal auf True gesetzt werden, damit die eventuell geänderten Kartenfeldergrößen neu/korrekt berechnet werden vom Grafiktask.
      InteraktionGrafiktask.FensterVerändert := InteraktionGrafiktask.Fenster_Verändert_Enum;
      
      SpielSchleife:
      loop
         
         Ladezeiten.KINullsetzen;
         
         RassenSchleife:
         for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
            
            RückgabeRassen := RasseImSpiel (RasseExtern => RasseSchleifenwert);
            
            case
              RückgabeRassen
            is
               when RueckgabeDatentypen.Hauptmenü_Beenden_Enum'Range =>
                  return RückgabeRassen;
                  
               when RueckgabeDatentypen.Schleife_Verlassen_Enum =>
                  exit RassenSchleife;
                  
               when RueckgabeDatentypen.Start_Weiter_Enum =>
                  null;
               
               when others =>
                  Fehler.LogikFehler (FehlermeldungExtern => "ImSpiel.ImSpiel - Falsche Rückgabe.");
            end case;
            
         end loop RassenSchleife;
               
         if
           SonstigeVariablen.RasseAmZugNachLaden = EinheitenKonstanten.LeerRasse
           and
             ZwischenDenRunden.BerechnungenNachZugendeAllerSpieler = True
         then
            return RueckgabeDatentypen.Hauptmenü_Enum;
            
         elsif
           SpielVariablen.Rundengrenze > SpielVariablen.RundenAnzahl
         then
            return RueckgabeDatentypen.Hauptmenü_Enum;
            
         else
            null;
         end if;
            
      end loop SpielSchleife;
            
   end ImSpiel;
   
   
   
   function RasseImSpiel
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Leer_Spieler_Enum
      then
         return RueckgabeDatentypen.Start_Weiter_Enum;
      
      elsif
        SpielVariablen.Grenzen (RasseExtern).RassenRundengrenze < SpielVariablen.RundenAnzahl
        and
          SpielVariablen.Grenzen (RasseExtern).RassenRundengrenze > 0
      then
         RasseEntfernen.RasseEntfernen (RasseExtern => RasseExtern);
         return RueckgabeDatentypen.Start_Weiter_Enum;
         
      else
         return RasseDurchgehen (RasseExtern => RasseExtern);
      end if;
      
   end RasseImSpiel;
   
   
   
   function RasseDurchgehen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
            
      if
        SonstigeVariablen.RasseAmZugNachLaden = EinheitenKonstanten.LeerRasse
        or
          RasseExtern = SonstigeVariablen.RasseAmZugNachLaden
      then
         SonstigeVariablen.RasseAmZugNachLaden := EinheitenKonstanten.LeerRasse;
            
         case
           SonstigeVariablen.RassenImSpiel (RasseExtern)
         is
            when RassenDatentypen.Spieler_Mensch_Enum =>
               return MenschlicherSpieler (RasseExtern => RasseExtern);
               
            when RassenDatentypen.Spieler_KI_Enum =>
               KISpieler (RasseExtern => RasseExtern);
               
            when RassenDatentypen.Leer_Spieler_Enum =>
               Fehler.LogikFehler (FehlermeldungExtern => "ImSpiel.RasseDurchgehen - Rasse ist Leer.");
         end case;

      else
         null;
      end if;
      
      return RueckgabeDatentypen.Start_Weiter_Enum;
      
   end RasseDurchgehen;
   
   
   
   procedure KISpieler
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      InteraktionGrafiktask.KIRechnet := RasseExtern;
      InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_KI_Rechenzeit_Enum;
      Ladezeiten.KIZeiten (RasseExtern, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KI.KI (RasseExtern => RasseExtern);
      
      Ladezeiten.KIZeiten (RasseExtern, SystemDatentypen.Endwert_Enum) := Clock;
      InteraktionGrafiktask.KIRechnet := RassenDatentypen.Keine_Rasse_Enum;
      
   end KISpieler;
   
   
   
   function MenschlicherSpieler
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
                           
      RückgabeWert := MenschAmZug (RasseExtern => RasseExtern);
      
      if
        (RückgabeWert = RueckgabeDatentypen.Spiel_Beenden_Enum
         or
           RückgabeWert = RueckgabeDatentypen.Hauptmenü_Enum)
        and
          NochSpielerVorhanden (RasseExtern => RasseExtern) = True
      then
         RasseEntfernen.RasseAufKISetzen (RasseExtern => RasseExtern);
                        
      elsif
        RückgabeWert = RueckgabeDatentypen.Spiel_Beenden_Enum
        or
          RückgabeWert = RueckgabeDatentypen.Hauptmenü_Enum
          or
            RückgabeWert = RueckgabeDatentypen.Schleife_Verlassen_Enum
      then
         return RückgabeWert;
                        
      else
         null;
      end if;
      
      return RueckgabeDatentypen.Start_Weiter_Enum;
      
   end MenschlicherSpieler;



   function MenschAmZug
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      InteraktionGrafiktask.AktuelleRasseEinheit.Rasse := RasseExtern;
      
      SpielerSchleife:
      loop
         
         InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Weltkarte_Enum;
         
         case
           SonstigeVariablen.RassenImSpiel (RasseExtern)
         is
            when RassenDatentypen.Spieler_Mensch_Enum =>
               AktuellerBefehlSpieler := Befehle (RasseExtern => RasseExtern);
               
            when others =>
               -- Sollte niemals auftreten? Könnte auftreten wenn der Spieler eliminiert wird oder auf KI gesetzt wird? Mal ein besseres System bauen.
               Fehler.LogikFehler (FehlermeldungExtern => "ImSpiel.MenschAmZug - Nicht von Mensch belegt.");
         end case;
         
         case
           AktuellerBefehlSpieler
         is
            when RueckgabeDatentypen.Start_Weiter_Enum =>
               null;
               
            when RueckgabeDatentypen.Runde_Beenden_Enum =>
               RückgabeMenschAmZug := AktuellerBefehlSpieler;
               exit SpielerSchleife;
               
            when RueckgabeDatentypen.Spielmenü_Enum =>
               RückgabeSpielmenü := Spielmenü (RasseExtern => RasseExtern);

               if
                 RückgabeSpielmenü = RueckgabeDatentypen.Laden_Enum
               then
                  RückgabeMenschAmZug := RueckgabeDatentypen.Schleife_Verlassen_Enum;
                  exit SpielerSchleife;
                  
               elsif
                 RückgabeSpielmenü in RueckgabeDatentypen.Hauptmenü_Beenden_Enum'Range
               then
                  RückgabeMenschAmZug := RückgabeSpielmenü;
                  exit SpielerSchleife;
                  
               elsif
                 RückgabeSpielmenü = RueckgabeDatentypen.Start_Weiter_Enum
               then
                  null;
                  
               else
                  Fehler.LogikFehler (FehlermeldungExtern => "ImSpiel.MenschAmZug - Keine gültige Menürückgabe.");
               end if;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "ImSpiel.MenschAmZug - Kein gültiger Befehl.");
         end case;
                     
      end loop SpielerSchleife;
      
      InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      InteraktionGrafiktask.AktuelleRasseEinheit.Rasse := RassenDatentypen.Keine_Rasse_Enum;
      
      return RückgabeMenschAmZug;
      
   end MenschAmZug;



   function Spielmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SpielmenüSchleife:
      loop
         
         AuswahlSpielmenü := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Spiel_Menü_Enum);

         case
           AuswahlSpielmenü
         is
            when RueckgabeDatentypen.Speichern_Enum =>
               SonstigeVariablen.RasseAmZugNachLaden := RasseExtern;
               Speichern.SpeichernNeu (AutospeichernExtern => False);
               
            when RueckgabeDatentypen.Laden_Enum =>
               if
                 Laden.LadenNeu = True
               then
                  return RueckgabeDatentypen.Laden_Enum;

               else
                  null;
               end if;
               
            when RueckgabeDatentypen.Optionen_Enum =>
               RückgabeOptionen := Optionen.Optionen;
               
               if
                 RückgabeOptionen in RueckgabeDatentypen.Hauptmenü_Beenden_Enum'Range
               then
                  return RückgabeOptionen;
                  
               else
                  null;
               end if;
               
            when RueckgabeDatentypen.Hauptmenü_Beenden_Enum'Range | RueckgabeDatentypen.Start_Weiter_Enum =>
               return AuswahlSpielmenü;
                  
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "ImSpiel.Spielmenü - Keine gültige Menürückgabe.");
         end case;
      
      end loop SpielmenüSchleife;
   
   end Spielmenü;
   
   
   
   function NochSpielerVorhanden
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseSchleifenwert = RasseExtern
           or
             SonstigeVariablen.RassenImSpiel (RasseSchleifenwert) /= RassenDatentypen.Spieler_Mensch_Enum
         then
            null;
            
         else
            return True;
         end if;
         
      end loop RassenSchleife;
      
      return False;
      
   end NochSpielerVorhanden;
   
   
   
   function Befehle
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            return BefehleTerminal.Befehle (RasseExtern => RasseExtern);
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            return BefehleSFML.Befehle (RasseExtern => RasseExtern);
      end case;
      
   end Befehle;

end ImSpiel;
