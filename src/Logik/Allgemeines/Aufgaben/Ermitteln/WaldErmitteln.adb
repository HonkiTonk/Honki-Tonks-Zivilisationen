pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with RueckgabeDatentypen; use RueckgabeDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenRecordKonstanten;
with TextKonstanten;

with SchreibeEinheitenGebaut;
with LeseKarten;
with LeseEinheitenGebaut;

with RodenErmitteln;
with Fehler;
with Auswahl;

package body WaldErmitteln is

   function WaldErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      VorhandeneVerbesserung := LeseKarten.Verbesserung (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
            
      ------------------------------------ Mehr Prüfungen einbauen, beispielweise keinen Wald auf Eis erlauben. Gilt für alle Aufgaben.
      if
        (VorhandeneVerbesserung = KartenVerbesserungDatentypen.Farm_Enum
         or
           VorhandeneVerbesserung = KartenVerbesserungDatentypen.Mine_Enum)
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
      
      VorarbeitNötig := False;
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range =>
            Arbeitswerte := OberflächeLand (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                             GrundExtern              => GrundExtern,
                                             AnlegenTestenExtern      => AnlegenTestenExtern);
            
         when KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum'Range =>
            Arbeitswerte := UnterflächeWasser (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                GrundExtern              => GrundExtern,
                                                AnlegenTestenExtern      => AnlegenTestenExtern);
            
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
            Fehler.LogikFehler (FehlermeldungExtern => "WaldErmitteln.WaldErmitteln - Ungültige Aufgabe wurde ausgewählt.");
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            if
              VorarbeitNötig
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
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Enum;
      AnlegenTestenExtern : in Boolean)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum'Range =>
            Arbeitszeit := Grundzeit + 2;

         when KartengrundDatentypen.Dschungel_Enum | KartengrundDatentypen.Sumpf_Enum =>
            if
              RodenErmitteln.RodenErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                             GrundExtern              => GrundExtern,
                                             AnlegenTestenExtern      => AnlegenTestenExtern)
              = True
            then
               Arbeitszeit := Grundzeit + 2;
               VorarbeitNötig := True;
            
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
               
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
            
      return (AufgabenDatentypen.Wald_Aufforsten_Enum, Arbeitszeit);
   
   end OberflächeLand;
     
     
     
   function UnterflächeWasser
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum;
      AnlegenTestenExtern : in Boolean)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Meeresgrund_Enum | KartengrundDatentypen.Küstengrund_Enum =>
            Arbeitszeit := Grundzeit + 2;

         when KartengrundDatentypen.Korallen_Enum =>
            if
              RodenErmitteln.RodenErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                             GrundExtern              => GrundExtern,
                                             AnlegenTestenExtern      => AnlegenTestenExtern)
              = True
            then
               Arbeitszeit := Grundzeit + 2;
               VorarbeitNötig := True;
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
               
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
            
      return (AufgabenDatentypen.Wald_Aufforsten_Enum, Arbeitszeit);
   
   end UnterflächeWasser;

end WaldErmitteln;
