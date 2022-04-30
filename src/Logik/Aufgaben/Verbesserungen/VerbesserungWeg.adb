pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;

with SchreibeEinheitenGebaut;
with LeseKarten;
with LeseEinheitenGebaut;
with LeseWichtiges;

with AufgabenAllgemein;
with Fehler;

package body VerbesserungWeg is
   
   function VerbesserungWeg
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin

      -------------------------- Das für alle Arbeiten vornehmen.
      case
        GrundExtern
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range =>
            if
              OberflächeLand (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                               GrundExtern              => GrundExtern)
              = False
            then
               return False;
                 
            else
               null;
            end if;
            
         when KartengrundDatentypen.Kartengrund_Oberfläche_Wasser_Enum'Range =>
            if
              OberflächeWasser (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 GrundExtern              => GrundExtern)
              = False
            then
               return False;
                 
            else
               null;
            end if;
            
         when KartengrundDatentypen.Untereis_Enum | KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum'Range =>
            if
              UnterflächeLand (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                GrundExtern              => GrundExtern)
              = False
            then
               return False;
                 
            else
               null;
            end if;
            
         when KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum'Range =>
            if
              UnterflächeWasser (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                  GrundExtern              => GrundExtern)
              = False
            then
               return False;
                 
            else
               null;
            end if;
               
         when others =>
            return False;
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            null;
            
         when False =>
            AufgabenAllgemein.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
      return True;
      
   end VerbesserungWeg;
   
   
   
   function OberflächeLand
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Enum)
      return Boolean
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
               return False;
            end if;
            
         when others =>
            return False;
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
            Fehler.LogikFehler (FehlermeldungExtern => "VerbesserungWeg.OberflächeLand - Falscher Kartengrund.");
      end case;
      
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern     => WelcheArbeit);
      SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   ZeitExtern               => Arbeitszeit,
                                                   RechnenSetzenExtern      => 0);
      
      return True;
   
   end OberflächeLand;

   
     
   function OberflächeWasser
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Wasser_Enum)
      return Boolean
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
               return False;
            end if;
            
         when others =>
            return False;
      end case;
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Küstengewässer_Enum =>
            Arbeitszeit := Grundzeit + 2;

         when KartengrundDatentypen.Wasser_Enum =>
            Arbeitszeit := Grundzeit + 5;
      end case;
      
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern     => WelcheArbeit);
      SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   ZeitExtern               => Arbeitszeit,
                                                   RechnenSetzenExtern      => 0);
      
      return True;
   
   end OberflächeWasser;
     
     
     
   function UnterflächeLand
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Enum)
      return Boolean
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
               return False;
            end if;
            
         when others =>
            return False;
      end case;
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Untereis_Enum | KartengrundDatentypen.Erde_Enum | KartengrundDatentypen.Erdgestein_Enum | KartengrundDatentypen.Sand_Enum =>
            Arbeitszeit := Grundzeit + 2;

         when KartengrundDatentypen.Gestein_Enum =>
            Arbeitszeit := Grundzeit + 5;

         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "VerbesserungWeg.OberflächeLand - Falscher Kartengrund.");
      end case;
      
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern     => WelcheArbeit);
      SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   ZeitExtern               => Arbeitszeit,
                                                   RechnenSetzenExtern      => 0);
      
      return True;
   
   end UnterflächeLand;
     
     
     
   function UnterflächeWasser
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum)
      return Boolean
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
               return False;
            end if;
            
         when others =>
            return False;
      end case;
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Küstengrund_Enum | KartengrundDatentypen.Korallen_Enum | KartengrundDatentypen.Meeresgrund_Enum | KartengrundDatentypen.Unterwald_Enum =>
            Arbeitszeit := Grundzeit + 2;

            -- when KartengrundDatentypen. =>
            --    Arbeitszeit := Grundzeit + 5;
      end case;
      
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern     => WelcheArbeit);
      SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   ZeitExtern               => Arbeitszeit,
                                                   RechnenSetzenExtern      => 0);
      
      return True;
   
   end UnterflächeWasser;

end VerbesserungWeg;
