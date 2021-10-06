pragma SPARK_Mode (On);

with GlobaleTexte;
with SystemKonstanten;

with Anzeige;
with Auswahl;
with Handeln;
with EinheitVerschieben;
with DiplomatischerZustandAenderbar;

package body Diplomatie is
   
   procedure DiplomatieMöglich
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        AndereRassenVorhanden (RasseExtern => RasseExtern)
      is
         when True =>
            DiplomatieMenü (RasseExtern => RasseExtern);
            
         when False =>
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                  TextZeileExtern => 20);
      end case;
      
   end DiplomatieMöglich;
   
   
   
   function AndereRassenVorhanden
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      RassenSchleife:
      for RassenSchleifenwert in SonstigeDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RassenSchleifenwert = RasseExtern
           or
             GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Leer
           or
             GlobaleVariablen.Diplomatie (RasseExtern, RassenSchleifenwert).AktuellerZustand = SonstigeDatentypen.Unbekannt
         then
            null;
            
         else
            return True;
         end if;
         
      end loop RassenSchleife;
      
      return False;
      
   end AndereRassenVorhanden;
   
   

   procedure DiplomatieMenü
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
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
               when SystemKonstanten.ZurückKonstante =>
                  return;
                  
               when others =>
                  null;
            end case;
            
            if
              SonstigeDatentypen.Rassen_Verwendet_Enum'Val (WelcheRasse) = RasseExtern
              or
                GlobaleVariablen.RassenImSpiel (SonstigeDatentypen.Rassen_Verwendet_Enum'Val (WelcheRasse)) = SonstigeDatentypen.Leer
                or
                  GlobaleVariablen.Diplomatie (RasseExtern, SonstigeDatentypen.Rassen_Verwendet_Enum'Val (WelcheRasse)).AktuellerZustand = SonstigeDatentypen.Unbekannt
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
                                                                      KontaktierteRasseExtern => SonstigeDatentypen.Rassen_Verwendet_Enum'Val (WelcheRasse));
                  
               when 2 =>
                  DiplomatischeAktion := Handeln.Handelsmenü (RasseExtern             => RasseExtern,
                                                               KontaktierteRasseExtern => SonstigeDatentypen.Rassen_Verwendet_Enum'Val (WelcheRasse));
                  
               when 3 =>
                  EinheitVerschieben.VonEigenemLandWerfen (RasseExtern             => RasseExtern,
                                                           KontaktierteRasseExtern => SonstigeDatentypen.Rassen_Verwendet_Enum'Val (WelcheRasse));
                  
               when SystemKonstanten.ZurückKonstante =>
                  exit DiplomatischeAktionSchleife;
                  
               when others =>
                  return;
            end case;
            
            case
              DiplomatischeAktion
            is
               when SystemKonstanten.ZurückKonstante =>
                  return;
                  
               when others =>
                  null;
            end case;
         
         end loop DiplomatischeAktionSchleife;
      end loop DiplomatieSchleife;
      
   end DiplomatieMenü;
   
   
   
   -- Später abfragen für Menschen und KI für die jeweiligen Möglichkeiten einbauen.
   function DiplomatischenStatusÄndern
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
      
      StatusAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Diplomatie,
                                        TextDateiExtern   => GlobaleTexte.Diplomatie,
                                        FrageZeileExtern  => 3,
                                        ErsteZeileExtern  => 9,
                                        LetzteZeileExtern => 12);
            
      case
        StatusAuswahl
      is
         when 1 .. 2 =>
            KriegJetzt := DiplomatischerZustandAenderbar.StatusÄnderbarkeitPrüfen (RasseEinsExtern   => RasseExtern,
                                                                                     RasseZweiExtern   => KontaktierteRasseExtern,
                                                                                     NeuerStatusExtern => SonstigeDatentypen.Status_Untereinander_Enum'Val (StatusAuswahl));
            return 1;
            
            -- Ist dazu da um im Kriegsfall sofort das Diplomatiemenü zu schließen.
         when 3 =>
            KriegJetzt := DiplomatischerZustandAenderbar.StatusÄnderbarkeitPrüfen (RasseEinsExtern   => RasseExtern,
                                                                                     RasseZweiExtern   => KontaktierteRasseExtern,
                                                                                     NeuerStatusExtern => SonstigeDatentypen.Status_Untereinander_Enum'Val (StatusAuswahl));
            if
              KriegJetzt
            then
               return SystemKonstanten.ZurückKonstante;
               
            else
               return 1;
            end if;
            
         when others =>
            return 0;
      end case;
      
   end DiplomatischenStatusÄndern;

end Diplomatie;
