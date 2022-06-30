pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenRecordKonstanten;
with RueckgabeDatentypen;
with TextKonstanten;

with SchreibeEinheitenGebaut;
with LeseKarten;
with LeseEinheitenGebaut;

with Fehler;
with Auswahl;

package body FestungErmitteln is

   function FestungErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      VorhandeneVerbesserung := LeseKarten.Verbesserung (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
            
      if
        VorhandeneVerbesserung = KartenVerbesserungDatentypen.Festung_Enum
      then
         return False;

      elsif
        VorhandeneVerbesserung in KartenVerbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum'Range
        and
          SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
      then
         case
           Auswahl.AuswahlJaNein (FrageZeileExtern => TextKonstanten.FrageLandverbesserungErsetzen)
         is
            when RueckgabeDatentypen.Ja_Enum =>
               null;
                     
            when RueckgabeDatentypen.Nein_Enum =>
               return False;
         end case;

      else
         null;
      end if;
    
      case
        GrundExtern
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range =>
            Arbeitswerte := OberflächeLand (GrundExtern => GrundExtern);
            
         when KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum'Range =>
            Arbeitswerte := UnterflächeWasser (GrundExtern => GrundExtern);
            
         when KartengrundDatentypen.Untereis_Enum | KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum'Range =>
            Arbeitswerte := UnterflächeLand (GrundExtern => GrundExtern);
            
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
            Fehler.LogikFehler (FehlermeldungExtern => "FestungErmitteln.FestungErmitteln - Ungültige Aufgabe wurde ausgewählt.");
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
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Enum)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Flachland_Enum | KartengrundDatentypen.Tundra_Enum | KartengrundDatentypen.Wüste_Enum | KartengrundDatentypen.Hügel_Enum
            | KartengrundDatentypen.Wald_Enum | KartengrundDatentypen.Dschungel_Enum =>
            Arbeitszeit := Grundzeit + 2;
            
         when KartengrundDatentypen.Gebirge_Enum =>
            Arbeitszeit := Grundzeit + 5;
               
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
            
      return (AufgabenDatentypen.Festung_Bauen_Enum, Arbeitszeit);
   
   end OberflächeLand;
     
   
   
   function UnterflächeLand
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Enum)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Untereis_Enum | KartengrundDatentypen.Erde_Enum | KartengrundDatentypen.Erdgestein_Enum | KartengrundDatentypen.Sand_Enum =>
            Arbeitszeit := Grundzeit + 2;
            
         when KartengrundDatentypen.Gestein_Enum =>
            Arbeitszeit := Grundzeit + 5;
               
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
            
      return (AufgabenDatentypen.Festung_Bauen_Enum, Arbeitszeit);
      
   end UnterflächeLand;
     
     
     
   function UnterflächeWasser
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Unterwald_Enum | KartengrundDatentypen.Küstengrund_Enum | KartengrundDatentypen.Meeresgrund_Enum | KartengrundDatentypen.Korallen_Enum =>
            Arbeitszeit := Grundzeit + 2;
      end case;
            
      return (AufgabenDatentypen.Festung_Bauen_Enum, Arbeitszeit);
   
   end UnterflächeWasser;

end FestungErmitteln;
