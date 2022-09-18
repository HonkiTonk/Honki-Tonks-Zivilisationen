pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenKonstanten;

with LeseWeltkarte;
with LeseStadtGebaut;
with LeseGebaeudeDatenbank;

with KartenkoordinatenberechnungssystemLogik;

package body GebaeudeumgebungLogik is

   function RichtigeUmgebungVorhanden
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      GebäudeIDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
   is begin
     
      if
        KartengrundDatentypen.Leer_Grund_Enum = LeseGebaeudeDatenbank.GrundBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                      IDExtern    => GebäudeIDExtern)
        and
          False = LeseGebaeudeDatenbank.FlussBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                        IDExtern    => GebäudeIDExtern)
        and
          KartengrundDatentypen.Leer_Ressource_Enum = LeseGebaeudeDatenbank.RessourceBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                IDExtern    => GebäudeIDExtern)
      then
         return True;
               
      else
         return UmgebungPrüfen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                 GebäudeIDExtern       => GebäudeIDExtern);
      end if;
            
   end RichtigeUmgebungVorhanden;
   
   
   
   function UmgebungPrüfen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      GebäudeIDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
   is begin
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YAchseGebäudeSchleife:
      for YAchseGebäudeSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
         XAchseGebäudeSchleife:
         for XAchseGebäudeSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
               
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                 ÄnderungExtern    => (0, YAchseGebäudeSchleifenwert, XAchseGebäudeSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
               
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
                        
            elsif
              False = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                            KoordinatenExtern      => KartenWert)
            then
               null;
                  
            elsif
              -- An neue Mehrfachumgebung möglich anpassen. äöü
              -- Noch um Umgebungsverbesserung erweitern? äöü
              LeseWeltkarte.AktuellerGrund (KoordinatenExtern => KartenWert) = LeseGebaeudeDatenbank.GrundBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                                  IDExtern    => GebäudeIDExtern)
              or
                False = LeseGebaeudeDatenbank.FlussBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                              IDExtern    => GebäudeIDExtern)
              -- or
              -- LeseWeltkarte.Fluss (KoordinatenExtern => KartenWert) = LeseGebaeudeDatenbank.FlussBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
              --                                                                                            IDExtern    => GebäudeIDExtern)
              or
                LeseWeltkarte.Ressource (KoordinatenExtern => KartenWert) = LeseGebaeudeDatenbank.RessourceBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
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

end GebaeudeumgebungLogik;
