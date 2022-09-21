pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with KartenverbesserungDatentypen; use KartenverbesserungDatentypen;
with StadtDatentypen; use StadtDatentypen;
with StadtKonstanten;
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
        and
          KartenverbesserungDatentypen.Leer_Verbesserung_Enum = LeseGebaeudeDatenbank.VerbesserungBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                             IDExtern    => GebäudeIDExtern)
        and
          StadtKonstanten.LeerGebäudeID = LeseGebaeudeDatenbank.GebäudeBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
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
      Ergebnis := False;
      
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
               
            else
               Ergebnis := Detailprüfung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                           GebäudeIDExtern       => GebäudeIDExtern,
                                           KoordinatenExtern      => KartenWert);
            end if;
            
            case
              Ergebnis
            is
               when True =>
                  return True;
                  
               when False =>
                  null;
            end case;
            
         end loop XAchseGebäudeSchleife;
      end loop YAchseGebäudeSchleife;
      
      return False;
      
   end UmgebungPrüfen;
   
   
   
   function Detailprüfung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      GebäudeIDExtern : in StadtDatentypen.GebäudeID;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      NotwendigerGrund := LeseGebaeudeDatenbank.GrundBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                IDExtern    => GebäudeIDExtern);
      
      if
        KartengrundDatentypen.Leer_Grund_Enum = NotwendigerGrund
      then
         null;
         
      elsif
        NotwendigerGrund = LeseWeltkarte.AktuellerGrund (KoordinatenExtern => KoordinatenExtern)
        or
          NotwendigerGrund = LeseWeltkarte.BasisGrund (KoordinatenExtern => KoordinatenExtern)
      then
         null;
         
      else
         return False;
      end if;
      
      if
        False = LeseGebaeudeDatenbank.FlussBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                      IDExtern    => GebäudeIDExtern)
      then
         null;
         
      elsif
        LeseWeltkarte.Fluss (KoordinatenExtern => KartenWert) /= KartengrundDatentypen.Leer_Fluss_Enum
      then
         null;
         
      else
         return False;
      end if;
      
      NotwendigeRessource := LeseGebaeudeDatenbank.RessourceBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                       IDExtern    => GebäudeIDExtern);
        
      if
        NotwendigeRessource = KartengrundDatentypen.Leer_Ressource_Enum
      then
         null;
         
      elsif
        LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern) = NotwendigeRessource
      then
         null;
         
      else
         return False;
      end if;
      
      NotwendigeVerbesserung := LeseGebaeudeDatenbank.VerbesserungBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                             IDExtern    => GebäudeIDExtern);
      
      if
        NotwendigeVerbesserung = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
      then
         null;
         
      elsif
        NotwendigeVerbesserung = LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern)
      then
         null;
         
      else
         return False;
      end if;
      
      NotwendigesGebäude := LeseGebaeudeDatenbank.GebäudeBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                      IDExtern    => GebäudeIDExtern);
      
      if
        NotwendigesGebäude = StadtKonstanten.LeerGebäudeID
      then
         null;
         
      elsif
        True = LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                  WelchesGebäudeExtern  => NotwendigesGebäude)
      then
         null;
         
      else
         return False;
      end if;
      
      return True;
      
   end Detailprüfung;
     
end GebaeudeumgebungLogik;
