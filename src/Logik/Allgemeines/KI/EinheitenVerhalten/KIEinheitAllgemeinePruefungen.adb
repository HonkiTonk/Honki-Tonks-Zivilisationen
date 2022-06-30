pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with EinheitenRecords; use EinheitenRecords;
with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;
with KartenKonstanten;
with ForschungenDatentypen;

with LeseKarten;

with EinheitSuchen;
with BewegungPassierbarkeitPruefen;

with Kartenkoordinatenberechnungssystem;

package body KIEinheitAllgemeinePruefungen is
   
   -- Einige Prüfungen sind nicht immer 100% sinnvoll, beispielsweise von KIEinheitFestlegenVerbesserungen.StadtumgebungVerbessern kommend ist die Sichtbarkeitsprüfung ein wenig unsinnig,
   -- aber nur dafür eine Extrafunktion schein ein wenig übertrieben.
   -------------------------------------- Werde aber später wohl doch noch mehrere Versionen bauen müssen.
   function KartenfeldPrüfen
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
        BlockiertDurchWasser (KoordinatenExtern => KoordinatenExtern) = True
      then
         return False;   
         
      elsif
        LeseKarten.BelegterGrundLeer (KoordinatenExtern => KoordinatenExtern) = False
      then
         return False;
                  
      elsif
        LeseKarten.Sichtbar (KoordinatenExtern => KoordinatenExtern,
                             RasseExtern       => EinheitRasseNummerExtern.Rasse)
        = False
      then
         return False;
         
      else
         return True;
      end if;
      
   end KartenfeldPrüfen;
   
   
   
   function BlockiertDurchWasser
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      Wasserfelder := 0;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            Wasserumgebung := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                     ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                     LogikGrafikExtern => True);
            
            if
              Wasserumgebung.XAchse = KartenKonstanten.LeerXAchse
            then
               Wasserfelder := Wasserfelder + 1;
               
            elsif
              LeseKarten.BasisGrund (KoordinatenExtern => Wasserumgebung) = KartengrundDatentypen.Wasser_Enum
            then
               Wasserfelder := Wasserfelder + 1;
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      if
        Wasserfelder >= 8
      then
         null;
            
      else
         return False;
      end if;
      
      ------------------------------------- Hier später noch brauchbare Prüfungen auf vorhandene Technologie und Wassertransporter einbauen.
      ForschungenSchleife:
      for ForschungSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
         
         null;
         
      end loop ForschungenSchleife;
      
      return True;
      
   end BlockiertDurchWasser;
   
end KIEinheitAllgemeinePruefungen;
