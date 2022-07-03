pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords; use KartenRecords;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenKonstanten;
with KartenRecordKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseKarten;

with Kartenkoordinatenberechnungssystem;
with Vergleiche;

with KIDatentypen;

with KIKartenfeldbewertungModifizieren;
with KIAufgabenVerteilt;
with KIEinheitAllgemeinePruefungen;

package body KIEinheitFestlegenSiedeln is

   function StadtBauen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      NeueStadtKoordinaten := StadtfeldSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        Vergleiche.KoordinateLeervergleich (KoordinateExtern => NeueStadtKoordinaten)
      is
         when True =>
            return False;
            
         when False =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => NeueStadtKoordinaten);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Stadt_Bauen_Enum);
            return True;
      end case;
      
   end StadtBauen;
   
    
   
   function StadtfeldSuchen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
            
      UmgebungPrüfen := 0;
      BereitsGeprüft := 0;
            
      KartenfeldSuchenSchleife:
      loop
                  
         MöglichesFeld := NeuesStadtfeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           UmgebungExtern           => UmgebungPrüfen,
                                           GeprüftExtern            => BereitsGeprüft);
         
         case
           MöglichesFeld.XAchse
         is
            when KartenKonstanten.LeerXAchse =>
               null;
               
            when others =>
               return MöglichesFeld;
         end case;
         
         ------------------------------ Eventuell um die Einheit und dann um alle Städte herum prüfen?
         if
           UmgebungPrüfen > 15
         then
            ---------------------------- Dann hier um andere Städte/Einheiten herumloopen?
            exit KartenfeldSuchenSchleife;
            
         else
            UmgebungPrüfen := UmgebungPrüfen + 1;
            BereitsGeprüft := UmgebungPrüfen - 1;
         end if;
         
      end loop KartenfeldSuchenSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end StadtfeldSuchen;
     
   
      
   function NeuesStadtfeld
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      UmgebungExtern : in KartenDatentypen.KartenfeldNatural;
      GeprüftExtern : in KartenDatentypen.KartenfeldNatural)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      YAchseKartenfeldSuchenSchleife:
      for YAchseSchleifenwert in -UmgebungExtern .. UmgebungExtern loop
         XAchseKartenfeldSuchenSchleife:
         for XAchseSchleifenwert in -UmgebungExtern .. UmgebungExtern loop
               
            if
              GeprüftExtern > abs (YAchseSchleifenwert)
              and
                GeprüftExtern > abs (XAchseSchleifenwert)
            then
               FeldGutUndFrei := False;
               
            else
               MöglichesStadtfeld := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                                             ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                             LogikGrafikExtern => True);
               
               if
                 MöglichesStadtfeld.XAchse = KartenKonstanten.LeerXAchse
               then
                  FeldGutUndFrei := False;
                     
               else
                  FeldGutUndFrei := KartenfeldUmgebungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                               KoordinatenExtern        => MöglichesStadtfeld);
               end if;
            end if;
            
            if
              FeldGutUndFrei = False
            then
               null;
               
            elsif
              KIAufgabenVerteilt.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Stadt_Bauen_Enum,
                                                     RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                     ZielKoordinatenExtern => MöglichesStadtfeld)
              = False
            then
               return MöglichesStadtfeld;
                  
            else
               null;
            end if;
            
         end loop XAchseKartenfeldSuchenSchleife;
      end loop YAchseKartenfeldSuchenSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end NeuesStadtfeld;
   
   
   
   function KartenfeldUmgebungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      case
        KIEinheitAllgemeinePruefungen.KartenfeldPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         KoordinatenExtern        => KoordinatenExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      case
        LeseKarten.BelegterGrundLeer (KoordinatenExtern => KoordinatenExtern)
      is
         when False =>
            return False;
         
         when True =>
            null;
      end case;
      
      if
        LeseKarten.Bewertung (KoordinatenExtern => KoordinatenExtern,
                              RasseExtern       => EinheitRasseNummerExtern.Rasse)
        < KIKartenfeldbewertungModifizieren.BewertungStadtBauen (KoordinatenExtern => KoordinatenExtern,
                                                                 RasseExtern       => EinheitRasseNummerExtern.Rasse)
      then
         return False;
         
         -------------------------------- Diese Prüfung hier mal rassenspezifisch erweitern.
      elsif
        LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern) = KartengrundDatentypen.Eis_Enum
      then
         return False;
         
      else
         return True;
      end if;
      
   end KartenfeldUmgebungPrüfen;

end KIEinheitFestlegenSiedeln;
