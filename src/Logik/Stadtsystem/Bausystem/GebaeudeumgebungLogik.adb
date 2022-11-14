with StadtKonstanten;
with KartenKonstanten;

with LeseWeltkarte;
with LeseStadtGebaut;
with LeseGebaeudeDatenbank;

with KartenkoordinatenberechnungssystemLogik;

-- Um das theoretisch neue Zeug alles da rein zu basteln müsste man aber hier noch einmal deutlich überarbeiten. äöü
package body GebaeudeumgebungLogik is

   function RichtigeUmgebungVorhanden
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      GebäudeIDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
      use type KartengrundDatentypen.Kartenressourcen_Enum;
      use type KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
      use type StadtDatentypen.GebäudeIDMitNullwert;
   begin
      
      case
        LeseGebaeudeDatenbank.FalscheEbene (RasseExtern => StadtRasseNummerExtern.Rasse,
                                            IDExtern    => GebäudeIDExtern,
                                            EbeneExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern).EAchse)
      is
         when True =>
            return False;
            
         when False =>
            Anforderungen.NotwendigFluss := LeseGebaeudeDatenbank.FlussBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                  IDExtern    => GebäudeIDExtern);
            Anforderungen.NotwendigerGrund := LeseGebaeudeDatenbank.BasisgrundBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                    IDExtern    => GebäudeIDExtern);
            Anforderungen.NotwendigeRessource := LeseGebaeudeDatenbank.RessourceBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                           IDExtern    => GebäudeIDExtern);
            Anforderungen.NotwendigeVerbesserung := LeseGebaeudeDatenbank.VerbesserungBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                 IDExtern    => GebäudeIDExtern);
            Anforderungen.NotwendigesGebäude := LeseGebaeudeDatenbank.GebäudeBenötigt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                          IDExtern    => GebäudeIDExtern);
      end case;
            
      if
        KartengrundDatentypen.Leer_Basisgrund_Enum = Anforderungen.NotwendigerGrund
        and
          False = Anforderungen.NotwendigFluss
          and
            KartengrundDatentypen.Leer_Ressource_Enum = Anforderungen.NotwendigeRessource
            and
              KartenverbesserungDatentypen.Leer_Verbesserung_Enum = Anforderungen.NotwendigeVerbesserung
              and
                StadtKonstanten.LeerGebäudeID = Anforderungen.NotwendigesGebäude
      then
         return True;
               
      else
         return UmgebungPrüfen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                 AnforderungenExtern    => Anforderungen);
      end if;
            
   end RichtigeUmgebungVorhanden;
   
   
   
   function UmgebungPrüfen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      AnforderungenExtern : in AnforderungenRecord)
      return Boolean
   is begin
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      Umgebungsgröße := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      Ergebnis := False;
      
      YAchseSchleife:
      for YAchseSchleifenwert in -Umgebungsgröße .. Umgebungsgröße loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Umgebungsgröße .. Umgebungsgröße loop
               
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
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
                                           KoordinatenExtern      => KartenWert,
                                           AnforderungenExtern    => AnforderungenExtern);
            end if;
            
            case
              Ergebnis
            is
               when True =>
                  return True;
                  
               when False =>
                  null;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return False;
      
   end UmgebungPrüfen;
   
   
   
   function Detailprüfung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      AnforderungenExtern : in AnforderungenRecord)
      return Boolean
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
      use type KartengrundDatentypen.Kartenfluss_Enum;
      use type KartengrundDatentypen.Kartenressourcen_Enum;
      use type KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
      use type StadtDatentypen.GebäudeIDMitNullwert;
   begin
            
      if
        KartengrundDatentypen.Leer_Basisgrund_Enum = AnforderungenExtern.NotwendigerGrund
      then
         null;
         
      elsif
        AnforderungenExtern.NotwendigerGrund = LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern)
      then
         null;
         
      else
         return False;
      end if;
      
      if
        False = AnforderungenExtern.NotwendigFluss
      then
         null;
         
      elsif
        LeseWeltkarte.Fluss (KoordinatenExtern => KartenWert) /= KartengrundDatentypen.Leer_Fluss_Enum
      then
         null;
         
      else
         return False;
      end if;
        
      if
        AnforderungenExtern.NotwendigeRessource = KartengrundDatentypen.Leer_Ressource_Enum
      then
         null;
         
      elsif
        LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern) = AnforderungenExtern.NotwendigeRessource
      then
         null;
         
      else
         return False;
      end if;
            
      if
        AnforderungenExtern.NotwendigeVerbesserung = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
      then
         null;
         
      elsif
        AnforderungenExtern.NotwendigeVerbesserung = LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern)
      then
         null;
         
      else
         return False;
      end if;
      
      if
        AnforderungenExtern.NotwendigesGebäude = StadtKonstanten.LeerGebäudeID
      then
         null;
         
      elsif
        True = LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                 WelchesGebäudeExtern   => AnforderungenExtern.NotwendigesGebäude)
      then
         null;
         
      else
         return False;
      end if;
      
      return True;
      
   end Detailprüfung;
     
end GebaeudeumgebungLogik;
