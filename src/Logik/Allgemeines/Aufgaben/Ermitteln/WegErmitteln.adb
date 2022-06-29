pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with AufgabenDatentypen; use AufgabenDatentypen;
with ForschungenDatentypen; use ForschungenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenRecordKonstanten;

with SchreibeEinheitenGebaut;
with LeseKarten;
with LeseEinheitenGebaut;
with LeseWichtiges;

with Fehler;

package body WegErmitteln is
   
   function WegErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin

      case
        GrundExtern
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range =>
            Arbeitswerte := OberflächeLand (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                             GrundExtern              => GrundExtern);
            
         when KartengrundDatentypen.Kartengrund_Oberfläche_Wasser_Enum'Range =>
            Arbeitswerte := OberflächeWasser (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               GrundExtern              => GrundExtern);
            
         when KartengrundDatentypen.Untereis_Enum | KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum'Range =>
            Arbeitswerte := UnterflächeLand (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              GrundExtern              => GrundExtern);
            
         when KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum'Range =>
            Arbeitswerte := UnterflächeWasser (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                GrundExtern              => GrundExtern);
               
         when others =>
            return False;
      end case;
      
      case
        Arbeitswerte.WelcheArbeit
      is
         when AufgabenDatentypen.Leer_Aufgabe_Enum =>
            return False;
            
         when AufgabenDatentypen.Einheitenbefehle_Wege_Enum'Range =>
            null;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "WegErmitteln.WegErmitteln - Ungültige Aufgabe wurde ausgewählt.");
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => WelcheArbeit);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => Arbeitszeit,
                                                         RechnenSetzenExtern      => 0);
            
         when False =>
            null;
      end case;
      
      return True;
      
   end WegErmitteln;
   
   
   
   function OberflächeLand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Enum)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      WegVorhanden := LeseKarten.Weg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        WegVorhanden
      is
         when KartenVerbesserungDatentypen.Karten_Straße_Enum'Range | KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            if
              TechnologischeVoraussetzung (EinheitRasseNummerExtern.Rasse, WelcheWegart (WegVorhanden)) = 0
              or else
                LeseWichtiges.Erforscht (RasseExtern             => EinheitRasseNummerExtern.Rasse,
                                         WelcheTechnologieExtern => TechnologischeVoraussetzung (EinheitRasseNummerExtern.Rasse, WelcheWegart (WegVorhanden)))
              = True
            then
               WelcheArbeit := WelcheWegart (WegVorhanden);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Flachland_Enum | KartengrundDatentypen.Tundra_Enum | KartengrundDatentypen.Wüste_Enum | KartengrundDatentypen.Hügel_Enum
            | KartengrundDatentypen.Wald_Enum =>
            Arbeitszeit := Grundzeit + 2;

         when KartengrundDatentypen.Gebirge_Enum | KartengrundDatentypen.Dschungel_Enum | KartengrundDatentypen.Sumpf_Enum =>
            Arbeitszeit := Grundzeit + 5;

         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "WegErmitteln.OberflächeLand - Falscher Kartengrund.");
      end case;
      
      return (WelcheArbeit, Arbeitszeit);
   
   end OberflächeLand;

   
     
   function OberflächeWasser
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Wasser_Enum)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      WegVorhanden := LeseKarten.Weg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        WegVorhanden
      is
         when KartenVerbesserungDatentypen.Karten_Straße_Enum'Range | KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            if
              TechnologischeVoraussetzung (EinheitRasseNummerExtern.Rasse, WelcheWegart (WegVorhanden)) = 0
              or else
                LeseWichtiges.Erforscht (RasseExtern             => EinheitRasseNummerExtern.Rasse,
                                         WelcheTechnologieExtern => TechnologischeVoraussetzung (EinheitRasseNummerExtern.Rasse, WelcheWegart (WegVorhanden)))
              = True
            then
               WelcheArbeit := WelcheWegart (WegVorhanden);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Küstengewässer_Enum =>
            Arbeitszeit := Grundzeit + 2;

         when KartengrundDatentypen.Wasser_Enum =>
            Arbeitszeit := Grundzeit + 5;
      end case;
      
      return (WelcheArbeit, Arbeitszeit);
   
   end OberflächeWasser;
     
     
     
   function UnterflächeLand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Enum)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      WegVorhanden := LeseKarten.Weg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        WegVorhanden
      is
         when KartenVerbesserungDatentypen.Karten_Straße_Enum'Range | KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            if
              TechnologischeVoraussetzung (EinheitRasseNummerExtern.Rasse, WelcheWegart (WegVorhanden)) = 0
              or else
                LeseWichtiges.Erforscht (RasseExtern             => EinheitRasseNummerExtern.Rasse,
                                         WelcheTechnologieExtern => TechnologischeVoraussetzung (EinheitRasseNummerExtern.Rasse, WelcheWegart (WegVorhanden)))
              = True
            then
               WelcheArbeit := WelcheWegart (WegVorhanden);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Untereis_Enum | KartengrundDatentypen.Erde_Enum | KartengrundDatentypen.Erdgestein_Enum | KartengrundDatentypen.Sand_Enum =>
            Arbeitszeit := Grundzeit + 2;

         when KartengrundDatentypen.Gestein_Enum =>
            Arbeitszeit := Grundzeit + 5;

         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "WegErmitteln.OberflächeLand - Falscher Kartengrund.");
      end case;
      
      return (WelcheArbeit, Arbeitszeit);
      
   end UnterflächeLand;
     
     
     
   function UnterflächeWasser
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      WegVorhanden := LeseKarten.Weg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        WegVorhanden
      is
         when KartenVerbesserungDatentypen.Karten_Straße_Enum'Range | KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            if
              TechnologischeVoraussetzung (EinheitRasseNummerExtern.Rasse, WelcheWegart (WegVorhanden)) = 0
              or else
                LeseWichtiges.Erforscht (RasseExtern             => EinheitRasseNummerExtern.Rasse,
                                         WelcheTechnologieExtern => TechnologischeVoraussetzung (EinheitRasseNummerExtern.Rasse, WelcheWegart (WegVorhanden)))
              = True
            then
               WelcheArbeit := WelcheWegart (WegVorhanden);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Küstengrund_Enum | KartengrundDatentypen.Korallen_Enum | KartengrundDatentypen.Meeresgrund_Enum | KartengrundDatentypen.Unterwald_Enum =>
            Arbeitszeit := Grundzeit + 2;

            -- when KartengrundDatentypen. =>
            --    Arbeitszeit := Grundzeit + 5;
      end case;
      
      return (WelcheArbeit, Arbeitszeit);
   
   end UnterflächeWasser;

end WegErmitteln;
