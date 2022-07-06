pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenRecordKonstanten;

with SchreibeEinheitenGebaut;
with LeseKarten;
  
with Fehler;

package body AufgabeEinheitRoden is

   function RodenErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      VorhandenerGrund := LeseKarten.VorhandenerGrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        VorhandenerGrund.AktuellerGrund
      is
         when KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range =>
            Arbeitswerte := OberflächeLand (GrundExtern => VorhandenerGrund.AktuellerGrund);
            
         when KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum'Range =>
            Arbeitswerte := UnterflächeWasser (GrundExtern => VorhandenerGrund.AktuellerGrund);
            
         when others =>
            return False;
      end case;
      
      case
        Arbeitswerte.Aufgabe
      is
         when AufgabenDatentypen.Leer_Aufgabe_Enum =>
            return False;
            
         when AufgabenDatentypen.Roden_Trockenlegen_Enum =>
            null;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "RodenErmitteln.RodenErmitteln - Ungültige Aufgabe wurde ausgewählt.");
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
      
   end RodenErmitteln;
   
   
   
   function OberflächeLand
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Enum)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Wald_Enum | KartengrundDatentypen.Dschungel_Enum | KartengrundDatentypen.Sumpf_Enum =>
            Arbeitszeit := Grundzeit + 2;
               
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
            
      return (AufgabenDatentypen.Roden_Trockenlegen_Enum, Arbeitszeit);
      
   end OberflächeLand;
   
     
     
   function UnterflächeWasser
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Korallen_Enum | KartengrundDatentypen.Unterwald_Enum =>
            Arbeitszeit := Grundzeit + 2;
               
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
            
      return (AufgabenDatentypen.Roden_Trockenlegen_Enum, Arbeitszeit);
   
   end UnterflächeWasser;

end AufgabeEinheitRoden;
