pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords; use KartenRecords;
with EinheitenDatentypen; use EinheitenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with EinheitenRecords; use EinheitenRecords;
with KartenKonstanten;
with KartenRecordKonstanten;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseKarten;

with Kartenkoordinatenberechnungssystem;
with EinheitSuchen;
with BewegungPassierbarkeitPruefen;
with Vergleiche;

with KIDatentypen;

with KIKartenfeldbewertungModifizieren;
with KIAufgabenVerteilt;
with KIEinheitAllgemeinePruefungen;

package body KIEinheitFestlegenSiedeln is

   ----------------------------------- Hier noch eine Beschränkung auf nur sichtbare Felder einbauen.
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
            
      YAchseKoordinatePrüfen := 0;
      XAchseKoordinatePrüfen := 0;
      YAchseKoordinatenSchonGeprüft := 0;
      XAchseKoordinatenSchonGeprüft := 0;
            
      KartenfeldSuchenSchleife:
      loop
                  
         MöglichesFeld := NeuesStadtfeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           UmgebungExtern           => (YAchseKoordinatePrüfen, XAchseKoordinatePrüfen),
                                           GeprüftExtern            => (YAchseKoordinatenSchonGeprüft, XAchseKoordinatenSchonGeprüft));
         
         case
           MöglichesFeld.XAchse
         is
            when KartenKonstanten.LeerXAchse =>
               null;
               
            when others =>
               return MöglichesFeld;
         end case;
         
         if
           YAchseKoordinatePrüfen > Karten.Karteneinstellungen.Kartengröße.YAchse / 2
           and
             XAchseKoordinatePrüfen > Karten.Karteneinstellungen.Kartengröße.XAchse / 2
         then
            exit KartenfeldSuchenSchleife;
            
         else
            null;
         end if;
         
         if
           YAchseKoordinatePrüfen < Karten.Karteneinstellungen.Kartengröße.YAchse / 2
         then
            YAchseKoordinatePrüfen := YAchseKoordinatePrüfen + 1;
            YAchseKoordinatenSchonGeprüft := YAchseKoordinatePrüfen - 1;
            
         else
            null;
         end if;
            
         if
           XAchseKoordinatePrüfen <= Karten.Karteneinstellungen.Kartengröße.XAchse / 2
         then
            XAchseKoordinatePrüfen := XAchseKoordinatePrüfen + 1;
            XAchseKoordinatenSchonGeprüft := XAchseKoordinatePrüfen - 1;
            
         else
            null;
         end if;
         
      end loop KartenfeldSuchenSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end StadtfeldSuchen;
     
   
      
   function NeuesStadtfeld
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      UmgebungExtern : in KartenRecords.YXAchsenKartenfeldNaturalRecord;
      GeprüftExtern : in KartenRecords.YXAchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      YAchseKartenfeldSuchenSchleife:
      for YAchseSchleifenwert in -UmgebungExtern.YAchse .. UmgebungExtern.YAchse loop
         XAchseKartenfeldSuchenSchleife:
         for XAchseSchleifenwert in -UmgebungExtern.XAchse .. UmgebungExtern.XAchse loop
               
            if
              GeprüftExtern.YAchse > abs (YAchseSchleifenwert)
              and
                GeprüftExtern.XAchse > abs (XAchseSchleifenwert)
            then
               FeldGutUndFrei := False;
               
            else
               MöglichesStadtfeld := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                                             ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                             LogikGrafikExtern => True);
               
               case
                 MöglichesStadtfeld.XAchse
               is
                  when KartenKonstanten.LeerXAchse =>
                     FeldGutUndFrei := False;
                     
                  when others =>
                     FeldGutUndFrei := KartenfeldUmgebungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                  KoordinatenExtern        => MöglichesStadtfeld);
               end case;
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
              and
                KIEinheitAllgemeinePruefungen.BlockiertDurchWasser (KoordinatenExtern => MöglichesStadtfeld) = False
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
      
      EinheitAufFeld := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
      
      if
        EinheitAufFeld.Nummer /= EinheitenKonstanten.LeerNummer
        and
          EinheitAufFeld /= EinheitRasseNummerExtern
      then
         return False;
      
      elsif
        BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                   NeueKoordinatenExtern    => KoordinatenExtern)
        = False
      then
         return False;
         
      elsif
        LeseKarten.BelegterGrundLeer (KoordinatenExtern => KoordinatenExtern) = False
      then
         return False;
      
      elsif
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
