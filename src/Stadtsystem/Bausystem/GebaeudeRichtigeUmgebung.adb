pragma SPARK_Mode (On);

with KartenKonstanten;

with LeseKarten, LeseStadtGebaut, LeseGebaeudeDatenbank;

with KartePositionPruefen;

package body GebaeudeRichtigeUmgebung is

   function RichtigeUmgebungVorhanden
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GebäudeIDExtern : in EinheitStadtDatentypen.GebäudeID)
      return Boolean
   is begin
      
      case
        LeseGebaeudeDatenbank.UmgebungBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                 IDExtern    => GebäudeIDExtern)
      is
         when GlobaleDatentypen.Leer =>
            return True;
               
         when others =>
            return UmgebungPrüfen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                    GebäudeIDExtern       => GebäudeIDExtern);
      end case;
            
   end RichtigeUmgebungVorhanden;
   
   
   
   function UmgebungPrüfen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GebäudeIDExtern : in EinheitStadtDatentypen.GebäudeID)
     return Boolean
   is begin
      
      YAchseGebäudeSchleife:
      for YAchseGebäudeSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
         XAchseGebäudeSchleife:
         for XAchseGebäudeSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
               
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YAchseGebäudeSchleifenwert, XAchseGebäudeSchleifenwert));
               
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
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
      
   end UmgebungPrüfen;

end GebaeudeRichtigeUmgebung;
