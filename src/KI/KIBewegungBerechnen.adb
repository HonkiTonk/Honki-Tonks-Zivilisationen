pragma SPARK_Mode (On);

with KartenPruefungen, BewegungBlockiert, KIPruefungen, BewegungPassierbarkeitPruefen;

package body KIBewegungBerechnen is
   
   procedure BewegungPlanen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      AnfangKoordinaten := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition;      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan := (0 => (AnfangKoordinaten),
                                                                                                                                 others => (0, 0, 0));
      Wegpunkte := (others => (others => (0, 0, 0)));
      MöglicheNeueKoordinaten := AnfangKoordinaten;
      AbbruchWert := 1;
      
      YAchseSchleife:
      for YAchseSchleifenwert in WegpunkteArray'Range (1) loop
         XAchseSchleife:
         for XAchseSchleifenwert in WegpunkteArray'Range (2) loop
            
            Kartenwert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => AnfangKoordinaten,
                                                                    ÄnderungExtern       => (0, GlobaleDatentypen.Kartenfeld (YAchseSchleifenwert), GlobaleDatentypen.Kartenfeld (XAchseSchleifenwert)),
                                                                    ZusatzYAbstandExtern => 0);
               
            case
              Kartenwert.Erfolgreich
            is
               when False =>
                  exit XAchseSchleife;
                     
               when True =>
                  null;
            end case;
            
            BewegungMöglich := BewegungPassierbarkeitPruefen.EinfachePassierbarkeitPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                             NeuePositionExtern       => (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse));
            Bewegung := BewegungBlockiert.BlockiertStadtEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 NeuePositionExtern       => (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse));
            
            
            if
              Bewegung = GlobaleDatentypen.Normale_Bewegung_Möglich
              and
                BewegungMöglich = True
            then
               Wegpunkte (YAchseSchleifenwert, XAchseSchleifenwert) := (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse);
            
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      BewegungPlanSchleife:
      while AbbruchWert <= GlobaleRecords.KIBewegungPlanArray'Last loop
         
         YAchseSchleifeZwei:
         for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            XAchseSchleifeZwei:
            for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
               
               Kartenwert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => MöglicheNeueKoordinaten,
                                                                       ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                       ZusatzYAbstandExtern => 0);
               
               case
                 Kartenwert.Erfolgreich
               is
               when False =>
                  exit XAchseSchleifeZwei;
                     
               when True =>
                  null;
               end case;
               
               Bewegung := BewegungBlockiert.BlockiertStadtEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                    NeuePositionExtern       => (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse));
               
               case
                 Bewegung
               is
               when GlobaleDatentypen.Normale_Bewegung_Möglich =>
                  null;
                     
               when others =>
                  null;
               end case;
               
            end loop XAchseSchleifeZwei;
         end loop YAchseSchleifeZwei;
         
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (AbbruchWert)
           = GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten
         then
            return;
            
         elsif
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (AbbruchWert).YAchse = 0
         then
            null;
            
         else         
            AbbruchWert := AbbruchWert + 1;
         end if;
         
      end loop BewegungPlanSchleife;
      
   end BewegungPlanen;



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



   function IstDasEineAltePosition
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EAchseExtern : in GlobaleDatentypen.EbeneVorhanden;
      YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv)
   return Boolean
   is begin
      
      return False;
      
   end IstDasEineAltePosition;

end KIBewegungBerechnen;
