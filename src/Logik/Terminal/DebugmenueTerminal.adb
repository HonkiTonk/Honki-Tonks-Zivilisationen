pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with KartenDatentypen; use KartenDatentypen;
with ZahlenDatentypen;

with SchreibeWichtiges;
with LeseKarten;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with LeseWichtiges;

with Karten;
with ForschungsbeschreibungenSFML;

package body DebugmenueTerminal is

   -- Überarbeiten/Wieder für Terminal zurückbauen. äöü
   -- Sollte hier nie auf SFML zugreifen.
   procedure Menü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      MenüSchleife:
      loop
         
         -- Hier nicht mehr direkt darauf zugreifen sondern so wie in allen anderen Menüs.
         -- EingabeSystemeSFML.TastenEingabe;
         
         --  case
         --    EingabeSystemeSFML.TastaturTaste
         --  is
         -- Volle Informationen (unabhängig von der Rasse)
         --     when Sf.Window.Keyboard.sfKeyI =>
         Informationen;
               
         --     when Sf.Window.Keyboard.sfKeyG =>
         DebugSieg := not DebugSieg;
               
         --     when Sf.Window.Keyboard.sfKeyM =>
         SchreibeWichtiges.Geldmenge (RasseExtern         => RasseExtern,
                                      GeldZugewinnExtern  => ZahlenDatentypen.EigenerInteger'Last,
                                      RechnenSetzenExtern => False);
               
         --     when others =>
         --        return;
         --  end case;
         
         -- Karte hier nur Anzeigen wenn Terminal aktiv ist? Oder kann die Terminal auch wie die SFML ausgelagert werden?
         -- Karte.AnzeigeKarte (RasseExtern => RasseExtern);

      end loop MenüSchleife;
      
   end Menü;



   procedure Informationen
   is begin
      
      FeindlicheInformationenSehen := not FeindlicheInformationenSehen;
   
   end Informationen;
   
   
   
   procedure KarteInfosEinheiten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      Put_Line (Item => "Aktuelle Rasse: " & EinheitRasseNummerExtern.Rasse'Wide_Wide_Image);
      ErsteAnzeige := True;
      
      case
        SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse)
      is
         when RassenDatentypen.KI_Spieler_Enum =>
            BewegungPlanSchleife:
            for BewegungGeplantSchleifenwert in EinheitenRecords.KIBewegungPlanArray'Range loop
                      
               case
                 ErsteAnzeige
               is
                  when True =>
                     Put_Line (Item => "Bewegungsschritte:");
                     ErsteAnzeige := False;
                     
                  when False =>
                     null;
               end case;
               
               Put (Item => "    " & LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                         PlanschrittExtern        => BewegungGeplantSchleifenwert).EAchse'Wide_Wide_Image
                    & "," & LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                PlanschrittExtern        => BewegungGeplantSchleifenwert).YAchse'Wide_Wide_Image
                    & "," & LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                PlanschrittExtern        => BewegungGeplantSchleifenwert).XAchse'Wide_Wide_Image);
                        
               if
                 BewegungGeplantSchleifenwert mod 8 = 0
               then
                  New_Line;
                  
               else
                  null;
               end if;
               
            end loop BewegungPlanSchleife;
                     
            New_Line;
            Put_Line (Item => "Zielposition:" & LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern).EAchse'Wide_Wide_Image
                      & "," & LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern).YAchse'Wide_Wide_Image
                      & "," & LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern).XAchse'Wide_Wide_Image);
            
            Put_Line (Item => "KIAufgabe: " & LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)'Wide_Wide_Image);
            
         when others =>
            null;
      end case;
      
      Put (Item => "AufgabeEins: " & LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)'Wide_Wide_Image);
      Put_Line (Item => "     AufgabeZwei: " & LeseEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern)'Wide_Wide_Image);
      Put_Line (Item => "Aktuelles Forschungsprojekt:");
      Put_Line (Item => ForschungsbeschreibungenSFML.BeschreibungKurz (IDExtern    => LeseWichtiges.Forschungsprojekt (RasseExtern => EinheitRasseNummerExtern.Rasse),
                                                             RasseExtern => EinheitRasseNummerExtern.Rasse));
      New_Line;
      
   end KarteInfosEinheiten;
   
   
   
   procedure KarteInfosFeld
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Die Stadtbelegung eventuell in die Terminalnanzeige verschieben? Die Belegung wird ja auch in der SFML angezeigt.
      
      Put (Item => "Aktuelle GrundID: " & LeseKarten.AktuellerGrund (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell)'Wide_Wide_Image);
      Put_Line (Item => "    Aktuelle Stadtbelegung:" & Karten.Weltkarte (SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse, SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse,
                SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse).DurchStadtBelegterGrund.RasseBelegt'Wide_Wide_Image & ", "
                & Karten.Weltkarte (SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse, SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse,
                  SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse).DurchStadtBelegterGrund.StadtBelegt'Wide_Wide_Image);
      Put (Item => "Weg: " & LeseKarten.Weg (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell)'Wide_Wide_Image);
      Put_Line (Item => "    Feldverbesserung: " & LeseKarten.Verbesserung (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell)'Wide_Wide_Image);
      
      ErsteAnzeige := True;
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           ErsteAnzeige
         is
            when True =>
               Put_Line (Item => "Kartenfeldbewertung:");
               ErsteAnzeige := False;
               
            when False =>
               null;
         end case;
         
         Put (Item => "    " & RasseSchleifenwert'Wide_Wide_Image & ":" & LeseKarten.Bewertung (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                                                                                                RasseExtern       => RasseSchleifenwert)'Wide_Wide_Image);
         
         if
           RassenDatentypen.Rassen_Verwendet_Enum'Pos (RasseSchleifenwert) mod 6 = 0
         then
            New_Line;
            
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
   end KarteInfosFeld;
   
   
   
   procedure KarteStadtInfos
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      Put_Line (Item => "Aktuelle Rasse: " & StadtRasseNummerExtern.Rasse'Wide_Wide_Image);
      Put_Line (Item => "KIAufgabe: " & LeseStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image);
      Put_Line (Item => "Aktuelles Forschungsprojekt:");
      Put_Line (Item => ForschungsbeschreibungenSFML.BeschreibungKurz (IDExtern    => LeseWichtiges.Forschungsprojekt (RasseExtern => StadtRasseNummerExtern.Rasse),
                                                             RasseExtern => StadtRasseNummerExtern.Rasse));
      New_Line;
      
   end KarteStadtInfos;

end DebugmenueTerminal;
