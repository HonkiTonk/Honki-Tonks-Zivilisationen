pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenGrundDatentypen; use KartenGrundDatentypen;
with KartenKonstanten;
with KartenGrundKonstanten;

with LeseKarten;
with LeseStadtGebaut;
with LeseGebaeudeDatenbank;

with KarteKoordinatenPruefen;

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
         when KartenGrundKonstanten.LeerGrund =>
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
               
            KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                           ÄnderungExtern    => (0, YAchseGebäudeSchleifenwert, XAchseGebäudeSchleifenwert),
                                                                           LogikGrafikExtern => True);
               
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
              LeseKarten.Grund (KoordinatenExtern => KartenWert) = LeseGebaeudeDatenbank.UmgebungBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                            IDExtern    => GebäudeIDExtern)
              or
                LeseKarten.Fluss (KoordinatenExtern => KartenWert) = LeseGebaeudeDatenbank.UmgebungBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                              IDExtern    => GebäudeIDExtern)
              or
                LeseKarten.Ressource (KoordinatenExtern => KartenWert) = LeseGebaeudeDatenbank.UmgebungBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
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
