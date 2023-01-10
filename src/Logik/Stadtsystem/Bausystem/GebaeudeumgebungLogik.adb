with KartenKonstanten;

with LeseWeltkarte;
with LeseStadtGebaut;
with LeseGebaeudeDatenbank;

with KartenkoordinatenberechnungssystemLogik;

-- Um das theoretisch neue Zeug alles da rein zu basteln müsste man aber hier noch einmal deutlich überarbeiten. äöü
package body GebaeudeumgebungLogik is

   function RichtigeUmgebungVorhanden
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      GebäudeIDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
      use type KartenextraDatentypen.Ressourcen_Enum;
      use type KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
      use type StadtDatentypen.GebäudeIDMitNullwert;
   begin
      
      case
        LeseGebaeudeDatenbank.FalscheEbene (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                            IDExtern    => GebäudeIDExtern,
                                            EbeneExtern => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern).EAchse)
      is
         when True =>
            return False;
            
         when False =>
            Anforderungen.NotwendigFluss := LeseGebaeudeDatenbank.FlussBenötigt (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                  IDExtern    => GebäudeIDExtern);
            Anforderungen.NotwendigerGrund := LeseGebaeudeDatenbank.BasisgrundBenötigt (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                    IDExtern    => GebäudeIDExtern);
            Anforderungen.NotwendigeRessource := LeseGebaeudeDatenbank.RessourceBenötigt (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                           IDExtern    => GebäudeIDExtern);
            Anforderungen.NotwendigeVerbesserung := LeseGebaeudeDatenbank.VerbesserungBenötigt (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                                 IDExtern    => GebäudeIDExtern);
            Anforderungen.NotwendigesGebäude := LeseGebaeudeDatenbank.GebäudeBenötigt (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                          IDExtern    => GebäudeIDExtern);
      end case;
            
      if
        KartengrundDatentypen.Leer_Basisgrund_Enum = Anforderungen.NotwendigerGrund
        and
          False = Anforderungen.NotwendigFluss
          and
            KartenextraDatentypen.Leer_Ressource_Enum = Anforderungen.NotwendigeRessource
            and
              KartenverbesserungDatentypen.Leer_Verbesserung_Enum = Anforderungen.NotwendigeVerbesserung
              and
                StadtKonstanten.LeerGebäudeID = Anforderungen.NotwendigesGebäude
      then
         return True;
               
      else
         return UmgebungPrüfen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                 AnforderungenExtern    => Anforderungen);
      end if;
            
   end RichtigeUmgebungVorhanden;
   
   
   
   function UmgebungPrüfen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      AnforderungenExtern : in AnforderungenRecord)
      return Boolean
   is begin
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      Umgebungsgröße := LeseStadtGebaut.UmgebungGröße (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
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
              False = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                               KoordinatenExtern      => KartenWert)
            then
               null;
               
            else
               Ergebnis := Detailprüfung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
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
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      AnforderungenExtern : in AnforderungenRecord)
      return Boolean
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
      use type KartenextraDatentypen.Fluss_Enum;
      use type KartenextraDatentypen.Ressourcen_Enum;
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
        LeseWeltkarte.Fluss (KoordinatenExtern => KartenWert) /= KartenextraDatentypen.Leer_Fluss_Enum
      then
         null;
         
      else
         return False;
      end if;
        
      if
        AnforderungenExtern.NotwendigeRessource = KartenextraDatentypen.Leer_Ressource_Enum
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
        True = LeseStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                 WelchesGebäudeExtern   => AnforderungenExtern.NotwendigesGebäude)
      then
         null;
         
      else
         return False;
      end if;
      
      return True;
      
   end Detailprüfung;
     
end GebaeudeumgebungLogik;
