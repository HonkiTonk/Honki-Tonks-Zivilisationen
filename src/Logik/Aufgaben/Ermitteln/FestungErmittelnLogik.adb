pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseKarten;

with Fehler;
with ArbeitszeitFestungLogik;
with Grenzpruefungen;

package body FestungErmittelnLogik is

   function FestungErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      VorhandenerGrund := LeseKarten.VorhandenerGrund (KoordinatenExtern => KoordinatenExtern);
      
      -- Nur auf Basisgrund prüfen? Müsste hierbei ausreichen. äöü
      if
        ArbeitszeitFestungLogik.Arbeitszeit (EinheitRasseNummerExtern.Rasse, VorhandenerGrund.BasisGrund) = EinheitenKonstanten.UnmöglicheArbeit
        or
          ArbeitszeitFestungLogik.Arbeitszeit (EinheitRasseNummerExtern.Rasse, VorhandenerGrund.AktuellerGrund) = EinheitenKonstanten.UnmöglicheArbeit
      then
         return False;
         
      else
         null;
      end if;
                
      case
        VorhandenerGrund.AktuellerGrund
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range =>
            Arbeitswerte := OberflächeLand (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                             GrundExtern => VorhandenerGrund);
            
         when KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum'Range =>
            Arbeitswerte := UnterflächeWasser (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                GrundExtern => VorhandenerGrund);
            
         when KartengrundDatentypen.Untereis_Enum | KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum'Range =>
            Arbeitswerte := UnterflächeLand (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                              GrundExtern => VorhandenerGrund);
            
         when others =>
            return False;
      end case;
      
      case
        Arbeitswerte.Aufgabe
      is
         when AufgabenDatentypen.Leer_Aufgabe_Enum =>
            return False;
            
         when AufgabenDatentypen.Festung_Bauen_Enum =>
            null;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "FestungErmitteln.FestungErmitteln - Falsche Aufgabe ausgewählt.");
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => Arbeitswerte.Aufgabe);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => Arbeitswerte.Arbeitszeit,
                                                         RechnenSetzenExtern      => 0);
            
         when False =>
            null;
      end case;
      
      return True;
      
   end FestungErmitteln;
   
   
   
   function OberflächeLand
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitFestungLogik.Arbeitszeit (RasseExtern, GrundExtern.BasisGrund));

      if
        GrundExtern.BasisGrund = GrundExtern.AktuellerGrund
      then
         null;

      else
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => ArbeitszeitFestungLogik.Arbeitszeit (RasseExtern, GrundExtern.AktuellerGrund));
      end if;
      
      return (
              Aufgabe     => AufgabenDatentypen.Festung_Bauen_Enum,
              Arbeitszeit => Arbeitszeit
             );
   
   end OberflächeLand;
     
   
   
   function UnterflächeLand
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitFestungLogik.Arbeitszeit (RasseExtern, GrundExtern.BasisGrund));

      if
        GrundExtern.BasisGrund = GrundExtern.AktuellerGrund
      then
         null;

      else
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => ArbeitszeitFestungLogik.Arbeitszeit (RasseExtern, GrundExtern.AktuellerGrund));
      end if;
      
      return (
              Aufgabe     => AufgabenDatentypen.Festung_Bauen_Enum,
              Arbeitszeit => Arbeitszeit
             );
      
   end UnterflächeLand;
     
     
     
   function UnterflächeWasser
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => EinheitenKonstanten.MinimaleArbeitszeit,
                                                  ÄnderungExtern      => ArbeitszeitFestungLogik.Arbeitszeit (RasseExtern, GrundExtern.BasisGrund));

      if
        GrundExtern.BasisGrund = GrundExtern.AktuellerGrund
      then
         null;

      else
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => ArbeitszeitFestungLogik.Arbeitszeit (RasseExtern, GrundExtern.AktuellerGrund));
      end if;
      
      return (
              Aufgabe     => AufgabenDatentypen.Festung_Bauen_Enum,
              Arbeitszeit => Arbeitszeit
             );
   
   end UnterflächeWasser;

end FestungErmittelnLogik;
