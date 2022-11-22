with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with MenueDatentypen;
with KartenKonstanten;
with SpielVariablen;

with SchreibeWeltkarte;
with LeseWeltkarteneinstellungen;
with SchreibeRassenbelegung;
with SchreibeCursor;

with AuswahlaufteilungLogik;
with Fehlermeldungssystem;
with DebugobjekteLogik;

package body DebugmenueLogik is

   procedure Debugmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      DebugmenüSchleife:
      loop
         
         RückgabeDebugmenü := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Debug_Menü_Enum);

         case
           RückgabeDebugmenü
         is
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               KarteAufdecken (RasseExtern => RasseExtern);
               
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               SpielVariablen.Wichtiges (RasseExtern).Erforscht := (others => True);
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               Get_Immediate (Item => Taste);
               MenschKITauschen (TasteExtern => Taste);
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               DebugobjekteLogik.Debug.VolleInformation := not DebugobjekteLogik.Debug.VolleInformation;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
                  
            when others =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "DebugmenueLogik.Debugmenü: Falsche Rückgabe: " & RückgabeDebugmenü'Wide_Wide_Image);
         end case;
      
      end loop DebugmenüSchleife;
      
   end Debugmenü;
   
   
   
   procedure MenschKITauschen
     (TasteExtern : in Wide_Wide_Character)
   is begin
                     
      case
        TasteExtern
      is
         when 'a' .. 'r' =>
            null;
                  
         when others =>
            return;
      end case;
      
      case
        LeseRassenbelegung.Belegung (RasseExtern => Wechsel (TasteExtern))
      is
         when RassenDatentypen.Leer_Spieler_Enum =>
            null;
            
         when RassenDatentypen.KI_Spieler_Enum =>
            SchreibeRassenbelegung.Belegung (RasseExtern    => Wechsel (TasteExtern),
                                             BelegungExtern => RassenDatentypen.Mensch_Spieler_Enum);
            
            SchreibeCursor.KoordinatenAktuell (RasseExtern       => Wechsel (TasteExtern),
                                               KoordinatenExtern => (0, 1, 1));
            SchreibeCursor.KoordinatenAlt (RasseExtern       => Wechsel (TasteExtern),
                                           KoordinatenExtern => (0, 1, 1));
                                             
         when RassenDatentypen.Mensch_Spieler_Enum =>
            SchreibeRassenbelegung.Belegung (RasseExtern    => Wechsel (TasteExtern),
                                             BelegungExtern => RassenDatentypen.KI_Spieler_Enum);
      end case;
                                             
   end MenschKITauschen;
   
   
   
   -- Könnte ich nicht theoretisch hier einfach alle Felder auf True setzen? Die restlichen sollten ja eh nie geprüft werden. äöü
   procedure KarteAufdecken
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EbeneSchleife:
      for EAchseSchleifenwert in KartenKonstanten.AnfangEAchse .. KartenKonstanten.EndeEAchse loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse loop
            
               SchreibeWeltkarte.Sichtbar (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                           RasseExtern       => RasseExtern,
                                           SichtbarExtern    => True);
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EbeneSchleife;
      
      DiplomatischenStatusÄndern (NeuerStatusExtern => DiplomatieDatentypen.Neutral_Enum);
      
   end KarteAufdecken;
   
   
   
   procedure DiplomatischenStatusÄndern
     (NeuerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Enum)
   is begin
      
      RassenErsteSchleife:
      for RasseEinsSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         RassenZweiteSchleife:
         for RasseZweiSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
            
            if
              LeseRassenbelegung.Belegung (RasseExtern => RasseEinsSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
              or
                LeseRassenbelegung.Belegung (RasseExtern => RasseZweiSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
            then
               null;
               
            else
               SpielVariablen.Diplomatie (RasseEinsSchleifenwert, RasseZweiSchleifenwert).AktuellerZustand := NeuerStatusExtern;
            end if;
            
         end loop RassenZweiteSchleife;
      end loop RassenErsteSchleife;
      
   end DiplomatischenStatusÄndern;

end DebugmenueLogik;
