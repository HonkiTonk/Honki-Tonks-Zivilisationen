pragma SPARK_Mode (On);

with GlobaleKonstanten;

with GebaeudeDatenbank;

with KartePositionPruefen, KartenAllgemein, FeldTesten;

package body GebaeudeRichtigeUmgebung is

   function BenötigteUmgebungVorhanden
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GebäudeIDExtern : in GlobaleDatentypen.GebäudeID)
      return Boolean
   is begin
      
      case
        GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GebäudeIDExtern).UmgebungBenötigt
      is
         when GlobaleDatentypen.Leer =>
            return True;
               
         when others =>
            null;
      end case;
      
      -- Bei Gebäuden über den gesammten Bereich loopen, bei Einheiten nur um das direkte Umfeld.
      YAchseGebäudeSchleife:
      for YAchseGebäudeSchleifenwert in -GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße
        .. GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße loop
         XAchseGebäudeSchleife:
         for XAchseGebäudeSchleifenwert in -GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße
           .. GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße loop
               
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                                                        ÄnderungExtern    => (0, YAchseGebäudeSchleifenwert, XAchseGebäudeSchleifenwert));
               
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
                        
            elsif
              FeldTesten.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                    KoordinatenExtern      => KartenWert) = False
            then
               null;
                  
            elsif
              -- Noch um Umgebungsverbesserung erweitern?
              KartenAllgemein.FeldGrund (PositionExtern => KartenWert) = GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GebäudeIDExtern).UmgebungBenötigt
              or
                KartenAllgemein.FeldFluss (PositionExtern => KartenWert) = GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GebäudeIDExtern).UmgebungBenötigt
              or
                KartenAllgemein.FeldRessource (PositionExtern => KartenWert) = GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GebäudeIDExtern).UmgebungBenötigt
            then
               return True;
                  
            else
               null;
            end if;
               
         end loop XAchseGebäudeSchleife;
      end loop YAchseGebäudeSchleife;
      
      return False;
      
   end BenötigteUmgebungVorhanden;

end GebaeudeRichtigeUmgebung;
