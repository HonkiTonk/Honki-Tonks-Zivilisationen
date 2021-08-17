pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleTexte;

with Karte, Karten, Anzeige, Eingabe, ForschungAllgemein, LeseKarten, SchreibeKarten;

package body Cheat is

   procedure Menü
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
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
           Eingabe.TastenEingabe
         is
            -- Volle Informationen (unabhängig von der Rasse)
            when 'i' =>
               Informationen;

               -- Sichtbarkeit der ganzen Karte
            when 's' =>
               Sichtbarkeit (RasseExtern => RasseExtern);
               
            when 'g' =>
               GewonnenDurchCheat := not GewonnenDurchCheat;
               
            when 'm' =>
               GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge := Integer'Last;
               
            when others =>
               return;
         end case;
         Karte.AnzeigeKarte (RasseExtern => RasseExtern);

      end loop MenüSchleife;
      
   end Menü;



   procedure Informationen
   is begin
      
      GlobaleVariablen.FeindlicheInformationenSehen := not GlobaleVariablen.FeindlicheInformationenSehen;
   
   end Informationen;



   procedure Sichtbarkeit
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
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
      
      RassenErsteSchleife:
      for RasseEinsSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         RassenZweiteSchleife:
         for RasseZweiSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
            
            GlobaleVariablen.Diplomatie (RasseEinsSchleifenwert, RasseZweiSchleifenwert).AktuellerZustand := GlobaleDatentypen.Neutral;
            
         end loop RassenZweiteSchleife;
      end loop RassenErsteSchleife;
      
   end Sichtbarkeit;
   
   
   
   procedure KarteInfosEinheiten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Put_Line (Item => "Aktuelle Rasse:" & EinheitRasseNummerExtern.Rasse'Wide_Wide_Image);
                     
      BewegungPlanSchleife:
      for BewegungGeplantSchleifenwert in GlobaleRecords.KIBewegungPlanArray'Range loop
                        
         Put_Line (Item => "EAchse:" & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (BewegungGeplantSchleifenwert).EAchse'Wide_Wide_Image
                   & "    " & "YAchse:" & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (BewegungGeplantSchleifenwert).YAchse'Wide_Wide_Image
                   & "    " & "XAchse:" & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (BewegungGeplantSchleifenwert).XAchse'Wide_Wide_Image);
                        
      end loop BewegungPlanSchleife;
                     
      Put_Line (Item => "Ziel EAchse:" & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.EAchse'Wide_Wide_Image & "    "
                & "Ziel YAchse:" & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse'Wide_Wide_Image & "    "
                & "Ziel XAchse:" & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse'Wide_Wide_Image);
                     
      Put_Line (Item => "KIAufgabe:" & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt'Wide_Wide_Image);
      Put_Line (Item => "AufgabeEins:" & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung'Wide_Wide_Image);
      Put_Line (Item => "AufgabeZwei:" & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger'Wide_Wide_Image);
      Put_Line (Item => "Aktuelles Forschungsprojekt:");
      ForschungAllgemein.Beschreibung (IDExtern => GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Forschungsprojekt);
      
   end KarteInfosEinheiten;
   
   
   
   procedure KarteInfosFeld
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Put (Item => "Aktuelle GrundID: " & LeseKarten.Grund (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position)'Wide_Wide_Image);
      Put_Line (Item => "    Aktuelle Stadtbelegung:" & Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).DurchStadtBelegterGrund'Wide_Wide_Image);
      Put (Item => "Weg: " & LeseKarten.VerbesserungWeg (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position)'Wide_Wide_Image);
      Put_Line (Item => "    Feldverbesserung: " & LeseKarten.VerbesserungGebiet (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position)'Wide_Wide_Image);
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         Put_Line (Item => "Kartenfeldbewertung " & RasseSchleifenwert'Wide_Wide_Image & ":" & LeseKarten.Bewertung (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                                                                                     RasseExtern    => RasseSchleifenwert)'Wide_Wide_Image);
         
      end loop RassenSchleife;
      
   end KarteInfosFeld;
   
   
   
   procedure KarteStadtInfos
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Put_Line (Item => "Aktuelle Rasse:" & StadtRasseNummerExtern.Rasse'Wide_Wide_Image);
      Put_Line (Item => "KIAufgabe:" & GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIBeschäftigung'Wide_Wide_Image);
      Put_Line (Item => "Aktuelles Forschungsprojekt:");
      ForschungAllgemein.Beschreibung (IDExtern => GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Forschungsprojekt);
      New_Line;
      
   end KarteStadtInfos;

end Cheat;
