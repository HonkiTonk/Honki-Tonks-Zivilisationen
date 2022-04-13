pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with GlobaleTexte;

-- with Auswahl;
with DiplomatischerZustandAenderbar;

package body Diplomatie is
   
   procedure DiplomatieMöglich
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        AndereRassenVorhanden (RasseExtern => RasseExtern)
      is
         when True =>
            DiplomatieMenü (RasseExtern => RasseExtern);
            
         when False =>
            null;
      end case;
      
   end DiplomatieMöglich;
   
   
   
   function AndereRassenVorhanden
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      RassenSchleife:
      for RassenSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RassenSchleifenwert = RasseExtern
           or
             GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Leer_Spieler_Enum
           or
             GlobaleVariablen.Diplomatie (RasseExtern, RassenSchleifenwert).AktuellerZustand = SystemDatentypen.Unbekannt_Enum
         then
            null;
            
         else
            return True;
         end if;
         
      end loop RassenSchleife;
      
      return False;
      
   end AndereRassenVorhanden;
   
   

   procedure DiplomatieMenü
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      DiplomatieSchleife:
      loop
         WelcheRasseSchleife:
         loop
         
            -- WelcheRasse := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Diplomatie,
            --                                TextDateiExtern   => GlobaleTexte.Rassen_Beschreibung_Kurz,
            --                                FrageZeileExtern  => 2,
             --                               ErsteZeileExtern  => 1,
            --                                LetzteZeileExtern => 19);
            
           -- case
          --    WelcheRasse
          --  is
          --     when SystemDatentypen.Zurück_Enum =>
           --       return;
                  
           --    when others =>
          --        null;
          --  end case;
            
            if
              SystemDatentypen.Rassen_Verwendet_Enum'Val (WelcheRasse) = RasseExtern
              or
                GlobaleVariablen.RassenImSpiel (SystemDatentypen.Rassen_Verwendet_Enum'Val (WelcheRasse)) = SystemDatentypen.Leer_Spieler_Enum
                or
                  GlobaleVariablen.Diplomatie (RasseExtern, SystemDatentypen.Rassen_Verwendet_Enum'Val (WelcheRasse)).AktuellerZustand = SystemDatentypen.Unbekannt_Enum
            then
               -- Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
               --                                     TextZeileExtern => 21);
               null;
            
            else
               exit WelcheRasseSchleife;
            end if;
            
         end loop WelcheRasseSchleife;
            
         DiplomatischeAktionSchleife:
         loop
            -- DiplomatischeAktion := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Diplomatie,
            --                                        TextDateiExtern   => GlobaleTexte.Diplomatie,
            --                                        FrageZeileExtern  => 1,
            --                                        ErsteZeileExtern  => 3,
            --                                        LetzteZeileExtern => 7);
            
         --   case
         --     DiplomatischeAktion
          --  is
          --     when 1 =>
          --        DiplomatischeAktion := DiplomatischenStatusÄndern (RasseExtern             => RasseExtern,
          --                                                            KontaktierteRasseExtern => SystemDatentypen.Rassen_Verwendet_Enum'Val (WelcheRasse));
                  
           --    when 2 =>
           --       DiplomatischeAktion := Handeln.Handelsmenü (RasseExtern             => RasseExtern,
            --                                                   KontaktierteRasseExtern => SystemDatentypen.Rassen_Verwendet_Enum'Val (WelcheRasse));
                  
            --   when 3 =>
             --     EinheitVerschieben.VonEigenemLandWerfen (RasseExtern             => RasseExtern,
             --                                              KontaktierteRasseExtern => SystemDatentypen.Rassen_Verwendet_Enum'Val (WelcheRasse));
                  
             --  when SystemDatentypen.Zurück_Enum =>
             --     exit DiplomatischeAktionSchleife;
                  
            --   when others =>
            --      return;
          --  end case;
            
          --  case
          --    DiplomatischeAktion
          --  is
          --     when SystemDatentypen.Zurück_Enum =>
                  return;
                  
          --     when others =>
          --        null;
          --  end case;
         
         end loop DiplomatischeAktionSchleife;
      end loop DiplomatieSchleife;
      
   end DiplomatieMenü;
   
   
   
   -- Später abfragen für Menschen und KI für die jeweiligen Möglichkeiten einbauen.
   function DiplomatischenStatusÄndern
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      -- StatusAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Diplomatie,
      --                                  TextDateiExtern   => GlobaleTexte.Diplomatie,
      --                                  FrageZeileExtern  => 3,
      --                                  ErsteZeileExtern  => 9,
      --                                  LetzteZeileExtern => 12);
            
      case
        StatusAuswahl
      is
         when 1 .. 2 =>
            KriegJetzt := DiplomatischerZustandAenderbar.StatusÄnderbarkeitPrüfen (RasseEinsExtern   => RasseExtern,
                                                                                     RasseZweiExtern   => KontaktierteRasseExtern,
                                                                                     NeuerStatusExtern => SystemDatentypen.Status_Untereinander_Enum'Val (StatusAuswahl));
            return SystemDatentypen.Start_Weiter_Enum;
            
            -- Ist dazu da um im Kriegsfall sofort das Diplomatiemenü zu schließen.
         when 3 =>
            KriegJetzt := DiplomatischerZustandAenderbar.StatusÄnderbarkeitPrüfen (RasseEinsExtern   => RasseExtern,
                                                                                     RasseZweiExtern   => KontaktierteRasseExtern,
                                                                                     NeuerStatusExtern => SystemDatentypen.Status_Untereinander_Enum'Val (StatusAuswahl));
            if
              KriegJetzt
            then
               return SystemDatentypen.Zurück_Enum;
               
            else
               return SystemDatentypen.Start_Weiter_Enum;
            end if;
            
         when others =>
            return SystemDatentypen.Leer_Rückgabe_Enum;
      end case;
      
   end DiplomatischenStatusÄndern;

end Diplomatie;
