pragma SPARK_Mode (On);

with GlobaleTexte, GlobaleKonstanten;

with Anzeige, Auswahl, Handeln, EinheitVerschieben, DiplomatischerZustandAenderbar;

package body Diplomatie is
   
   procedure DiplomatieMöglich
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AndereRassenVorhanden := False;
      
      RassenSchleife:
      for RassenSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RassenSchleifenwert = RasseExtern
           or
             GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Leer
           or
             GlobaleVariablen.Diplomatie (RasseExtern, RassenSchleifenwert).AktuellerZustand = GlobaleDatentypen.Unbekannt
         then
            null;
            
         else
            AndereRassenVorhanden := True;
            exit RassenSchleife;
         end if;
         
      end loop RassenSchleife;
      
      case
        AndereRassenVorhanden
      is
         when True =>
            DiplomatieMenü (RasseExtern => RasseExtern);
            
         when False =>
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                  TextZeileExtern => 20);
      end case;
      
   end DiplomatieMöglich;
   
   

   procedure DiplomatieMenü
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      DiplomatieSchleife:
      loop         
         WelcheRasseSchleife:
         loop
         
            WelcheRasse := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Diplomatie,
                                            TextDateiExtern   => GlobaleTexte.Rassen_Beschreibung_Kurz,
                                            FrageZeileExtern  => 2,
                                            ErsteZeileExtern  => 1,
                                            LetzteZeileExtern => 19);
            
            case
              WelcheRasse
            is
               when GlobaleKonstanten.ZurückKonstante =>
                  return;
                  
               when others =>
                  null;
            end case;
            
            if
              GlobaleDatentypen.Rassen_Verwendet_Enum'Val (WelcheRasse) = RasseExtern
              or
                GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.Rassen_Verwendet_Enum'Val (WelcheRasse)) = GlobaleDatentypen.Leer
                or
                  GlobaleVariablen.Diplomatie (RasseExtern, GlobaleDatentypen.Rassen_Verwendet_Enum'Val (WelcheRasse)).AktuellerZustand = GlobaleDatentypen.Unbekannt
            then
               
               Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                     TextZeileExtern => 21);
            
            else
               exit WelcheRasseSchleife;
            end if;
            
         end loop WelcheRasseSchleife;
            
         DiplomatischeAktionSchleife:
         loop
         
            DiplomatischeAktion := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Diplomatie,
                                                    TextDateiExtern   => GlobaleTexte.Diplomatie,
                                                    FrageZeileExtern  => 1,
                                                    ErsteZeileExtern  => 3,
                                                    LetzteZeileExtern => 7);
            
            case
              DiplomatischeAktion
            is
               when 1 =>                  
                  DiplomatischeAktion := DiplomatischenStatusÄndern (RasseExtern             => RasseExtern,
                                                                      KontaktierteRasseExtern => GlobaleDatentypen.Rassen_Verwendet_Enum'Val (WelcheRasse));
                  
               when 2 =>
                  DiplomatischeAktion := Handeln.Handelsmenü (RasseExtern             => RasseExtern,
                                                               KontaktierteRasseExtern => GlobaleDatentypen.Rassen_Verwendet_Enum'Val (WelcheRasse));
                  
               when 3 =>
                  EinheitVerschieben.VonEigenemLandWerfen (RasseExtern             => RasseExtern,
                                                           KontaktierteRasseExtern => GlobaleDatentypen.Rassen_Verwendet_Enum'Val (WelcheRasse));
                  
               when GlobaleKonstanten.ZurückKonstante =>
                  exit DiplomatischeAktionSchleife;
                  
               when others =>
                  return;
            end case;
            
            case
              DiplomatischeAktion
            is
               when GlobaleKonstanten.ZurückKonstante =>
                  return;
                  
               when others =>
                  null;
            end case;
         
         end loop DiplomatischeAktionSchleife;
      end loop DiplomatieSchleife;
      
   end DiplomatieMenü;
   
   
   
   -- Später abfragen für Menschen und KI für die jeweiligen Möglichkeiten einbauen.
   function DiplomatischenStatusÄndern
     (RasseExtern, KontaktierteRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
      
      StatusAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Diplomatie,
                                        TextDateiExtern   => GlobaleTexte.Diplomatie,
                                        FrageZeileExtern  => 3,
                                        ErsteZeileExtern  => 9,
                                        LetzteZeileExtern => 15);
            
      case
        StatusAuswahl
      is
         when 1 .. 5 =>
            KriegJetzt := DiplomatischerZustandAenderbar.StatusÄnderbarkeitPrüfen (RasseEinsExtern   => RasseExtern,
                                                                                     RasseZweiExtern   => KontaktierteRasseExtern,
                                                                                     NeuerStatusExtern => GlobaleDatentypen.Status_Untereinander_Enum'Val (StatusAuswahl));
            return 1;
            
            -- Ist dazu da um im Kriegsfall sofort das Diplomatiemenü zu schließen.
         when 6 =>
            KriegJetzt := DiplomatischerZustandAenderbar.StatusÄnderbarkeitPrüfen (RasseEinsExtern   => RasseExtern,
                                                                                     RasseZweiExtern   => KontaktierteRasseExtern,
                                                                                     NeuerStatusExtern => GlobaleDatentypen.Status_Untereinander_Enum'Val (StatusAuswahl));
            if
              KriegJetzt
            then
               return GlobaleKonstanten.ZurückKonstante;
               
            else
               return 1;
            end if;
            
         when others =>
            return 0;
      end case;
      
   end DiplomatischenStatusÄndern;

end Diplomatie;
