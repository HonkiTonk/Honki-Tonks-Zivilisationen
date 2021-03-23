pragma SPARK_Mode (On);

with GlobaleKonstanten;

with Auswahl, Anzeige, Sortieren;

package body EinheitenDatenbank is

   procedure Beschreibung (IDExtern : in GlobaleDatentypen.EinheitenID) is
   begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Beschreibungen_Einheiten_Kurz,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => Positive (IDExtern),
                                     LetzteZeileExtern      => Positive (IDExtern),
                                     AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Keiner);
      
   end Beschreibung;



   procedure LebenspunkteBewegungspunkteAufMaximumSetzen (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleLebenspunkte
        := EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).MaximaleLebenspunkte;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte
        := EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).MaximaleBewegungspunkte;
      
   end LebenspunkteBewegungspunkteAufMaximumSetzen;



   procedure HeilungBewegungspunkteFürNeueRundeSetzen is
   begin
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen loop
         EinheitenSchleife:
         for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
            
            if GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).ID = 0 then
               exit EinheitenSchleife;

            else
               null;
            end if;

            if GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).AktuelleBeschäftigung = 0 then
               GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).AktuelleBewegungspunkte
                 := EinheitenListe (RasseSchleifenwert, GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).ID).MaximaleBewegungspunkte;

            else
               GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).AktuelleBewegungspunkte := 0.00;
            end if;

            if GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).AktuelleBeschäftigung = 7
              and GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).AktuelleLebenspunkte + Heilungsrate
              >= EinheitenListe (RasseSchleifenwert, GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).ID).MaximaleLebenspunkte then
               GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).AktuelleLebenspunkte
                 := EinheitenListe (RasseSchleifenwert, GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).ID).MaximaleLebenspunkte;
               GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).AktuelleBeschäftigung := 0;
               GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).AktuelleBeschäftigungszeit := 0;
                  
            elsif GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).AktuelleBeschäftigung = 7
              and GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).AktuelleLebenspunkte + Heilungsrate
              < EinheitenListe (RasseSchleifenwert, GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).ID).MaximaleLebenspunkte then
               GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).AktuelleLebenspunkte
                 := GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).AktuelleLebenspunkte + Heilungsrate;
               
            else
               null;
            end if;
            
         end loop EinheitenSchleife;
      end loop RassenSchleife;
      
   end HeilungBewegungspunkteFürNeueRundeSetzen;
   


   procedure EinheitErzeugen (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; IDExtern : in GlobaleDatentypen.EinheitenID) is -- Kann Einheiten nur in Städten erzeugen und funktioniert nicht richtig
   begin

      Position := (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                   GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                   GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AchsenPosition.XAchse);
      EinheitNummer := 0;
            
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
            
         if GlobaleVariablen.EinheitenGebaut (StadtRasseNummerExtern.Rasse, EinheitNummerSchleifenwert).ID = 0 then
            EinheitNummer := EinheitNummerSchleifenwert;
            exit EinheitenSchleife;

         elsif GlobaleVariablen.EinheitenGebaut (StadtRasseNummerExtern.Rasse, EinheitNummerSchleifenwert).AchsenPosition
           = GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AchsenPosition then
            return;
            
         else
            null;
         end if;
            
      end loop EinheitenSchleife;

      case EinheitNummer is
         when 0 =>
            return;
            
         when others =>
            GlobaleVariablen.EinheitenGebaut (StadtRasseNummerExtern.Rasse, EinheitNummer).ID := IDExtern;
            GlobaleVariablen.EinheitenGebaut (StadtRasseNummerExtern.Rasse, EinheitNummer).AchsenPosition := Position;
            LebenspunkteBewegungspunkteAufMaximumSetzen (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummer));
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).VerbleibendeBauzeit := 0;
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuelleRessourcen := 0;
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt := 0;
      end case;
            
   end EinheitErzeugen;



   procedure EinheitEntfernenMitSortieren (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer) := GlobaleVariablen.LeererWertEinheit;
      Sortieren.EinheitenSortieren (RasseExtern => EinheitRasseNummerExtern.Rasse);

      if GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, 1).ID = 0 and GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, 1).ID = 0 then
         GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) := 0;
         
      else
         null;
      end if;
      
   end EinheitEntfernenMitSortieren;



   procedure EinheitEntfernenOhneSortieren (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin

      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer) := GlobaleVariablen.LeererWertEinheit;

      if GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, 1).ID = 0 and GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, 1).ID = 0 then
         GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) := 0;
         
      else
         null;
      end if;
      
   end EinheitEntfernenOhneSortieren;
   
   

   procedure Beschäftigung (ArbeitExtern : in Natural) is
   begin
      
      case ArbeitExtern is
         when 0 =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                           TextDateiExtern        => GlobaleDatentypen.Beschreibungen_Beschäftigung_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => 9,
                                           LetzteZeileExtern      => 9,
                                           AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                           AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                           AbstandEndeExtern      => GlobaleDatentypen.Keiner);
            
         when others =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                           TextDateiExtern        => GlobaleDatentypen.Beschreibungen_Beschäftigung_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => ArbeitExtern,
                                           LetzteZeileExtern      => ArbeitExtern,
                                           AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                           AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                           AbstandEndeExtern      => GlobaleDatentypen.Keiner);
      end case;
      
   end Beschäftigung;
   


   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern : in Natural) return Boolean is
   begin
      
      Wahl := Auswahl.AuswahlJaNein (FrageZeileExtern => 7);
      case Wahl is
         when GlobaleKonstanten.JaKonstante =>
            return True;
            
         when others =>
            return False;
      end case;
      
   end BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen;



   function EinheitTransporterAuswählen return GlobaleDatentypen.MaximaleEinheitenMitNullWert is
   begin
      
      return 0;
      
   end EinheitTransporterAuswählen;

end EinheitenDatenbank;
