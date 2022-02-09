pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;
with SchreibeKarten;
with SchreibeWichtiges;
with LeseKarten;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with KartePositionPruefen;
with RasseEntfernen;
with Wachstum;

package body StadtEntfernen is

   procedure StadtEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      BelegteStadtfelderFreigeben (StadtRasseNummerExtern => StadtRasseNummerExtern);
      HeimatstädteEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      NeueHauptstadtSetzen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      SchreibeStadtGebaut.Nullsetzung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      Wachstum.WachstumWichtiges (RasseExtern => StadtRasseNummerExtern.Rasse);
      SchreibeWichtiges.AnzahlStädte (RasseExtern     => StadtRasseNummerExtern.Rasse,
                                       PlusMinusExtern => False);
      RasseEntfernen.RasseExistenzPrüfen (RasseExtern => StadtRasseNummerExtern.Rasse);
      
   end StadtEntfernen;
   
   
   
   procedure BelegteStadtfelderFreigeben
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      YUmgebungFreigebenSchleife:
      for YUmgebungFreigebenSchleifenwert in KartenDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XUmgebungFreigebenSchleife:
         for XUmgebungFreigebenSchleifenwert in KartenDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YUmgebungFreigebenSchleifenwert, XUmgebungFreigebenSchleifenwert),
                                                                        LogikGrafikExtern => True);
         
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                    KoordinatenExtern      => KartenWert)
              = True
            then
               SchreibeKarten.BelegterGrund (PositionExtern      => KartenWert,
                                             BelegterGrundExtern => KartenKonstanten.LeerDurchStadtBelegterGrund);
            
            else
               null;
            end if;
         
         end loop XUmgebungFreigebenSchleife;
      end loop YUmgebungFreigebenSchleife;
      
   end BelegteStadtfelderFreigeben;
   
   
   
   procedure HeimatstädteEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Einheitengrenze loop
         
         if
           LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerSchleifenwert)) = StadtRasseNummerExtern.Platznummer
         then
            SchreibeEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerSchleifenwert),
                                                 HeimatstadtExtern        => EinheitenKonstanten.LeerEinheit.Heimatstadt);
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
   end HeimatstädteEntfernen;
   
   
   
   procedure NeueHauptstadtSetzen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when KartenDatentypen.Eigene_Hauptstadt =>
            null;
            
         when others =>
            return;
      end case;
      
      StadtSchleife:
      for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze loop
         
         if
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (StadtRasseNummerExtern.Rasse, StadtSchleifenwert)) = KartenDatentypen.Leer
           or
             StadtSchleifenwert = StadtRasseNummerExtern.Platznummer
         then
            null;
            
         else
            SchreibeStadtGebaut.ID (StadtRasseNummerExtern => (StadtRasseNummerExtern.Rasse, StadtSchleifenwert),
                                    IDExtern               => KartenDatentypen.Eigene_Hauptstadt);
            return;
         end if;
         
      end loop StadtSchleife;
      
   end NeueHauptstadtSetzen;

end StadtEntfernen;
