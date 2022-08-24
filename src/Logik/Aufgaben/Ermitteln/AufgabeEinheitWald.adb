pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenRecordKonstanten;
with TextnummernKonstanten;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseKarten;

with AufgabeEinheitRoden;
with Fehler;
with Auswahlaufteilungen;
with AufgabenArbeitszeitWald;
with Grenzpruefungen;

package body AufgabeEinheitWald is

   function WaldErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      VorhandenerGrund := LeseKarten.VorhandenerGrund (KoordinatenExtern => KoordinatenExtern);
      
      -- Nur auf Basisgrund prüfen? Müsste hierbei ausreichen. äöü
      if
        AufgabenArbeitszeitWald.Arbeitszeit (EinheitRasseNummerExtern.Rasse, VorhandenerGrund.BasisGrund) = EinheitenKonstanten.UnmöglicheArbeit
        or
          AufgabenArbeitszeitWald.Arbeitszeit (EinheitRasseNummerExtern.Rasse, VorhandenerGrund.AktuellerGrund) = EinheitenKonstanten.UnmöglicheArbeit
      then
         return False;
         
      else
         VorhandeneVerbesserung := LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      end if;
                  
      -- Mehr Prüfungen einbauen, beispielweise keinen Wald auf Eis erlauben. Gilt für alle Aufgaben. äöü
      -- Kann jetzt über die Arbeitszeit geregelt werden. äöü
      if
        (VorhandeneVerbesserung = KartenVerbesserungDatentypen.Farm_Enum
         or
           VorhandeneVerbesserung = KartenVerbesserungDatentypen.Mine_Enum)
        and
          SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
      then
         case
           Auswahlaufteilungen.AuswahlJaNein (FrageZeileExtern => TextnummernKonstanten.FrageLandverbesserungErsetzen)
         is
            when True =>
               null;
            
            when False =>
               return False;
         end case;

      else
         null;
      end if;
            
      case
        VorhandenerGrund.AktuellerGrund
      is
         when KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range =>
            Arbeitswerte := OberflächeLand (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                             GrundExtern              => VorhandenerGrund,
                                             AnlegenTestenExtern      => AnlegenTestenExtern,
                                             KoordinatenExtern        => KoordinatenExtern);
            
         when KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum'Range =>
            Arbeitswerte := UnterflächeWasser (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                GrundExtern              => VorhandenerGrund,
                                                AnlegenTestenExtern      => AnlegenTestenExtern,
                                                KoordinatenExtern        => KoordinatenExtern);
            
         when others =>
            return False;
      end case;
      
      case
        Arbeitswerte.Aufgabe
      is
         when AufgabenDatentypen.Leer_Aufgabe_Enum =>
            return False;
            
         when AufgabenDatentypen.Wald_Aufforsten_Enum =>
            null;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "WaldErmitteln.WaldErmitteln - Falsche Aufgabe ausgewählt.");
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            if
              Arbeitswerte.Vorarbeit
            then
               SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 BeschäftigungExtern     => Arbeitswerte.Aufgabe);
               SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                      ZeitExtern               => Arbeitswerte.Arbeitszeit,
                                                                      RechnenSetzenExtern      => 0);
               
            else
               SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BeschäftigungExtern     => Arbeitswerte.Aufgabe);
               SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            ZeitExtern               => Arbeitswerte.Arbeitszeit,
                                                            RechnenSetzenExtern      => 0);
            end if;
            
         when False =>
            null;
      end case;
      
      return True;
      
   end WaldErmitteln;
   
   
   
   function OberflächeLand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartenRecords.KartengrundRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenRecords.ArbeitVorleistungRecord
   is begin
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => AufgabenArbeitszeitWald.Arbeitszeit (EinheitRasseNummerExtern.Rasse, GrundExtern.BasisGrund));
      
      if
        GrundExtern.BasisGrund = GrundExtern.AktuellerGrund
      then
         VorarbeitNötig := False;
         
      elsif
        True = AufgabeEinheitRoden.RodenErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   AnlegenTestenExtern      => AnlegenTestenExtern,
                                                   KoordinatenExtern        => KoordinatenExtern)
      then
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => AufgabenArbeitszeitWald.Arbeitszeit (EinheitRasseNummerExtern.Rasse, GrundExtern.AktuellerGrund));
         VorarbeitNötig := True;
         
      else
         return EinheitenRecordKonstanten.KeineArbeitVorleistung;
      end if;
      
      return (
              Aufgabe     => AufgabenDatentypen.Wald_Aufforsten_Enum,
              Arbeitszeit => Arbeitszeit,
              Vorarbeit   => VorarbeitNötig
             );
   
   end OberflächeLand;
     
     
     
   function UnterflächeWasser
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartenRecords.KartengrundRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenRecords.ArbeitVorleistungRecord
   is begin
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => AufgabenArbeitszeitWald.Arbeitszeit (EinheitRasseNummerExtern.Rasse, GrundExtern.BasisGrund));
      
      if
        GrundExtern.BasisGrund = GrundExtern.AktuellerGrund
      then
         VorarbeitNötig := False;
         
      elsif
        True = AufgabeEinheitRoden.RodenErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   AnlegenTestenExtern      => AnlegenTestenExtern,
                                                   KoordinatenExtern        => KoordinatenExtern)
      then
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => AufgabenArbeitszeitWald.Arbeitszeit (EinheitRasseNummerExtern.Rasse, GrundExtern.AktuellerGrund));
         VorarbeitNötig := True;
         
      else
         return EinheitenRecordKonstanten.KeineArbeitVorleistung;
      end if;
      
      return (
              Aufgabe     => AufgabenDatentypen.Wald_Aufforsten_Enum,
              Arbeitszeit => Arbeitszeit,
              Vorarbeit   => VorarbeitNötig
             );
      
   end UnterflächeWasser;

end AufgabeEinheitWald;
