pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with Sf.Window.Keyboard;

with KartenDatentypen; use KartenDatentypen;
with GlobaleTexte;

with SchreibeWichtiges;
with SchreibeKarten;
with LeseKarten;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with LeseWichtiges;

with Karte;
with Karten;
with Anzeige;
with ForschungAllgemein;
with EingabeSFML;


package body Cheat is

   procedure Menü
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      MenüSchleife:
      loop

         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Cheat_Menü,
                                        TextDateiExtern        => GlobaleTexte.Cheat_Menü,
                                        ÜberschriftZeileExtern => 1,
                                        ErsteZeileExtern       => 2,
                                        LetzteZeileExtern      => 3,
                                        AbstandAnfangExtern    => GlobaleTexte.Leer,
                                        AbstandMitteExtern     => GlobaleTexte.Neue_Zeile,
                                        AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);
         
         case
           EingabeSFML.TastenEingabe.key.code
         is
            -- Volle Informationen (unabhängig von der Rasse)
            when Sf.Window.Keyboard.sfKeyI =>
               Informationen;

               -- Sichtbarkeit der ganzen Karte
            when Sf.Window.Keyboard.sfKeyS =>
               Sichtbarkeit (RasseExtern => RasseExtern);
               
            when Sf.Window.Keyboard.sfKeyK =>
               Krieg;
               
            when Sf.Window.Keyboard.sfKeyG =>
               GewonnenDurchCheat := not GewonnenDurchCheat;
               
            when Sf.Window.Keyboard.sfKeyM =>
               SchreibeWichtiges.Geldmenge (RasseExtern         => RasseExtern,
                                            GeldZugewinnExtern  => Integer'Last,
                                            RechnenSetzenExtern => False);
               
            when others =>
               return;
         end case;
         
         Karte.AnzeigeKarte (RasseExtern => RasseExtern);

      end loop MenüSchleife;
      
   end Menü;



   procedure Informationen
   is begin
      
      FeindlicheInformationenSehen := not FeindlicheInformationenSehen;
   
   end Informationen;



   procedure Sichtbarkeit
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EbeneSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
               SchreibeKarten.Sichtbar (PositionExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                        RasseExtern    => RasseExtern,
                                        SichtbarExtern => True);
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EbeneSchleife;
      
      Krieg;
      
   end Sichtbarkeit;
   
   
   
   procedure Krieg
   is begin
      
      RassenErsteSchleife:
      for RasseEinsSchleifenwert in SonstigeDatentypen.Rassen_Verwendet_Enum'Range loop
         RassenZweiteSchleife:
         for RasseZweiSchleifenwert in SonstigeDatentypen.Rassen_Verwendet_Enum'Range loop
            
            GlobaleVariablen.Diplomatie (RasseEinsSchleifenwert, RasseZweiSchleifenwert).AktuellerZustand := SonstigeDatentypen.Neutral;
            
         end loop RassenZweiteSchleife;
      end loop RassenErsteSchleife;
      
   end Krieg;
   
   
   
   procedure KarteInfosEinheiten
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Put_Line (Item => "Aktuelle Rasse: " & EinheitRasseNummerExtern.Rasse'Wide_Wide_Image);
      ErsteAnzeige := True;
      
      case
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse)
      is
         when SonstigeDatentypen.Spieler_KI =>
            BewegungPlanSchleife:
            for BewegungGeplantSchleifenwert in EinheitStadtRecords.KIBewegungPlanArray'Range loop
                      
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
      ForschungAllgemein.Beschreibung (IDExtern => LeseWichtiges.Forschungsprojekt (RasseExtern => EinheitRasseNummerExtern.Rasse));
      New_Line;
      
   end KarteInfosEinheiten;
   
   
   
   procedure KarteInfosFeld
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Put (Item => "Aktuelle GrundID: " & LeseKarten.Grund (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position)'Wide_Wide_Image);
      Put_Line (Item => "    Aktuelle Stadtbelegung:" & Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).DurchStadtBelegterGrund'Wide_Wide_Image);
      Put (Item => "Weg: " & LeseKarten.VerbesserungWeg (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position)'Wide_Wide_Image);
      Put_Line (Item => "    Feldverbesserung: " & LeseKarten.VerbesserungGebiet (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position)'Wide_Wide_Image);
      
      ErsteAnzeige := True;
      
      RassenSchleife:
      for RasseSchleifenwert in SonstigeDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           ErsteAnzeige
         is
            when True =>
               Put_Line (Item => "Kartenfeldbewertung:");
               ErsteAnzeige := False;
               
            when False =>
               null;
         end case;
         
         Put (Item => "    " & RasseSchleifenwert'Wide_Wide_Image & ":" & LeseKarten.Bewertung (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                                                                RasseExtern    => RasseSchleifenwert)'Wide_Wide_Image);
         
         if
           SonstigeDatentypen.Rassen_Verwendet_Enum'Pos (RasseSchleifenwert) mod 6 = 0
         then
            New_Line;
            
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
   end KarteInfosFeld;
   
   
   
   procedure KarteStadtInfos
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Put_Line (Item => "Aktuelle Rasse: " & StadtRasseNummerExtern.Rasse'Wide_Wide_Image);
      Put_Line (Item => "KIAufgabe: " & LeseStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern)'Wide_Wide_Image);
      Put_Line (Item => "Aktuelles Forschungsprojekt:");
      ForschungAllgemein.Beschreibung (IDExtern => LeseWichtiges.Forschungsprojekt (RasseExtern => StadtRasseNummerExtern.Rasse));
      New_Line;
      
   end KarteStadtInfos;

end Cheat;
