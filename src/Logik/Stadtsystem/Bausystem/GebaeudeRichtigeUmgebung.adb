pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenGrundDatentypen; use KartenGrundDatentypen;
with KartenKonstanten;

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
     
      -------------------   
      if
        LeseGebaeudeDatenbank.GrundBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                              IDExtern    => GebäudeIDExtern)
        = KartenGrundDatentypen.Leer_Grund_Enum
        and
          LeseGebaeudeDatenbank.FlussBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                IDExtern    => GebäudeIDExtern)
        = False
        and
          LeseGebaeudeDatenbank.RessourceBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                    IDExtern    => GebäudeIDExtern)
        = KartenGrundDatentypen.Leer_Ressource_Enum
      then
         return True;
               
      else
         return UmgebungPrüfen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                 GebäudeIDExtern       => GebäudeIDExtern);
      end if;
            
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
              --------------------- An neues Mehrfachumgebung möglich anpassen.
              -- Noch um Umgebungsverbesserung erweitern?
              LeseKarten.Grund (KoordinatenExtern => KartenWert) = LeseGebaeudeDatenbank.GrundBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                         IDExtern    => GebäudeIDExtern)
              or
                LeseGebaeudeDatenbank.FlussBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                      IDExtern    => GebäudeIDExtern)
              = False
            -- LeseKarten.Fluss (KoordinatenExtern => KartenWert) = LeseGebaeudeDatenbank.UmgebungBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
            --                                                                                               IDExtern    => GebäudeIDExtern)
              or
                LeseKarten.Ressource (KoordinatenExtern => KartenWert) = LeseGebaeudeDatenbank.RessourceBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
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
