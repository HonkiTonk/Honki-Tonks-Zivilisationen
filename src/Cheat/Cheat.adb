pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleTexte;

with Karte, Karten, Anzeige, Eingabe, ForschungAllgemein;

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
                                        AbstandAnfangExtern    => GlobaleTexte.Keiner,
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
            
               Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert).Sichtbar (RasseExtern) := True;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EbeneSchleife;
      
   end Sichtbarkeit;
   
   
   
   procedure KarteInfosEinheiten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Put_Line (Item => "Aktuelle Rasse: " & EinheitRasseNummerExtern.Rasse'Wide_Wide_Image);
                     
      BewegungPlanSchleife:
      for BewegungGeplantSchleifenwert in GlobaleRecords.KIBewegungPlanArray'Range loop
                        
         Put_Line (Item => "EAchse: " & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (BewegungGeplantSchleifenwert).EAchse'Wide_Wide_Image
                   & "    " & "YAchse: " & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (BewegungGeplantSchleifenwert).YAchse'Wide_Wide_Image
                   & "    " & "XAchse: " & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (BewegungGeplantSchleifenwert).XAchse'Wide_Wide_Image);
                        
      end loop BewegungPlanSchleife;
                     
      Put_Line (Item => "Ziel EAchse: " & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.EAchse'Wide_Wide_Image & "    "
                & "Ziel YAchse: " & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse'Wide_Wide_Image & "    "
                & "Ziel XAchse: " & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse'Wide_Wide_Image);
                     
      Put_Line (Item => "KIAufgabe: " & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt'Wide_Wide_Image);
      Put_Line (Item => "AufgabeEins: " & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung'Wide_Wide_Image);
      Put_Line (Item => "AufgabeZwei: " & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger'Wide_Wide_Image);
      Put_Line (Item => "Aktuelles Forschungsprojekt: ");
      ForschungAllgemein.Beschreibung (IDExtern    => GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).Forschungsprojekt);
      
   end KarteInfosEinheiten;
   
   
   
   procedure KarteInfosFeld
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Put (Item => "Aktuelle EPosition: " & GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse'Wide_Wide_Image);
      Put (Item => "    Aktuelle YPosition: " & GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse'Wide_Wide_Image);
      Put_Line (Item => "    Aktuelle XPosition: " & GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse'Wide_Wide_Image);
      Put (Item => "Kartenfeldbewertung: " & Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Felderwertung'Wide_Wide_Image);
      Put_Line (Item => "    Aktuelle GrundID: " & Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).Grund'Wide_Wide_Image);
      Put_Line (Item => "Aktuelle Stadtbelegung: " & Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).DurchStadtBelegterGrund'Wide_Wide_Image);
      Put (Item => "Straße: " & Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).VerbesserungStraße'Wide_Wide_Image);
      Put_Line (Item => "    Feldverbesserung: " & Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse,
                GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse).VerbesserungGebiet'Wide_Wide_Image);
      
   end KarteInfosFeld;
   
   
   
   procedure KarteStadtInfos
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Put_Line (Item => "Aktuelle Rasse: " & StadtRasseNummerExtern.Rasse'Wide_Wide_Image);
      Put_Line (Item => "KIAufgabe: " & GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIBeschäftigung'Wide_Wide_Image);
      Put_Line (Item => "Aktuelles Forschungsprojekt: ");
      ForschungAllgemein.Beschreibung (IDExtern    => GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Forschungsprojekt);
      
   end KarteStadtInfos;

end Cheat;
