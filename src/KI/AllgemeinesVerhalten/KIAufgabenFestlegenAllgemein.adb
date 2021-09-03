pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIDatentypen, KIKonstanten;

with LeseStadtGebaut;

with KartePositionPruefen, BewegungPassierbarkeitPruefen, BewegungBlockiert;

package body KIAufgabenFestlegenAllgemein is

   procedure Heilen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      -- Das hier so lassen? Als KI Version von EinheitenAllgemein?
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Einheit_Heilen;
      
   end Heilen;
   
   
   
   procedure EinheitVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      PlatzGefunden := KIKonstanten.NullKoordinate;
      
      StadtSchleife:
      for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtSchleifenwert))
         is
            when GlobaleKonstanten.LeerStadtID =>
               null;
               
            when others =>
               PlatzGefunden := EinheitVerbessernPlatz (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtSchleifenwert),
                                                        EinheitNummerExtern    => EinheitRasseNummerExtern.Platznummer);
               if
                 PlatzGefunden.XAchse = GlobaleKonstanten.LeerYXKartenWert
               then
                  null;
                  
               else
                  exit StadtSchleife;
               end if;
         end case;
                               
      end loop StadtSchleife;
      
      case
        PlatzGefunden.XAchse
      is
         when GlobaleKonstanten.LeerYXKartenWert =>
            null;
            
         when others =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Einheit_Verbessern;
      end case;
      
   end EinheitVerbessern;
   
   
   
   function EinheitVerbessernPlatz
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitNummerExtern : in GlobaleDatentypen.MaximaleEinheiten)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      Umgebung := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in -Umgebung .. Umgebung loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Umgebung .. Umgebung loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              YAchseSchleifenwert = GlobaleKonstanten.LeerYXKartenWert
              and
                XAchseSchleifenwert = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                                                         NeuePositionExtern       => KartenWert)
              = False
            then
               null;
               
            elsif
              BewegungBlockiert.BlockiertStadtEinheit (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                                       NeuePositionExtern       => KartenWert)
              = True
            then
               null;
               
            else
               return KartenWert;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return KIKonstanten.NullKoordinate;
      
   end EinheitVerbessernPlatz;

end KIAufgabenFestlegenAllgemein;
