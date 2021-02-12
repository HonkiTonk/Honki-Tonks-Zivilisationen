pragma SPARK_Mode (On);

with Auswahl, Anzeige, Sortieren;

package body EinheitenDatenbank is

   procedure Beschreibung (ID : in GlobaleDatentypen.EinheitenID) is
   begin
      
      Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                          AktuelleAuswahl    => 0,
                          FrageDatei         => 0,
                          FrageZeile         => 0,
                          TextDatei          => 12,
                          ErsteZeile         => Integer (ID),
                          LetzteZeile        => Integer (ID));
      
   end Beschreibung;



   procedure LebenspunkteBewegungspunkteAufMaximumSetzen (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AktuelleLebenspunkte
        := EinheitenListe (EinheitRasseUndNummer.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).ID).MaximaleLebenspunkte;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AktuelleBewegungspunkte
        := EinheitenListe (EinheitRasseUndNummer.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).ID).MaximaleBewegungspunkte;
      
   end LebenspunkteBewegungspunkteAufMaximumSetzen;



   procedure HeilungBewegungspunkteFürNeueRundeSetzen is
   begin
      
      RassenSchleife:
      for RasseIntern in GlobaleVariablen.EinheitenGebaut'Range (1) loop
         EinheitenSchleife:
         for EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
            if GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID = 0 then
               exit EinheitenSchleife;

            else
               null;
            end if;

            if GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigung <= 0 then
               GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBewegungspunkte := EinheitenListe (RasseIntern, GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID).MaximaleBewegungspunkte;

            else
               GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBewegungspunkte := 0.00;
            end if;

            if GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigung = 7
              and GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleLebenspunkte + Heilungsrate
              >= EinheitenListe (RasseIntern, GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID).MaximaleLebenspunkte then
               GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleLebenspunkte := EinheitenListe (RasseIntern, GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID).MaximaleLebenspunkte;
               GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigung := 0;
               GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigungszeit := 0;
                  
            elsif GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleBeschäftigung = 7
              and GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleLebenspunkte + Heilungsrate
              < EinheitenListe (RasseIntern, GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID).MaximaleLebenspunkte then
               GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleLebenspunkte := GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AktuelleLebenspunkte + Heilungsrate;
               
            else
               null;
            end if;
            
         end loop EinheitenSchleife;
      end loop RassenSchleife;
      
   end HeilungBewegungspunkteFürNeueRundeSetzen;
   


   procedure EinheitErzeugen (StadtRasseUndNummer : GlobaleRecords.RasseUndPlatznummerRecord; ID : in Positive) is -- Kann Einheiten nur in Städten erzeugen und funktioniert nicht richtig
   begin

      Position := (GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AchsenPosition.EAchse,
                   GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AchsenPosition.YAchse,
                   GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AchsenPosition.XAchse);
      EinheitenPosition := 0;
            
      EinheitenSchleife:
      for EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
         if GlobaleVariablen.EinheitenGebaut (StadtRasseUndNummer.Rasse, EinheitNummer).ID = 0 then
            EinheitenPosition := EinheitNummer;
            exit EinheitenSchleife;

         elsif GlobaleVariablen.EinheitenGebaut (StadtRasseUndNummer.Rasse, EinheitNummer).AchsenPosition = GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AchsenPosition then
            return;
            
         else
            null;
         end if;
            
      end loop EinheitenSchleife;

      case EinheitenPosition is
         when 0 =>
            return;
            
         when others =>
            GlobaleVariablen.EinheitenGebaut (StadtRasseUndNummer.Rasse, EinheitenPosition).ID := GlobaleDatentypen.EinheitenID (ID);
            GlobaleVariablen.EinheitenGebaut (StadtRasseUndNummer.Rasse, EinheitenPosition).AchsenPosition := Position;
            LebenspunkteBewegungspunkteAufMaximumSetzen (EinheitRasseUndNummer => (StadtRasseUndNummer.Rasse, EinheitenPosition));
            GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).VerbleibendeBauzeit := 0;
            GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleRessourcen := 0;
            GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuellesBauprojekt := 0;
      end case;
            
   end EinheitErzeugen;



   procedure EinheitEntfernenMitSortieren (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer) := (0, 0,    0, (0, 1, 1),    0, 0.00, 0, 0,    0, 0);      
      Sortieren.EinheitenSortieren (RasseExtern => EinheitRasseUndNummer.Rasse);

      if GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, 1).ID = 0 and GlobaleVariablen.StadtGebaut (EinheitRasseUndNummer.Rasse, 1).ID = 0 then
         GlobaleVariablen.RassenImSpiel (EinheitRasseUndNummer.Rasse) := 0;
         
      else
         null;
      end if;
      
   end EinheitEntfernenMitSortieren;



   procedure EinheitEntfernenOhneSortieren (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
   begin

      GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer) := (0, 0,    0, (0, 1, 1),    0, 0.00, 0, 0,    0, 0); 

      if GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, 1).ID = 0 and GlobaleVariablen.StadtGebaut (EinheitRasseUndNummer.Rasse, 1).ID = 0 then
         GlobaleVariablen.RassenImSpiel (EinheitRasseUndNummer.Rasse) := 0;
         
      else
         null;
      end if;
      
   end EinheitEntfernenOhneSortieren;
   
   

   procedure Beschäftigung (Arbeit : in Natural) is
   begin
      
      case Arbeit is
         when 0 =>
            Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                AktuelleAuswahl    => 0,
                                FrageDatei         => 0,
                                FrageZeile         => 0,
                                TextDatei          => 20,
                                ErsteZeile         => 9,
                                LetzteZeile        => 9);            
            
         when others =>
            Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                AktuelleAuswahl    => 0,
                                FrageDatei         => 0,
                                FrageZeile         => 0,
                                TextDatei          => 20,
                                ErsteZeile         => Arbeit,
                                LetzteZeile        => Arbeit);
      end case;
      
   end Beschäftigung;
   


   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahl : in Natural) return Boolean is
   begin
      
      Wahl := Auswahl.AuswahlNeu (AuswahlOderAnzeige => True,
                                  FrageDatei         => 10,
                                  FrageZeile         => 7,
                                  TextDatei          => 5,
                                  ErsteZeile         => 10,
                                  LetzteZeile        => 11);
      case Wahl is
         when -3 =>
            return True;
                     
         when others =>
            return False;
      end case;
      
   end BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen;

end EinheitenDatenbank;
