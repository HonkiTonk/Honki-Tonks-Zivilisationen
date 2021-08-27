pragma SPARK_Mode (On);

with GlobaleKonstanten;

with LeseKarten, LeseStadtGebaut, LeseGebaeudeDatenbank;

with KartePositionPruefen;

package body GebaeudeRichtigeUmgebung is

   function RichtigeUmgebungVorhanden
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GebäudeIDExtern : in GlobaleDatentypen.GebäudeID)
      return Boolean
   is begin
      
      case
        LeseGebaeudeDatenbank.UmgebungBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                 IDExtern    => GebäudeIDExtern)
      is
         when GlobaleDatentypen.Leer =>
            return True;
               
         when others =>
            null;
      end case;
      
      -- Bei Gebäuden über den gesammten UmgebungGröße-Bereich loopen.
      YAchseGebäudeSchleife:
      for YAchseGebäudeSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
         XAchseGebäudeSchleife:
         for XAchseGebäudeSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
               
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YAchseGebäudeSchleifenwert, XAchseGebäudeSchleifenwert));
               
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
                        
            elsif
              LeseKarten.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                    KoordinatenExtern      => KartenWert)
              = False
            then
               null;
                  
            elsif
              -- Noch um Umgebungsverbesserung erweitern?
              LeseKarten.Grund (PositionExtern => KartenWert) = LeseGebaeudeDatenbank.UmgebungBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                         IDExtern    => GebäudeIDExtern)
              or
                LeseKarten.Fluss (PositionExtern => KartenWert) = LeseGebaeudeDatenbank.UmgebungBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                           IDExtern    => GebäudeIDExtern)
              or
                LeseKarten.Ressource (PositionExtern => KartenWert) = LeseGebaeudeDatenbank.UmgebungBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                               IDExtern    => GebäudeIDExtern)
            then
               return True;
                  
            else
               null;
            end if;
               
         end loop XAchseGebäudeSchleife;
      end loop YAchseGebäudeSchleife;
      
      return False;
      
   end RichtigeUmgebungVorhanden;

end GebaeudeRichtigeUmgebung;
