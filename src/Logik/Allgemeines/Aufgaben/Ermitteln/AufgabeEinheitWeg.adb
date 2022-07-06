pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with AufgabenDatentypen; use AufgabenDatentypen;
with ForschungenDatentypen; use ForschungenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenRecordKonstanten;
with ForschungKonstanten;

with SchreibeEinheitenGebaut;
with LeseKarten;
with LeseWichtiges;

with Fehler;
with Grenzpruefungen;

package body AufgabeEinheitWeg is
   
   function WegErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      VorhandenerGrund := LeseKarten.VorhandenerGrund (KoordinatenExtern => KoordinatenExtern);
      WegVorhanden := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);

      case
        VorhandenerGrund.AktuellerGrund
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range =>
            Arbeitswerte := OberflächeLand (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                             WegExtern   => WegVorhanden,
                                             GrundExtern => VorhandenerGrund);
            
         when KartengrundDatentypen.Kartengrund_Oberfläche_Wasser_Enum'Range =>
            Arbeitswerte := OberflächeWasser (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                               WegExtern   => WegVorhanden,
                                               GrundExtern => VorhandenerGrund);
            
         when KartengrundDatentypen.Untereis_Enum | KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum'Range =>
            Arbeitswerte := UnterflächeLand (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                              WegExtern   => WegVorhanden,
                                              GrundExtern => VorhandenerGrund);
            
         when KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum'Range =>
            Arbeitswerte := UnterflächeWasser (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                WegExtern   => WegVorhanden,
                                                GrundExtern => VorhandenerGrund);
               
         when others =>
            return False;
      end case;
      
      case
        Arbeitswerte.Aufgabe
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
                                                    BeschäftigungExtern     => Arbeitswerte.Aufgabe);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => Arbeitswerte.Arbeitszeit,
                                                         RechnenSetzenExtern      => 0);
            
         when False =>
            null;
      end case;
      
      return True;
      
   end WegErmitteln;
   
   
   
   function OberflächeLand
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
            
      case
        WegExtern
      is
         when KartenVerbesserungDatentypen.Karten_Straße_Enum'Range | KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            if
              ForschungKonstanten.TechnologischeVoraussetzung (RasseExtern, WelcheWegart (WegExtern)) = ForschungKonstanten.LeerForschungAnforderung
              or else
                LeseWichtiges.Erforscht (RasseExtern             => RasseExtern,
                                         WelcheTechnologieExtern => ForschungKonstanten.TechnologischeVoraussetzung (RasseExtern, WelcheWegart (WegExtern)))
              = True
            then
               WelcheArbeit := WelcheWegart (WegExtern);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      Arbeitszeit := 1;
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                  ÄnderungExtern      => NötigteArbeitszeit (RasseExtern, GrundExtern.BasisGrund));

      if
        GrundExtern.BasisGrund = GrundExtern.AktuellerGrund
      then
         null;

      else
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => NötigteArbeitszeit (RasseExtern, GrundExtern.AktuellerGrund));
      end if;
      
      return (WelcheArbeit, Arbeitszeit);
   
   end OberflächeLand;

   
     
   function OberflächeWasser
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      if
        GrundExtern.AktuellerGrund = KartengrundDatentypen.Wasser_Enum
        and
          RasseExtern /= RassenDatentypen.Ekropa_Enum
      then
         return EinheitenRecordKonstanten.KeineArbeit;
         
      else
         null;
      end if;
      
      case
        WegExtern
      is
         when KartenVerbesserungDatentypen.Karten_Straße_Enum'Range | KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            if
              ForschungKonstanten.TechnologischeVoraussetzung (RasseExtern, WelcheWegart (WegExtern)) = ForschungKonstanten.LeerForschungAnforderung
              or else
                LeseWichtiges.Erforscht (RasseExtern             => RasseExtern,
                                         WelcheTechnologieExtern => ForschungKonstanten.TechnologischeVoraussetzung (RasseExtern, WelcheWegart (WegExtern)))
              = True
            then
               WelcheArbeit := WelcheWegart (WegExtern);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      Arbeitszeit := 1;
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                  ÄnderungExtern      => NötigteArbeitszeit (RasseExtern, GrundExtern.BasisGrund));

      if
        GrundExtern.BasisGrund = GrundExtern.AktuellerGrund
      then
         null;

      else
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => NötigteArbeitszeit (RasseExtern, GrundExtern.AktuellerGrund));
      end if;
      
      return (WelcheArbeit, Arbeitszeit);
   
   end OberflächeWasser;
     
     
     
   function UnterflächeLand
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      Arbeitszeit := 1;
      
      case
        WegExtern
      is
         when KartenVerbesserungDatentypen.Karten_Straße_Enum'Range | KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            if
              ForschungKonstanten.TechnologischeVoraussetzung (RasseExtern, WelcheWegart (WegExtern)) = ForschungKonstanten.LeerForschungAnforderung
              or else
                LeseWichtiges.Erforscht (RasseExtern             => RasseExtern,
                                         WelcheTechnologieExtern => ForschungKonstanten.TechnologischeVoraussetzung (RasseExtern, WelcheWegart (WegExtern)))
              = True
            then
               WelcheArbeit := WelcheWegart (WegExtern);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      Arbeitszeit := 1;
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                  ÄnderungExtern      => NötigteArbeitszeit (RasseExtern, GrundExtern.BasisGrund));

      if
        GrundExtern.BasisGrund = GrundExtern.AktuellerGrund
      then
         null;

      else
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => NötigteArbeitszeit (RasseExtern, GrundExtern.AktuellerGrund));
      end if;
      
      return (WelcheArbeit, Arbeitszeit);
      
   end UnterflächeLand;
     
     
     
   function UnterflächeWasser
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      Arbeitszeit := 1;
      
      case
        WegExtern
      is
         when KartenVerbesserungDatentypen.Karten_Straße_Enum'Range | KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            if
              ForschungKonstanten.TechnologischeVoraussetzung (RasseExtern, WelcheWegart (WegExtern)) = ForschungKonstanten.LeerForschungAnforderung
              or else
                LeseWichtiges.Erforscht (RasseExtern             => RasseExtern,
                                         WelcheTechnologieExtern => ForschungKonstanten.TechnologischeVoraussetzung (RasseExtern, WelcheWegart (WegExtern)))
              = True
            then
               WelcheArbeit := WelcheWegart (WegExtern);
               
            else
               return EinheitenRecordKonstanten.KeineArbeit;
            end if;
            
         when others =>
            return EinheitenRecordKonstanten.KeineArbeit;
      end case;
      
      Arbeitszeit := 1;
      Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                  ÄnderungExtern      => NötigteArbeitszeit (RasseExtern, GrundExtern.BasisGrund));

      if
        GrundExtern.BasisGrund = GrundExtern.AktuellerGrund
      then
         null;

      else
         Arbeitszeit := Grenzpruefungen.Arbeitszeit (AktuellerWertExtern => Arbeitszeit,
                                                     ÄnderungExtern      => NötigteArbeitszeit (RasseExtern, GrundExtern.AktuellerGrund));
      end if;
      
      return (WelcheArbeit, Arbeitszeit);
   
   end UnterflächeWasser;

end AufgabeEinheitWeg;
