pragma SPARK_Mode (On);

with BewegungssystemEinheiten, KIPruefungen, KartenPruefungen, BewegungPassierbarkeitPruefen;

package body KIBewegung is

   procedure KIBewegung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum) -- Ist unnötig, mit EinheitRasseNummerExtern kann ich das auch direkt hier nachprüfen
   is begin

      -- 1 = Siedler, 2 = Bauarbeiter, 3 = NahkampfLand, 4 = FernkampfLand, 5 = NahkampfSee, 6 = FernkampfSee, 7 = NahkampfLuft, 8 = FernkampfLuft, 9 = NahkampfUnterirdisch, 10 = FernkampfUnterirdisch,
      -- 11 = NahkampfOrbital, 12 = FernkampfOrbital
      case
        AufgabeExtern
      is
         when KIDatentypen.Flucht =>
            BewegungBeliebig (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         when KIDatentypen.Stadt_Bauen =>
            BewegungBeliebig (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         when KIDatentypen.Erkunden =>
            BewegungBeliebig (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Angreifen =>
            BewegungBeliebig (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         when KIDatentypen.Verbesserung_Anlegen =>
            null;
            
         when KIDatentypen.Verteidigen =>
            BewegungBeliebig (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         when others =>
            null;
      end case;    
      
   end KIBewegung;
   
   
   
   procedure KIBewegungNeu
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      BewegungNochMöglichSchleife:
      while GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte > 0.00 loop
         
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition
           = GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten
         then
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten := (0, 0, 0);
            return;
            
         else
            PlanungErfolgreich := BewegungPlanenRichtung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         end if;
         
      end loop BewegungNochMöglichSchleife;
      
   end KIBewegungNeu;
   
   
   
   function BewegungPlanenRichtung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      if -- Links ist kürzer und die Karte wird nicht verlassen
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse
        >= GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse
        and
          (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse
           + GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse)
            >= 
      abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse
           - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse)
      then
         WieLang := 1;
         
      elsif -- Rechts ist kürzer und die Karte wird verlassen
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse
        >= GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse
      then
         WieLang := 2;
         
      elsif -- Rechts ist kürzer und die Karte wird nicht verlassen
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse
        < GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse
        and
          (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse
           + GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse)
            >= 
      abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse
           - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse)
      then
         WieLang := 3;
         
      else -- Links ist kürzer und die Karte wird verlassen
         WieLang := 4;
      end if;
      
      case
        WieLang
      is
         when 1 | 3 =>
            null;
            
         when 2 | 4 =>
            null;
            
         when others =>
            null;
      end case;
      
      return False;
      
   end BewegungPlanenRichtung;
   
   
   
   function BewegungPlanenSchleife
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      AbbruchWert := 0;
      AnfangKoordinaten := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition;
      
      PlanenSchleife:
      while AbbruchWert <= 10 loop
         
         FeldNummer := 1;
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan := (0 => (AnfangKoordinaten),
                                                                                                                                    others => (0, 0, 0));
         BewegungMöglich := False;
         
         FeldPrüfenSchleife:
         loop
            
            if
              FeldNummer > GlobaleRecords.KIBewegungPlanArray'Last
            then
               AbbruchWert := AbbruchWert + 1;
               exit FeldPrüfenSchleife;
               
            else
               null;
            end if;
            
         end loop FeldPrüfenSchleife;
      end loop PlanenSchleife;
      
      return True;
      
   end BewegungPlanenSchleife;



   procedure NeuesZielErmittelnGefahr
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      RichtungExtern : in KIDatentypen.Richtung_Enum)
   is begin
      
      ZielKoordinaten := KIPruefungen.NähesteEigeneStadtSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 RichtungExtern         => RichtungExtern);

      case
        ZielKoordinaten.Erfolgreich
      is
         when True =>
            return;
            
         when False =>
            ZielKoordinaten := KIPruefungen.NähesteEigeneEinheitSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                         RichtungExtern         => RichtungExtern);
      end case;            

   end NeuesZielErmittelnGefahr;



   procedure BewegungBeliebig
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin

      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
            if
              YÄnderungSchleifenwert = 0
              and
                XÄnderungSchleifenwert = 0
            then
               null;

            else
               Kartenwert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
                                                                       ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                       ZusatzYAbstandExtern => 0);
               
               case
                 Kartenwert.Erfolgreich
               is
                  when True =>               
                     Bewegung := BewegungPassierbarkeitPruefen.FeldFürDieseEinheitPassierbarNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                  NeuePositionExtern       => (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse));
                     if
                       Bewegung = GlobaleDatentypen.Normale_Bewegung_Möglich
                     then
                        BewegungssystemEinheiten.BewegungEinheitenBerechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                              NeuePositionExtern       => (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse));
                        exit YAchseSchleife;
                        
                     else
                        null;
                     end if;
                     
                  when False =>
                     null;
               end case;               
            end if;  
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
   
   end BewegungBeliebig;



   function IstDasEineAltePosition
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EAchseExtern : in GlobaleDatentypen.EbeneVorhanden;
      YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
      return Boolean
   is begin
      
      return False;
      
   end IstDasEineAltePosition;



   procedure BewegungDurchführen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EAchseExtern : in GlobaleDatentypen.EbeneVorhanden;
      YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
   is begin
                
      BewegungssystemEinheiten.BewegungEinheitenBerechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            NeuePositionExtern       => (EAchseExtern, YAchseExtern, XAchseExtern));
      
   end BewegungDurchführen;



   procedure BewegungBauarbeiter
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end BewegungBauarbeiter;
   
   
   
   procedure BewegungBodenEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end BewegungBodenEinheit;
   
   
   
   procedure BewegungLuftEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end BewegungLuftEinheit;
   
   
   
   procedure BewegungWasserEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end BewegungWasserEinheit;
   
   
   
   procedure BewegungUnterwasserEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end BewegungUnterwasserEinheit;



   procedure BewegungUnterirdischeEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end BewegungUnterirdischeEinheit;
   


   procedure BewegungOrbitaleEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end BewegungOrbitaleEinheit;

end KIBewegung;
