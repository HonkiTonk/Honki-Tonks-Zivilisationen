with EinheitenKonstanten;
with GrafikDatentypen;
with MenueDatentypen;
with TextnummernKonstanten;

with LeseGrenzen;
with LeseAllgemeines;
with SchreibeAllgemeines;

with OptionenLogik;
with LadezeitenLogik;
with SpeichernLogik;
with LadenLogik;
with RasseEntfernenLogik;
with RundenendeLogik;
with Fehlermeldungssystem;
with NachGrafiktask;
with BefehlsauswahlLogik;
with JaNeinLogik;
with Spielertests;
with AuswahlaufteilungLogik;

with KILogik;

package body SpielLogik is

   function Spiel
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
            
      SpielSchleife:
      loop
                  
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
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpielLogik.Spiel - Falsche Rückgabe:" & RückgabeRassen'Wide_Wide_Image);
            end case;
            
         end loop RassenSchleife;
         
         if
          LeseAllgemeines.RasseAmzugNachLaden = EinheitenKonstanten.LeerRasse
         then
            case
              Spielertests.MenschlicheSpieler (RasseExtern => RassenDatentypen.Keine_Rasse_Enum)
            is
               when True =>
                  null;
               
               when False =>
                  exit SpielSchleife;
            end case;
            
            case
              RundenendeLogik.BerechnungenRundenende
            is
               when False =>
                  exit SpielSchleife;
               
               when True =>
                  null;
            end case;
            
         elsif
           LeseAllgemeines.Rundengrenze > 0
           and
             LeseAllgemeines.Rundengrenze < LeseAllgemeines.Rundenanzahl
         then
            exit SpielSchleife;
            
         else
            null;
         end if;
            
      end loop SpielSchleife;
      
      return RueckgabeDatentypen.Hauptmenü_Enum;
            
   end Spiel;
   
   
   
   function RasseImSpiel
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Leer_Spieler_Enum
        or
         LeseRassenbelegung.Besiegt (RasseExtern => RasseExtern) = True
      then
         return RueckgabeDatentypen.Start_Weiter_Enum;
      
      elsif
        LeseGrenzen.Rassenrundengrenze (RasseExtern => RasseExtern) < LeseAllgemeines.Rundenanzahl
        and
          LeseGrenzen.Rassenrundengrenze (RasseExtern => RasseExtern) > 0
      then
         RasseEntfernenLogik.RasseEntfernen (RasseExtern => RasseExtern);
         return RueckgabeDatentypen.Start_Weiter_Enum;
         
      else
         return RasseDurchgehen (RasseExtern => RasseExtern);
      end if;
      
   end RasseImSpiel;
   
   
   
   function RasseDurchgehen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
            
      if
        LeseAllgemeines.RasseAmzugNachLaden = EinheitenKonstanten.LeerRasse
        or
          LeseAllgemeines.RasseAmzugNachLaden = RasseExtern
      then
         SchreibeAllgemeines.RasseAmzugNachLaden (RasseExtern => EinheitenKonstanten.LeerRasse);
            
         case
           LeseRassenbelegung.Belegung (RasseExtern => RasseExtern)
         is
            when RassenDatentypen.Mensch_Spieler_Enum =>
               return MenschlicherSpieler (RasseExtern => RasseExtern);
               
            when RassenDatentypen.KI_Spieler_Enum =>
               KISpieler (RasseExtern => RasseExtern);
               
            when RassenDatentypen.Leer_Spieler_Enum =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpielLogik.RasseDurchgehen: Keine Rasse.");
         end case;

      else
         null;
      end if;
      
      return RueckgabeDatentypen.Start_Weiter_Enum;
      
   end RasseDurchgehen;
   
   
   
   procedure KISpieler
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      LadezeitenLogik.KINullsetzenFortschritt;
      
      NachGrafiktask.KIRechnet := RasseExtern;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_KI_Rechenzeit_Enum;
      
      KILogik.KI (RasseExtern => RasseExtern);
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      NachGrafiktask.KIRechnet := RassenDatentypen.Keine_Rasse_Enum;
      
   end KISpieler;
   
   
   
   function MenschlicherSpieler
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
                           
      RückgabeWert := MenschAmZug (RasseExtern => RasseExtern);
      
      case
        RückgabeWert
      is
         when RueckgabeDatentypen.Spiel_Beenden_Enum | RueckgabeDatentypen.Hauptmenü_Enum =>
            if
              Spielertests.MenschlicheSpieler (RasseExtern => RasseExtern) = True
            then
               -- Es ist recht nervig wenn man zurück zum Hauptmenü will und für jeden menschlichen Spieler gefragt wird ob er auf die KI gesetzt werden soll. äöü
               -- Deswegen wird bei Nein jetzt erst einmal direkt zurückgegangen, eventuell später wieder ändern oder besser gestalten. äöü
               case
                 JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageKIEinsetzen)
               is
                  when True =>
                     RasseEntfernenLogik.RasseAufKISetzen (RasseExtern => RasseExtern);
                     
                  when False =>
                     return RückgabeWert;
                     -- RasseEntfernenLogik.RasseEntfernen (RasseExtern => RasseExtern);
               end case;
               
            else
               return RückgabeWert;
            end if;
            
         when RueckgabeDatentypen.Schleife_Verlassen_Enum =>
            return RückgabeWert;
            
         when others =>
            null;
      end case;
      
      return RueckgabeDatentypen.Start_Weiter_Enum;
      
   end MenschlicherSpieler;



   function MenschAmZug
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is
      use type RueckgabeDatentypen.Rückgabe_Werte_Enum;
   begin
      
      NachGrafiktask.AktuelleRasse := RasseExtern;
      
      SpielerSchleife:
      loop
         
         NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Weltkarte_Enum;
         
         case
           LeseRassenbelegung.Belegung (RasseExtern => RasseExtern)
         is
            when RassenDatentypen.Mensch_Spieler_Enum =>
               AktuellerBefehlSpieler := BefehlsauswahlLogik.Befehlsauswahl (RasseExtern => RasseExtern);
               
            when others =>
               RückgabeMenschAmZug := RueckgabeDatentypen.Hauptmenü_Enum;
               exit SpielerSchleife;
         end case;
         
         case
           LeseRassenbelegung.Besiegt (RasseExtern => RasseExtern)
         is
            when True =>
               exit SpielerSchleife;
               
            when False =>
               null;
         end case;
         
         case
           AktuellerBefehlSpieler
         is
            when RueckgabeDatentypen.Start_Weiter_Enum =>
               if
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
               then
                  null;
                  
               else
                  RückgabeMenschAmZug := RueckgabeDatentypen.Start_Weiter_Enum;
                  exit SpielerSchleife;
               end if;
               
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
                 or
                   RückgabeSpielmenü = RueckgabeDatentypen.Zurück_Enum
               then
                  null;
                  
               else
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpielLogik.MenschAmZug: Falsche Rückgabe: " & RückgabeSpielmenü'Wide_Wide_Image);
               end if;
               
            when others =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpielLogik.MenschAmZug: Falscher Befehl: " & AktuellerBefehlSpieler'Wide_Wide_Image);
         end case;
                     
      end loop SpielerSchleife;
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      NachGrafiktask.AktuelleRasse := RassenDatentypen.Keine_Rasse_Enum;
      
      return RückgabeMenschAmZug;
      
   end MenschAmZug;



   function Spielmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SpielmenüSchleife:
      loop
         
         AuswahlSpielmenü := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Spiel_Menü_Enum);

         case
           AuswahlSpielmenü
         is
            when RueckgabeDatentypen.Speichern_Enum =>
               SchreibeAllgemeines.RasseAmzugNachLaden (RasseExtern => RasseExtern);
               SpeichernLogik.Speichern (AutospeichernExtern => False);
               
            when RueckgabeDatentypen.Laden_Enum =>
               if
                 LadenLogik.Laden = True
               then
                  return RueckgabeDatentypen.Laden_Enum;

               else
                  null;
               end if;
               
            when RueckgabeDatentypen.Optionen_Enum =>
               RückgabeOptionen := OptionenLogik.Optionen;
               
               if
                 RückgabeOptionen in RueckgabeDatentypen.Hauptmenü_Beenden_Enum'Range
               then
                  return RückgabeOptionen;
                  
               else
                  null;
               end if;
               
            when RueckgabeDatentypen.Hauptmenü_Beenden_Enum'Range | RueckgabeDatentypen.Start_Weiter_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return AuswahlSpielmenü;
                  
            when others =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpielLogik.Spielmenü: Falsche Rückgabe: " & AuswahlSpielmenü'Wide_Wide_Image);
         end case;
      
      end loop SpielmenüSchleife;
   
   end Spielmenü;

end SpielLogik;
