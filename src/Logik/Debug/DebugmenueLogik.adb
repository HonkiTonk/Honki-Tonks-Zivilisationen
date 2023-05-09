with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with MenueDatentypen;
with KartenKonstanten;
with Projekteinstellungen;

with SchreibeWeltkarte;
with LeseWeltkarteneinstellungen;
with SchreibeSpeziesbelegung;
with SchreibeCursor;
with SchreibeDiplomatie;
with SchreibeWichtiges;

with AuswahlaufteilungLogik;
with Fehlermeldungssystem;

package body DebugmenueLogik is

   procedure Debugmenü
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      case
        Projekteinstellungen.Debug.VolleInformation
      is
         when False =>
            return;
            
         when True =>
            null;
      end case;
      
      DebugmenüSchleife:
      loop
         
         RückgabeDebugmenü := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Debug_Menü_Enum);

         case
           RückgabeDebugmenü
         is
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               KarteAufdecken (SpeziesExtern => SpeziesExtern);
               
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               SchreibeWichtiges.ErforschtDebug (SpeziesExtern => SpeziesExtern);
                              
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               Get_Immediate (Item => Taste);
               MenschKITauschen (TasteExtern => Taste);
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               DiplomatischenStatusÄndern (NeuerStatusExtern => DiplomatieDatentypen.Krieg_Enum,
                                           SpeziesExtern     => SpeziesExtern);
               
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
        LeseSpeziesbelegung.Belegung (SpeziesExtern => Wechsel (TasteExtern))
      is
         when SpeziesDatentypen.Leer_Spieler_Enum =>
            null;
            
         when SpeziesDatentypen.KI_Spieler_Enum =>
            SchreibeSpeziesbelegung.Belegung (SpeziesExtern  => Wechsel (TasteExtern),
                                              BelegungExtern => SpeziesDatentypen.Mensch_Spieler_Enum);
            
            SchreibeCursor.KoordinatenAktuell (SpeziesExtern     => Wechsel (TasteExtern),
                                               KoordinatenExtern => (0, 1, 1));
            SchreibeCursor.KoordinatenAlt (SpeziesExtern     => Wechsel (TasteExtern),
                                           KoordinatenExtern => (0, 1, 1));
                                             
         when SpeziesDatentypen.Mensch_Spieler_Enum =>
            SchreibeSpeziesbelegung.Belegung (SpeziesExtern  => Wechsel (TasteExtern),
                                              BelegungExtern => SpeziesDatentypen.KI_Spieler_Enum);
      end case;
                                             
   end MenschKITauschen;
   
   
   
   procedure KarteAufdecken
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      EbeneSchleife:
      for EAchseSchleifenwert in KartenKonstanten.AnfangEAchse .. KartenKonstanten.EndeEAchse loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse loop
            
               SchreibeWeltkarte.Sichtbar (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                           SpeziesExtern     => SpeziesExtern,
                                           SichtbarExtern    => True);
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EbeneSchleife;
      
      DiplomatischenStatusÄndern (NeuerStatusExtern => DiplomatieDatentypen.Neutral_Enum,
                                   SpeziesExtern     => SpeziesExtern);
      
   end KarteAufdecken;
   
   
   
   procedure DiplomatischenStatusÄndern
     (NeuerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
            
         if
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
           or
             SpeziesSchleifenwert = SpeziesExtern
         then
            null;
               
         else
            SchreibeDiplomatie.AktuellerZustand (SpeziesEinsExtern => SpeziesExtern,
                                                 SpeziesZweiExtern => SpeziesSchleifenwert,
                                                 ZustandExtern     => NeuerStatusExtern);
            
            
            SchreibeDiplomatie.AktuellerZustand (SpeziesEinsExtern => SpeziesSchleifenwert,
                                                 SpeziesZweiExtern => SpeziesExtern,
                                                 ZustandExtern     => NeuerStatusExtern);
         end if;
            
      end loop SpeziesSchleife;
      
   end DiplomatischenStatusÄndern;

end DebugmenueLogik;
