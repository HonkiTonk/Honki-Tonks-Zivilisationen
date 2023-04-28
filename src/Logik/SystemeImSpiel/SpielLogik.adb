with GrafikDatentypen;
with MenueDatentypen;
with TextnummernKonstanten;
with ForschungKonstanten;
with ForschungenDatentypen;
with SpeziesKonstanten;

with LeseGrenzen;
with LeseAllgemeines;
with SchreibeAllgemeines;
with LeseWichtiges;

with OptionenLogik;
with LadezeitenLogik;
with SpeichernLogik;
with LadenLogik;
with SpeziesEntfernenLogik;
with RundenendeLogik;
with Fehlermeldungssystem;
with NachGrafiktask;
with BefehlsauswahlLogik;
with JaNeinLogik;
with Spielertests;
with AuswahlaufteilungLogik;
with ForschungsauswahlLogik;

with KILogik;

package body SpielLogik is

   function Spiel
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
            
      SpielSchleife:
      loop
                  
         SpeziesSchleife:
         for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
            
            RückgabeSpezies := SpeziesImSpiel (SpeziesExtern => SpeziesSchleifenwert);
            
            case
              RückgabeSpezies
            is
               when RueckgabeDatentypen.Hauptmenü_Beenden_Enum'Range =>
                  return RückgabeSpezies;
                  
               when RueckgabeDatentypen.Schleife_Verlassen_Enum =>
                  exit SpeziesSchleife;
                  
               when RueckgabeDatentypen.Start_Weiter_Enum =>
                  null;
               
               when others =>
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpielLogik.Spiel: Falsche Rückgabe: " & RückgabeSpezies'Wide_Wide_Image);
            end case;
            
         end loop SpeziesSchleife;
         
         if
           LeseAllgemeines.SpeziesAmzugNachLaden = SpeziesKonstanten.LeerSpezies
         then
            case
              Spielertests.MenschlicheSpieler (SpeziesExtern => SpeziesKonstanten.LeerSpezies)
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
   
   
   
   function SpeziesImSpiel
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Leer_Spieler_Enum
        or
          LeseSpeziesbelegung.Besiegt (SpeziesExtern => SpeziesExtern) = True
      then
         return RueckgabeDatentypen.Start_Weiter_Enum;
      
      elsif
        LeseGrenzen.Speziesrundengrenze (SpeziesExtern => SpeziesExtern) < LeseAllgemeines.Rundenanzahl
        and
          LeseGrenzen.Speziesrundengrenze (SpeziesExtern => SpeziesExtern) > 0
      then
         SpeziesEntfernenLogik.SpeziesEntfernen (SpeziesExtern => SpeziesExtern);
         return RueckgabeDatentypen.Start_Weiter_Enum;
         
      else
         return SpeziesDurchgehen (SpeziesExtern => SpeziesExtern);
      end if;
      
   end SpeziesImSpiel;
   
   
   
   function SpeziesDurchgehen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
            
      if
        LeseAllgemeines.SpeziesAmzugNachLaden = SpeziesKonstanten.LeerSpezies
        or
          LeseAllgemeines.SpeziesAmzugNachLaden = SpeziesExtern
      then
         SchreibeAllgemeines.SpeziesAmzugNachLaden (SpeziesExtern => SpeziesKonstanten.LeerSpezies);
            
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern)
         is
            when SpeziesDatentypen.Mensch_Spieler_Enum =>
               return MenschlicherSpieler (SpeziesExtern => SpeziesExtern);
               
            when SpeziesDatentypen.KI_Spieler_Enum =>
               KISpieler (SpeziesExtern => SpeziesExtern);
               
            when SpeziesDatentypen.Leer_Spieler_Enum =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpielLogik.SpeziesDurchgehen: Keine Spezies");
               return RueckgabeDatentypen.Runde_Beenden_Enum;
         end case;

      else
         null;
      end if;
      
      return RueckgabeDatentypen.Start_Weiter_Enum;
      
   end SpeziesDurchgehen;
   
   
   
   procedure KISpieler
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      LadezeitenLogik.KINullsetzenFortschritt;
      
      NachGrafiktask.KIRechnet := SpeziesExtern;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_KI_Rechenzeit_Enum;
      
      KILogik.KI (SpeziesExtern => SpeziesExtern);
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      NachGrafiktask.KIRechnet := SpeziesKonstanten.LeerSpezies;
      
   end KISpieler;
   
   
   
   function MenschlicherSpieler
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
                           
      RückgabeWert := MenschAmZug (SpeziesExtern => SpeziesExtern);
      
      case
        RückgabeWert
      is
         when RueckgabeDatentypen.Spiel_Beenden_Enum | RueckgabeDatentypen.Hauptmenü_Enum =>
            if
              Spielertests.MenschlicheSpieler (SpeziesExtern => SpeziesExtern) = True
            then
               -- Es ist recht nervig wenn man zurück zum Hauptmenü will und für jeden menschlichen Spieler gefragt wird ob er auf die KI gesetzt werden soll. äöü
               -- Deswegen wird bei Nein jetzt erst einmal direkt zurückgegangen, eventuell später wieder ändern oder besser gestalten. äöü
               case
                 JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageKIEinsetzen)
               is
                  when True =>
                     SpeziesEntfernenLogik.SpeziesAufKISetzen (SpeziesExtern => SpeziesExtern);
                     
                  when False =>
                     return RückgabeWert;
                     -- SpeziesEntfernenLogik.SpeziesEntfernen (SpeziesExtern => SpeziesExtern);
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is
      use type RueckgabeDatentypen.Rückgabe_Werte_Enum;
      use type ForschungenDatentypen.ForschungIDNichtMöglich;
   begin
      
      NachGrafiktask.AktuelleSpezies := SpeziesExtern;
      
      if
        LeseAllgemeines.Rundenanzahl = 2
        and
          LeseWichtiges.Forschungsprojekt (SpeziesExtern => SpeziesExtern) = ForschungKonstanten.LeerForschung
      then
         ForschungsauswahlLogik.Forschung (SpeziesExtern => SpeziesExtern);
         
      else
         null;
      end if;
      
      SpielerSchleife:
      loop
         
         NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Weltkarte_Enum;
         
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern)
         is
            when SpeziesDatentypen.Mensch_Spieler_Enum =>
               AktuellerBefehlSpieler := BefehlsauswahlLogik.Befehlsauswahl (SpeziesExtern => SpeziesExtern);
               
            when others =>
               RückgabeMenschAmZug := RueckgabeDatentypen.Hauptmenü_Enum;
               exit SpielerSchleife;
         end case;
         
         case
           LeseSpeziesbelegung.Besiegt (SpeziesExtern => SpeziesExtern)
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
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
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
               RückgabeSpielmenü := Spielmenü (SpeziesExtern => SpeziesExtern);

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
      NachGrafiktask.AktuelleSpezies := SpeziesKonstanten.LeerSpezies;
      
      return RückgabeMenschAmZug;
      
   end MenschAmZug;



   -- Das hier mal nach Menues verschieben. äöü
   function Spielmenü
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SpielmenüSchleife:
      loop
         
         AuswahlSpielmenü := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Spiel_Menü_Enum);

         case
           AuswahlSpielmenü
         is
            when RueckgabeDatentypen.Speichern_Enum =>
               SchreibeAllgemeines.SpeziesAmzugNachLaden (SpeziesExtern => SpeziesExtern);
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
